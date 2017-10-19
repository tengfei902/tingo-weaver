package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.biz.HrmService;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.HrmResourceDao;
import com.tingo.weaver.dao.KpCheckItemDao;
import com.tingo.weaver.dao.KpCheckItemDetailDao;
import com.tingo.weaver.dao.QingdanDao;
import com.tingo.weaver.model.gson.*;
import com.tingo.weaver.model.po.*;
import com.tingo.weaver.utils.Utils;
import com.tingo.weaver.utils.enums.Jd;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

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

    @Override
    public QingdanGson selectQdById(Integer id) {
        Qingdan qingdan = qingdanDao.selectByPrimaryKey(new BigDecimal(id));
        return new QingdanGson(qingdan.getId(),qingdan.getQingdanmc());
    }

    @Override
    public List<QingdanGson> selectQdList(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(new BigDecimal(jd));
        qingdans.stream().forEach(qingdan -> list.add(new QingdanGson(qingdan.getId(),qingdan.getQingdanmc())));
        return list;
    }

    @Override
    public List<QingdanDetailGson> selectQdDetail(Integer jd) {
        List<QingdanGson> list = new ArrayList<>();
        List<Qingdan> qingdans = qingdanDao.selectAvailableList(new BigDecimal(jd));

        return null;
    }

    @Override
    public List<KpZcGson> getKpZcGson(ZcListRequest zcListRequest) {
//        KpCheckItemPub kpCheckItemPub = new KpCheckItemPub();
//        if(!StringUtils.isEmpty(zcListRequest.getUserId())) {
//            HrmResource hrmResource = hrmResourceDao.selectByPrimaryKey(new BigDecimal(zcListRequest.getUserId()));
//            kpCheckItemPub.set
//        }
//        kpCheckItemPub.setQdId();
//        List<KpCheckItemPub> items = kpCheckItemPupDao.selectByPrimaryKey()
        return null;
    }

    @Override
    public List<CheckItemGson> getCheckItem(Long qdId) {

        List<KpCheckItem> items = kpCheckItemDao.selectByQdId(new BigDecimal(qdId));
        List<CheckItemGson> list = new ArrayList<>();
        items.stream().forEach(kpCheckItem -> list.add(convertItem2Gson(kpCheckItem)));

        return list;
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
        item.setJd(new BigDecimal(Utils.getCurrentSeason()));
        item.setKpfs(itemGson.getKpfs());

        item.setQdId(new BigDecimal(itemGson.getQdId()));

        Qingdan qingdan = qingdanDao.selectByPrimaryKey(item.getQdId());
        item.setQd(qingdan.getQingdanmc());

        if(itemGson.getItemId()!= null) {
            item.setId(new BigDecimal(itemGson.getItemId()));
        }

        List<KpCheckItemDetail> details = new ArrayList<>();

        for(CheckItemDetailGson detailGson: itemGson.getDetails()) {
            KpCheckItemDetail detail = new KpCheckItemDetail();
            detail.setJd(new BigDecimal(Utils.getCurrentSeason()));
            detail.setPfbz(detailGson.getPfbz());
            detail.setFs(detailGson.getFs());
            detail.setTkxz(detailGson.getTkxz());
            detail.setId(detailGson.getDetailId() == null?null:new BigDecimal(detailGson.getDetailId()));
            if(itemGson.getItemId()!= null) {
                detail.setItemId(new BigDecimal(itemGson.getItemId()));
            }
        }

        checkItemService.saveCheckItem(item,details);
    }
}
