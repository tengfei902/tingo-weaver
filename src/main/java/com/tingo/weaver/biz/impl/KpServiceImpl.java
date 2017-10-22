package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.biz.HrmService;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.*;
import com.tingo.weaver.model.gson.*;
import com.tingo.weaver.model.po.*;
import com.tingo.weaver.utils.MapUtils;
import com.tingo.weaver.utils.Utils;
import com.tingo.weaver.utils.enums.Jd;
import com.tingo.weaver.utils.enums.PfType;
import com.tingo.weaver.utils.enums.ZpStatus;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.util.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/10/18.
 */
@Service
public class KpServiceImpl implements KpService {
    @Autowired
    private QingdanDao qingdanDao;
    @Autowired
    private HrmResourceDao hrmResourceDao;
    @Autowired
    private KpCheckItemDao kpCheckItemDao;
    @Autowired
    private KpCheckItemDetailDao kpCheckItemDetailDao;
    @Autowired
    private HrmService hrmService;
    @Autowired
    private CheckItemService checkItemService;
    @Autowired
    private CompanyUserLinkDao companyUserLinkDao;
    @Autowired
    private KpCheckItemZpDao kpCheckItemZpDao;
    @Autowired
    private KpCheckItemDetailZpDao kpCheckItemDetailZpDao;
    @Autowired
    private HrmSubCompanyDao hrmSubCompanyDao;

    @Override
    public QingdanGson selectQdById(Integer id) {
        Qingdan qingdan = qingdanDao.selectByPrimaryKey(Long.valueOf(id));
        if(Objects.isNull(qingdan)) {
            return new QingdanGson();
        }
        return new QingdanGson(qingdan.getId(),qingdan.getQingdanmc());
    }

    @Override
    public List<QingdanGson> selectQdList(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(jd);
        qingdans.stream().forEach(qingdan -> list.add(new QingdanGson(qingdan.getId(),qingdan.getQingdanmc())));
        return list;
    }

    @Override
    public List<QingdanDetailGson> selectQdDetail(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(jd);
        return null;
    }

    @Override
    public List<ZcListGson> getKpZcGson(ZcListRequest zcListRequest) {
        List<ZcListGson> zcListGsons = new ArrayList<>();
        List<CompanyUserLink> userLinks = companyUserLinkDao.selectByUserId(new BigDecimal(zcListRequest.getUserId()));
        if(CollectionUtils.isEmpty(userLinks)) {
            return Collections.EMPTY_LIST;
        }
        List<BigDecimal> orgIds = userLinks.stream().map(CompanyUserLink::getCompanyid).collect(Collectors.toList());
        Map<String,Object> params = MapUtils.buildMap("orgIds",orgIds,"qdId",zcListRequest.getQd(),"jd",zcListRequest.getJd(),"status",zcListRequest.getStatus());
        List<KpCheckItemZp> zps = kpCheckItemZpDao.selectForList(params);
        if(CollectionUtils.isEmpty(zps)) {
            return Collections.EMPTY_LIST;
        }

        Set<Long> itemIds = zps.stream().map(KpCheckItemZp::getItemId).map(BigDecimal::longValue).collect(Collectors.toSet());
        List<KpCheckItem> items = kpCheckItemDao.selectByIds(itemIds);

        Map<Long,KpCheckItem> itemMap = items.stream().collect(Collectors.toMap(KpCheckItem::getId, Function.<KpCheckItem>identity()));

        List<KpCheckItemDetail> itemDetails = kpCheckItemDetailDao.selectByItemIds(itemIds);
        Map<Long,KpCheckItemDetail> itemDetailMap = itemDetails.stream().collect(Collectors.toMap(KpCheckItemDetail::getId, Function.identity()));

        List<BigDecimal> companyIds = userLinks.stream().map(CompanyUserLink::getCompanyid).collect(Collectors.toList());
        List<HrmSubCompany> companies = hrmSubCompanyDao.selectByIds(companyIds);
        Map<BigDecimal,HrmSubCompany> companyMap = companies.stream().collect(Collectors.toMap(HrmSubCompany::getId, Function.identity()));

        for(KpCheckItemZp zp:zps) {
            ZcListGson zc = new ZcListGson();
            zcListGsons.add(zc);

            KpCheckItem item = itemMap.get(zp.getItemId().longValue());

            zc.setJd(Jd.parse(zp.getJd().intValue()).getDesc());
            zc.setItemId(zp.getItemId().longValue());
            zc.setZpsm(zp.getZpsm());
            zc.setKpnr(item.getKpnr());
            zc.setOrgId(zp.getOrgId().longValue());
            zc.setOrgName(companyMap.get(zp.getOrgId()).getSubcompanyname());
            zc.setQd(item.getQd());
            zc.setQdId(item.getQdId());
            zc.setStatus(zp.getStatus().intValue());
            zc.setStatusDesc(ZpStatus.parse(zp.getStatus().intValue()).getDesc());
            zc.setZpId(zp.getId().longValue());

            List<ZcDetailListGson> zcDetailListGsons = new ArrayList<>();
            zc.setDetails(zcDetailListGsons);

            List<KpCheckItemDetailZp> kpCheckItemDetailZps = kpCheckItemDetailZpDao.selectByZpId(zp.getId());
            for(KpCheckItemDetailZp detailZp:kpCheckItemDetailZps) {
                ZcDetailListGson zcDetailListGson = new ZcDetailListGson();
                zcDetailListGsons.add(zcDetailListGson);

                KpCheckItemDetail itemDetail = itemDetailMap.get(detailZp.getDetailId().longValue());
                zcDetailListGson.setFz(itemDetail.getFs());
                zcDetailListGson.setItemDetailId(itemDetail.getId());
                zcDetailListGson.setPfbz(itemDetail.getPfbz());
                zcDetailListGson.setTkxz(itemDetail.getTkxz());
                zcDetailListGson.setZpDetailId(detailZp.getId().longValue());
                zcDetailListGson.setZpf(detailZp.getPf());
            }
        }
        return zcListGsons;
    }

    @Override
    public List<CheckItemGson> getCheckItem(Long qdId) {

        List<KpCheckItem> items = kpCheckItemDao.selectByQdId(qdId);
        List<CheckItemGson> list = new ArrayList<>();
        items.stream().forEach(kpCheckItem -> list.add(convertItem2Gson(kpCheckItem)));

        return list;
    }

    @Override
    public CheckItemGson getCheckItemByItemId(Long itemId) {
        KpCheckItem kpCheckItem = kpCheckItemDao.selectByPrimaryKey(itemId);
        CheckItemGson checkItemGson = convertItem2Gson(kpCheckItem);
        return checkItemGson;
    }

    private CheckItemGson convertItem2Gson(KpCheckItem item) {
        CheckItemGson checkItemGson = new CheckItemGson();
        checkItemGson.setItemId(item.getId().longValue());
        checkItemGson.setJd(Jd.parse(item.getJd().intValue()).getDesc());
        checkItemGson.setKpfs(item.getKpfs());
        checkItemGson.setKpnr(item.getKpnr());
        List<String> debts = Arrays.asList(item.getPfbm().split(","));

        List<BigDecimal> debtList = new ArrayList<>();
        for(String debt:debts) {
            if(StringUtils.isEmpty(debt)) {
                continue;
            }
            debtList.add(new BigDecimal(debt));
        }

        List<String> debtNames = hrmService.getDebtName(debtList);
        StringBuilder debtName = new StringBuilder();
        debtNames.stream().forEach(s -> debtName.append(s));

        checkItemGson.setPfbm(debtName.toString());
        checkItemGson.setPfbmId(item.getPfbm());

        checkItemGson.setQdId(item.getQdId().longValue());
        checkItemGson.setQd(item.getQd());

        List<KpCheckItemDetail> details = kpCheckItemDetailDao.selectByItemId(item.getId());

        List<CheckItemDetailGson> detailGsons = new ArrayList<>();

        checkItemGson.setDetails(detailGsons);

        for(KpCheckItemDetail detail:details) {

            CheckItemDetailGson detailGson = new CheckItemDetailGson();
            detailGson.setDetailId(detail.getId().longValue());
            detailGson.setFs(detail.getFs());
            detailGson.setPfbz(detail.getPfbz());
            detailGson.setTkxz(detail.getTkxz());

            detailGsons.add(detailGson);
        }
        return checkItemGson;
    }

    @Override
    public void saveCheckItem(CheckItemGson itemGson) {
        KpCheckItem item = new KpCheckItem();
        item.setPfbm(itemGson.getPfbm());
        item.setKpnr(itemGson.getKpnr());
        item.setJd(Utils.getCurrentSeason());
        item.setKpfs(itemGson.getKpfs());

        item.setQdId(itemGson.getQdId());

        Qingdan qingdan = qingdanDao.selectByPrimaryKey(item.getQdId());
        item.setQd(qingdan.getQingdanmc());

        if(itemGson.getItemId()!= null) {
            item.setId(itemGson.getItemId());
        }

        List<KpCheckItemDetail> details = new ArrayList<>();

        for(CheckItemDetailGson detailGson: itemGson.getDetails()) {
            KpCheckItemDetail detail = new KpCheckItemDetail();
            detail.setJd(Utils.getCurrentSeason());
            detail.setPfbz(detailGson.getPfbz());
            detail.setFs(detailGson.getFs());
            detail.setTkxz(detailGson.getTkxz());
            detail.setId(detailGson.getDetailId() == null?null:detailGson.getDetailId());
            if(itemGson.getItemId()!= null) {
                detail.setItemId(itemGson.getItemId());
            }

            details.add(detail);
        }

        checkItemService.saveCheckItem(item,details);
    }

    @Override
    public String doPublish(Long userId, List<String> qdIds, Integer kpMonth, List<String> companyIds) {
        List<Map<String,List<String>>> list = new ArrayList<>();
        qdIds.stream().forEach(s -> {
            list.add(checkItemService.publishItem(s, kpMonth, companyIds));
        });
        return new com.google.gson.Gson().toJson(list);
    }

    @Override
    public void saveZp(List<Map<String, String>> zps,List<Map<String, String>> details) {
        for(Map<String,String> zp:zps) {
            KpCheckItemZp itemZp = kpCheckItemZpDao.selectByPrimaryKey(new BigDecimal(zp.get("zpId")));
            if(ZpStatus.parse(itemZp.getStatus().intValue())== ZpStatus.CHECKED) {
                continue;
            }

            KpCheckItemZp kpCheckItemZp = new KpCheckItemZp();
            kpCheckItemZp.setId(new BigDecimal(zp.get("zpId")));
            kpCheckItemZp.setZpsm(zp.get("zpsm"));
            kpCheckItemZpDao.updateByPrimaryKeySelective(kpCheckItemZp);
        }

        for(Map<String,String> detail:details) {
            KpCheckItemDetailZp detailZp = kpCheckItemDetailZpDao.selectByPrimaryKey(new BigDecimal(detail.get("detailId")));
            KpCheckItemZp itemZp = kpCheckItemZpDao.selectByPrimaryKey(detailZp.getZpId());
            if(ZpStatus.parse(itemZp.getStatus().intValue())== ZpStatus.CHECKED) {
                continue;
            }

            KpCheckItemDetailZp kpCheckItemDetailZp = new KpCheckItemDetailZp();
            kpCheckItemDetailZp.setId(new BigDecimal(detail.get("detailId")));
            kpCheckItemDetailZp.setPf(new BigDecimal(detail.get("zpf")));
            kpCheckItemDetailZpDao.updateByPrimaryKeySelective(kpCheckItemDetailZp);
        }
    }

    @Override
    public void submitZp(List<Map<String, String>> zps, List<Map<String, String>> details) {
        for(Map<String,String> zp:zps) {
            KpCheckItemZp itemZp = kpCheckItemZpDao.selectByPrimaryKey(new BigDecimal(zp.get("zpId")));
            if(ZpStatus.parse(itemZp.getStatus().intValue())== ZpStatus.CHECKED) {
                continue;
            }

            KpCheckItemZp kpCheckItemZp = new KpCheckItemZp();
            kpCheckItemZp.setId(new BigDecimal(zp.get("zpId")));
            kpCheckItemZp.setZpsm(zp.get("zpsm"));
            kpCheckItemZp.setZpTime(new Date());
            kpCheckItemZp.setStatus(new BigDecimal(ZpStatus.CHECKED.getValue()));
            kpCheckItemZpDao.updateByPrimaryKeySelective(kpCheckItemZp);
        }

        for(Map<String,String> detail:details) {
            KpCheckItemDetailZp detailZp = kpCheckItemDetailZpDao.selectByPrimaryKey(new BigDecimal(detail.get("detailId")));
            KpCheckItemZp itemZp = kpCheckItemZpDao.selectByPrimaryKey(detailZp.getZpId());
            if(ZpStatus.parse(itemZp.getStatus().intValue())== ZpStatus.CHECKED) {
                continue;
            }

            KpCheckItemDetailZp kpCheckItemDetailZp = new KpCheckItemDetailZp();
            kpCheckItemDetailZp.setId(new BigDecimal(detail.get("detailId")));
            kpCheckItemDetailZp.setPf(new BigDecimal(detail.get("zpf")));
            kpCheckItemDetailZp.setZpTime(new Date());
            kpCheckItemDetailZpDao.updateByPrimaryKeySelective(kpCheckItemDetailZp);
        }
    }
}
