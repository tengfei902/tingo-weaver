package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CacheService;
import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.biz.HrmService;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.*;
import com.tingo.weaver.model.gson.*;
import com.tingo.weaver.model.po.*;
import com.tingo.weaver.utils.MapUtils;
import com.tingo.weaver.utils.Utils;
import com.tingo.weaver.utils.enums.Jd;
import com.tingo.weaver.utils.enums.PfStatus;
import com.tingo.weaver.utils.enums.PfType;
import com.tingo.weaver.utils.enums.ZpStatus;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.util.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    @Autowired
    private DeptUserLinkDao deptUserLinkDao;
    @Autowired
    private KpCheckItemPfDao kpCheckItemPfDao;
    @Autowired
    private KpCheckItemDetailPfDao kpCheckItemDetailPfDao;
    @Autowired
    private HrmDepartmentDao hrmDepartmentDao;
    @Autowired
    private CacheService cacheService;

    @Override
    public QingdanGson selectQdById(Integer id) {
        Qingdan qingdan = qingdanDao.selectByPrimaryKey(Long.valueOf(id));
        if(Objects.isNull(qingdan)) {
            return new QingdanGson();
        }
        return new QingdanGson(qingdan.getId(),qingdan.getQingdanmc(),qingdan.getJd());
    }

    @Override
    public List<QingdanGson> selectQdList(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(jd,null);
        qingdans.stream().forEach(qingdan -> list.add(new QingdanGson(qingdan.getId(),qingdan.getQingdanmc(),qingdan.getJd())));
        return list;
    }

    @Override
    public List<QingdanGson> selectQdList(String yearStr, Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(jd,yearStr);
        qingdans.stream().forEach(qingdan -> list.add(new QingdanGson(qingdan.getId(),qingdan.getQingdanmc(),qingdan.getJd())));
        return list;
    }

    @Override
    public List<QingdanDetailGson> selectQdDetail(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(jd,null);
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

    @Transactional
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
            kpCheckItemPfDao.updateStatusSelfChecked(itemZp.getItemId());
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

    @Override
    public List<PfListGson> getKpList(ZcListRequest zcListRequest) {
        List<PfListGson> result = new ArrayList<>();

        List<DeptUserLink> links = deptUserLinkDao.selectByUserId(new BigDecimal(zcListRequest.getUserId()));
        List<BigDecimal> deptIds = links.stream().map(DeptUserLink::getDeptid).collect(Collectors.toList());

        if(CollectionUtils.isEmpty(deptIds)) {
            return result;
        }

        List<BigDecimal> toOrgIds = new ArrayList<>();

        if(StringUtils.isNoneBlank(zcListRequest.getCompanyids())) {
            for(String companyid:zcListRequest.getCompanyids().split(",")) {
                if(!StringUtils.isEmpty(companyid)) {
                    toOrgIds.add(new BigDecimal(companyid));
                }
            }
        }

        Map<String,Object> params = MapUtils.buildMap("orgIds",deptIds,"jd",zcListRequest.getJd(),"status",zcListRequest.getStatus(),"qdId",zcListRequest.getQd(),"toOrgIds",toOrgIds);
        List<KpCheckItemPf> pfs = kpCheckItemPfDao.selectForList(params);

        if(CollectionUtils.isEmpty(pfs)) {
            return result;
        }

        Set<Long> itemIds = pfs.stream().map(KpCheckItemPf::getItemId).map(BigDecimal::longValue).collect(Collectors.toSet());
        List<KpCheckItem> items = kpCheckItemDao.selectByIds(itemIds);

        Map<Long,KpCheckItem> itemMap = items.stream().collect(Collectors.toMap(KpCheckItem::getId,Function.identity()));

        Set<BigDecimal> zpIds = pfs.stream().map(KpCheckItemPf::getZpId).collect(Collectors.toSet());
        List<KpCheckItemZp> zps = kpCheckItemZpDao.selectForList(MapUtils.buildMap("ids",zpIds));

        Map<BigDecimal,KpCheckItemZp> zpMap = zps.stream().collect(Collectors.toMap(KpCheckItemZp::getId,Function.identity()));

        List<KpCheckItemDetail> itemDetails = kpCheckItemDetailDao.selectByItemIds(itemIds);
        Map<Long,KpCheckItemDetail> itemDetailMap = itemDetails.stream().collect(Collectors.toMap(KpCheckItemDetail::getId,Function.identity()));

        List<KpCheckItemDetailZp> detailZps = kpCheckItemDetailZpDao.selectByZpIds(zpIds);
        Map<String,KpCheckItemDetailZp> zpDetailMap = detailZps.stream().collect(Collectors.toMap(kpCheckItemDetailZp -> String.format("%s_%s",kpCheckItemDetailZp.getDetailId(),kpCheckItemDetailZp.getOrgId()),Function.identity()));

        List<HrmDepartment> departments = hrmDepartmentDao.selectByIds(deptIds);
        Map<BigDecimal,HrmDepartment> deptMap = departments.stream().collect(Collectors.toMap(HrmDepartment::getId,Function.identity()));

        List<BigDecimal> companyIds = pfs.stream().map(KpCheckItemPf::getToOrgId).collect(Collectors.toList());
        List<HrmSubCompany> companies = hrmSubCompanyDao.selectByIds(companyIds);
        Map<BigDecimal,HrmSubCompany> subCompanyMap = companies.stream().collect(Collectors.toMap(HrmSubCompany::getId,Function.identity()));

        if(CollectionUtils.isEmpty(pfs)) {
            return result;
        }

        for (KpCheckItemPf pf:pfs) {
            PfListGson pfListGson = new PfListGson();
            result.add(pfListGson);

            KpCheckItem kpCheckItem = itemMap.get(pf.getItemId().longValue());
            KpCheckItemZp zp = zpMap.get(pf.getZpId());

            pfListGson.setQdId(pf.getQdId());
            pfListGson.setQd(pf.getQd());
            pfListGson.setJd(String.valueOf(pf.getJd()));
            pfListGson.setItemId(pf.getItemId().longValue());
            pfListGson.setKpnr(kpCheckItem.getKpnr());
            pfListGson.setOrgId(pf.getOrgId().longValue());
            pfListGson.setOrgName(deptMap.get(pf.getOrgId()).getDepartmentname());
            pfListGson.setPfId(pf.getId().longValue());
            pfListGson.setPfsm(pf.getPfsm());
            pfListGson.setStatus(pf.getStatus().intValue());
            pfListGson.setStatusDesc(PfStatus.parse(pf.getStatus().intValue()).getDesc());
            pfListGson.setToOrgId(pf.getToOrgId().longValue());
            pfListGson.setToOrgName(subCompanyMap.get(pf.getToOrgId()).getSubcompanyname());
            pfListGson.setZpId(pf.getZpId().longValue());
            pfListGson.setZpsm(zp.getZpsm());
            pfListGson.setZpStatus(zp.getStatus().intValue());
            pfListGson.setZpStatusDesc(ZpStatus.parse(zp.getStatus().intValue()).getDesc());

            List<PfDetailListGson> pfDetails = new ArrayList<>();
            pfListGson.setDetails(pfDetails);

            List<KpCheckItemDetailPf> details = kpCheckItemDetailPfDao.selectByPfId(pf.getId());
            for(KpCheckItemDetailPf detailPf : details) {
                KpCheckItemDetail detail = itemDetailMap.get(detailPf.getItemDetailId().longValue());
                KpCheckItemDetailZp detailZp = zpDetailMap.get(String.format("%s_%s",detailPf.getItemDetailId(),detailPf.getToOrgId()));

                PfDetailListGson pfDetail = new PfDetailListGson();
                pfDetail.setZpId(detailPf.getZpId().longValue());
                pfDetail.setFz(detail.getFs());
                pfDetail.setItemDetailId(detail.getId());
                pfDetail.setItemId(detailPf.getItemId().longValue());
                pfDetail.setKpDetailId(detailPf.getId().longValue());
                pfDetail.setKpId(detailPf.getPfId().longValue());
                pfDetail.setPf(detailPf.getPf());
                pfDetail.setPfbz(detail.getPfbz());
                pfDetail.setTkxz(detail.getTkxz());
                pfDetail.setZpf(detailZp.getPf());

                pfDetails.add(pfDetail);
            }
        }

        return result;
    }

    @Transactional
    @Override
    public void savePf(List<Map<String, String>> pfs, List<Map<String, String>> details) {
        for(Map<String,String> pf:pfs) {
            KpCheckItemPf kpCheckItemPf = kpCheckItemPfDao.selectByPrimaryKey(new BigDecimal(pf.get("pfId")));
            if(PfStatus.parse(kpCheckItemPf.getStatus().intValue())!= PfStatus.SELF_MARKED) {
                continue;
            }

            KpCheckItemPf itemPf = new KpCheckItemPf();
            itemPf.setId(new BigDecimal(pf.get("pfId")));
            itemPf.setPfsm(pf.get("pfsm"));
            kpCheckItemPfDao.updateByPrimaryKeySelective(itemPf);
        }

        for(Map<String,String> detail:details) {
            KpCheckItemDetailPf detailPf = kpCheckItemDetailPfDao.selectByPrimaryKey(new BigDecimal(detail.get("detailId")));
            KpCheckItemPf kpCheckItemPf = kpCheckItemPfDao.selectByPrimaryKey(detailPf.getPfId());
            if(PfStatus.parse(kpCheckItemPf.getStatus().intValue())!= PfStatus.SELF_MARKED) {
                continue;
            }

            KpCheckItemDetailPf kpCheckItemDetailPf = new KpCheckItemDetailPf();
            kpCheckItemDetailPf.setId(new BigDecimal(detail.get("detailId")));
            kpCheckItemDetailPf.setPf(new BigDecimal(detail.get("Kpf")));
            kpCheckItemDetailPfDao.updateByPrimaryKeySelective(kpCheckItemDetailPf);
        }
    }

    @Transactional
    @Override
    public void submitPf(List<Map<String, String>> pfs, List<Map<String, String>> details) {
        for(Map<String,String> pf:pfs) {
            KpCheckItemPf itemPf = kpCheckItemPfDao.selectByPrimaryKey(new BigDecimal(pf.get("pfId")));
            if(PfStatus.parse(itemPf.getStatus().intValue()) != PfStatus.SELF_MARKED) {
                continue;
            }
            KpCheckItemPf kpCheckItemPf = new KpCheckItemPf();
            kpCheckItemPf.setId(itemPf.getId());
            kpCheckItemPf.setPfsm(pf.get("pfsm"));
            kpCheckItemPf.setKpTime(new Date());
            kpCheckItemPf.setStatus(new BigDecimal(PfStatus.MARKED.getValue()));
            kpCheckItemPfDao.updateByPrimaryKeySelective(kpCheckItemPf);
        }

        for(Map<String,String> detail:details) {
            KpCheckItemDetailPf detailPf = kpCheckItemDetailPfDao.selectByPrimaryKey(new BigDecimal(detail.get("detailId")));
            KpCheckItemPf kpCheckItemPf = kpCheckItemPfDao.selectByPrimaryKey(detailPf.getPfId());
            if(PfStatus.SELF_MARKED != PfStatus.parse(kpCheckItemPf.getStatus().intValue())) {
                continue;
            }
            KpCheckItemDetailPf kpCheckItemDetailPf = new KpCheckItemDetailPf();
            kpCheckItemDetailPf.setId(detailPf.getId());
            kpCheckItemDetailPf.setPf(new BigDecimal(detail.get("zpf")));
            kpCheckItemDetailPf.setKpTime(new Date());
            kpCheckItemDetailPfDao.updateByPrimaryKeySelective(kpCheckItemDetailPf);
        }
    }

    @Override
    public List<CheckItemGson> getCheckResult(String userId, String yearStr,String jd, String qdId) {
        List<Qingdan> qds = qingdanDao.select(MapUtils.buildMap("yearStr",yearStr,"jd",jd,"qdId",qdId));
        if(CollectionUtils.isEmpty(qds)) {
            return Collections.EMPTY_LIST;
        }

        List<CompanyUserLink> links = companyUserLinkDao.selectByUserId(new BigDecimal(userId));
        List<BigDecimal> companyIds = links.parallelStream().map(CompanyUserLink::getCompanyid).collect(Collectors.toList());

        List<CheckItemGson> resultList = new ArrayList<>();

        for(Qingdan qd:qds) {
            List<KpCheckItem> items = kpCheckItemDao.selectByQdId(qd.getId());
            List<CheckItemGson> list = new ArrayList<>();
            items.stream().forEach(kpCheckItem -> list.add(convertItem2Gson(kpCheckItem)));

            List<KpCheckItemZp> kpCheckItemZps = kpCheckItemZpDao.selectForList(MapUtils.buildMap("qdId", qd.getId(), "orgIds", companyIds));
            for (KpCheckItemZp zp : kpCheckItemZps) {

                KpCheckItem kpCheckItem = kpCheckItemDao.selectByPrimaryKey(zp.getItemId().longValue());

                CheckItemGson checkItemGson = new CheckItemGson();
                resultList.add(checkItemGson);
                checkItemGson.setItemId(zp.getItemId().longValue());
                checkItemGson.setJd(String.format("第%s季度", zp.getJd()));
                checkItemGson.setKpfs(kpCheckItem.getKpfs());
                checkItemGson.setKpnr(kpCheckItem.getKpnr());
                checkItemGson.setQd(kpCheckItem.getQd());
                checkItemGson.setQdId(kpCheckItem.getQdId());
                checkItemGson.setPfbmId(String.valueOf(zp.getOrgId()));
                HrmSubCompany company = cacheService.getCompany(zp.getOrgId());
                checkItemGson.setPfbm(company.getSubcompanyname());

                List<CheckItemDetailGson> detailGsons = new ArrayList<>();
                checkItemGson.setDetails(detailGsons);

                KpCheckItemZp kpCheckItemZp = kpCheckItemZpDao.selectByUnq(new BigDecimal(kpCheckItem.getId()),company.getId());
                checkItemGson.setZpsm(kpCheckItemZp.getZpsm());

                List<KpCheckItemDetailZp> kpCheckItemDetailZps = kpCheckItemDetailZpDao.selectByZpId(zp.getId());
                for (KpCheckItemDetailZp kpCheckItemDetailZp : kpCheckItemDetailZps) {
                    CheckItemDetailGson checkItemDetailGson = new CheckItemDetailGson();
                    KpCheckItemDetail detail = kpCheckItemDetailDao.selectByPrimaryKey(kpCheckItemDetailZp.getDetailId().longValue());
                    detailGsons.add(checkItemDetailGson);
                    checkItemDetailGson.setDetailId(kpCheckItemDetailZp.getDetailId().longValue());
                    checkItemDetailGson.setPfbz(detail.getPfbz());
                    checkItemDetailGson.setTkxz(detail.getTkxz());
                    ZpGson zpGson = new ZpGson();
                    zpGson.setOrgId(zp.getOrgId().longValue());
                    zpGson.setZpf(kpCheckItemDetailZp.getPf());
                    zpGson.setZpStatus(ZpStatus.parse(zp.getStatus().intValue()).getDesc());
                    checkItemDetailGson.setZp(zpGson);

                    List<KpCheckItemDetailPf> pfs = kpCheckItemDetailPfDao.selectByDetailId(new BigDecimal(detail.getId()), zp.getOrgId());
                    List<PfGson> pfGsons = new ArrayList<>();
                    Map<BigDecimal,KpCheckItemPf> pfMap = new HashMap<>();

                    for (KpCheckItemDetailPf pf : pfs) {
                        PfGson pfGson = new PfGson();
                        pfGsons.add(pfGson);
                        pfGson.setItemDetailId(pf.getItemDetailId().longValue());
                        HrmDepartment org = cacheService.getDept(pf.getOrgId());
                        pfGson.setOrg(org.getDepartmentname());
                        pfGson.setOrgId(org.getId().longValue());
                        HrmSubCompany toOrg = cacheService.getCompany(pf.getToOrgId());
                        pfGson.setToOrg(toOrg.getSubcompanyname());
                        pfGson.setToOrgId(toOrg.getId().longValue());
                        pfGson.setPf(pf.getPf());
                        if(null == pfMap.get(pf.getPfId())) {
                            KpCheckItemPf kpCheckItemPf = kpCheckItemPfDao.selectByPrimaryKey(pf.getPfId());
                            pfMap.put(kpCheckItemPf.getId(),kpCheckItemPf);
                        }

                        pfGson.setPfStatus(PfStatus.parse(pfMap.get(pf.getPfId()).getStatus().intValue()).getDesc() );
                        pfGson.setPfsm(pfMap.get(pf.getPfId()).getPfsm()    );
                    }
                    checkItemDetailGson.setPfs(pfGsons);
                }

            }
        }
        return resultList;
    }
}
