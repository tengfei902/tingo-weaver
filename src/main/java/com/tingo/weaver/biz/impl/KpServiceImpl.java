package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.HrmResourceDao;
import com.tingo.weaver.dao.QingdanDao;
import com.tingo.weaver.model.gson.KpZcGson;
import com.tingo.weaver.model.gson.QingdanDetailGson;
import com.tingo.weaver.model.gson.QingdanGson;
import com.tingo.weaver.model.gson.ZcListRequest;
import com.tingo.weaver.model.po.HrmResource;
import com.tingo.weaver.model.po.KpCheckItemPub;
import com.tingo.weaver.model.po.Qingdan;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/10/18.
 */
@Service
public class KpServiceImpl implements KpService {
    @Autowired
    private QingdanDao qingdanDao;

    @Autowired
    private HrmResourceDao hrmResourceDao;

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
}
