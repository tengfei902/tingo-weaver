package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.dao.*;
import com.tingo.weaver.model.po.*;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.util.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by user on 17/10/19.
 */
@Service
public class CheckItemServiceImpl implements CheckItemService {
    @Autowired
    private KpCheckItemDao kpCheckItemDao;
    @Autowired
    private KpCheckItemDetailDao kpCheckItemDetailDao;
    @Autowired
    private KpCheckItemZpDao kpCheckItemZpDao;
    @Autowired
    private KpCheckItemDetailZpDao kpCheckItemDetailZpDao;
    @Autowired
    private KpCheckItemPfDao kpCheckItemPfDao;
    @Autowired
    private KpCheckItemDetailPfDao kpCheckItemDetailPfDao;
    @Autowired
    private QingdanDao qingdanDao;

    @Transactional
    @Override
    public void saveCheckItem(KpCheckItem item, List<KpCheckItemDetail> details) {
        if(Objects.isNull(item.getId()) || item.getId()<=0) {
            kpCheckItemDao.insertSelective(item);
        } else {
            kpCheckItemDao.updateByPrimaryKeySelective(item);
        }

        for (KpCheckItemDetail detail : details) {
            if(Objects.isNull(detail.getId()) || detail.getId()<=0) {
                detail.setItemId(item.getId());
                kpCheckItemDetailDao.insertSelective(detail);
            } else {
                kpCheckItemDetailDao.updateByPrimaryKeySelective(detail);
            }

        }
    }
    @Transactional
    @Override
    public synchronized Map<String,List<String>> publishItem(String qdId, Integer jd, List<String> companyIds) {
        Map<String,List<String>> result = com.tingo.weaver.utils.MapUtils.buildMap("zp",new ArrayList<>(),"zpd",new ArrayList<>(),"kp",new ArrayList<>(),"kpd",new ArrayList<>());
        List<KpCheckItem> items = kpCheckItemDao.selectByQdId(Long.parseLong(qdId));
        for(KpCheckItem item:items) {
            List<KpCheckItemDetail> itemDetails = kpCheckItemDetailDao.selectByItemId(item.getId());
            for(String companyId:companyIds) {
                if(StringUtils.isEmpty(companyId)) {
                    continue;
                }
                KpCheckItemZp kpCheckItemZp = new KpCheckItemZp();
                kpCheckItemZp.setOrgId(new BigDecimal(companyId));
                kpCheckItemZp.setItemId(new BigDecimal(item.getId()));
                kpCheckItemZp.setJd(new BigDecimal(jd));
                kpCheckItemZp.setQd(item.getQd());
                kpCheckItemZp.setQdId(new BigDecimal(item.getQdId()));

                try {
                    kpCheckItemZpDao.insertSelective(kpCheckItemZp);
                    result.get("zp").add(String.valueOf(kpCheckItemZp.getId()));
                } catch (DuplicateKeyException e) {
                    kpCheckItemZp = kpCheckItemZpDao.selectByUnq(kpCheckItemZp.getItemId(),kpCheckItemZp.getOrgId());
                }

                for(KpCheckItemDetail detail:itemDetails) {
                    KpCheckItemDetailZp kpCheckItemDetailZp = new KpCheckItemDetailZp();
                    kpCheckItemDetailZp.setItemId(new BigDecimal(item.getId()));
                    kpCheckItemDetailZp.setOrgId(new BigDecimal(companyId));
                    kpCheckItemDetailZp.setDetailId(new BigDecimal(detail.getId()));
                    kpCheckItemDetailZp.setZpId(kpCheckItemZp.getId());

                    try {
                        kpCheckItemDetailZpDao.insertSelective(kpCheckItemDetailZp);
                        result.get("zpd").add(String.valueOf(kpCheckItemDetailZp.getId()));
                    } catch (DuplicateKeyException e) {
//                        kpCheckItemDetailZp = kpCheckItemDetailZpDao.selectByUnq(kpCheckItemDetailZp.getDetailId(),kpCheckItemDetailZp.getOrgId());
                    }
                }

                for(String orgId:item.getPfbm().split(",")) {
                    if(StringUtils.isEmpty(orgId)) {
                        continue;
                    }

                    KpCheckItemPf kpCheckItemPf = new KpCheckItemPf();
                    kpCheckItemPf.setZpId(kpCheckItemZp.getId());
                    kpCheckItemPf.setOrgId(new BigDecimal(orgId));
                    kpCheckItemPf.setItemId(new BigDecimal(item.getId()));
                    kpCheckItemPf.setJd(new BigDecimal(jd));
                    kpCheckItemPf.setToOrgId(new BigDecimal(companyId));
                    kpCheckItemPf.setQdId(item.getQdId());
                    kpCheckItemPf.setQd(item.getQd());

                    try {
                        kpCheckItemPfDao.insertSelective(kpCheckItemPf);
                        result.get("kp").add(String.valueOf(kpCheckItemPf.getId()));
                    } catch (DuplicateKeyException e) {
                        kpCheckItemPf = kpCheckItemPfDao.selectByUnq(kpCheckItemPf.getItemId(),kpCheckItemPf.getOrgId(),kpCheckItemPf.getToOrgId());
                    }

                    for(KpCheckItemDetail detail:itemDetails) {
                        KpCheckItemDetailPf kpCheckItemDetailPf = new KpCheckItemDetailPf();
                        kpCheckItemDetailPf.setToOrgId(new BigDecimal(companyId));
                        kpCheckItemDetailPf.setItemId(new BigDecimal(item.getId()));
                        kpCheckItemDetailPf.setOrgId(new BigDecimal(orgId));
                        kpCheckItemDetailPf.setItemDetailId(new BigDecimal(detail.getId()));
                        kpCheckItemDetailPf.setZpId(kpCheckItemZp.getId());
                        kpCheckItemDetailPf.setPfId(kpCheckItemPf.getId());

                        try {
                            kpCheckItemDetailPfDao.insertSelective(kpCheckItemDetailPf);
                            result.get("kpd").add(String.valueOf(kpCheckItemDetailPf.getId()));
                        }catch (DuplicateKeyException e) {

                        }
                    }
                }
            }
        }

        return result;
    }

    @Transactional
    @Override
    public void saveQingdan(String qdid, Qingdan qingdan) {
        qingdanDao.insertSelective(qingdan);
        if(StringUtils.isEmpty(qdid)) {
            return;
        }

        List<KpCheckItem> items = kpCheckItemDao.selectByQdId(Long.parseLong(qdid));
        if(CollectionUtils.isEmpty(items)) {
            return;
        }

        items.parallelStream().forEach(kpCheckItem -> {
            KpCheckItem item = new KpCheckItem();
            item.setJd(qingdan.getJd());
            item.setQd(qingdan.getQingdanmc());
            item.setQdId(qingdan.getId());
            item.setKpfs(kpCheckItem.getKpfs());
            item.setKpnr(kpCheckItem.getKpnr());
            item.setPfbm(kpCheckItem.getPfbm());

            kpCheckItemDao.insertSelective(item);

            List<KpCheckItemDetail> details = kpCheckItemDetailDao.selectByItemId(kpCheckItem.getId());
            details.parallelStream().forEach(kpCheckItemDetail -> {
                KpCheckItemDetail detail = new KpCheckItemDetail();
                detail.setItemId(item.getId());
                detail.setJd(item.getJd());
                detail.setFs(kpCheckItemDetail.getFs());
                detail.setPfbz(kpCheckItemDetail.getPfbz());
                detail.setTkxz(kpCheckItemDetail.getTkxz());

                kpCheckItemDetailDao.insertSelective(detail);
            });
        });
    }
}
