package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.dao.*;
import com.tingo.weaver.model.po.*;
import com.tingo.weaver.utils.enums.PfType;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
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
    public void publishItem(String qdId, Integer jd, List<String> companyIds) {
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

                kpCheckItemZpDao.insertSelective(kpCheckItemZp);

                for(KpCheckItemDetail detail:itemDetails) {
                    KpCheckItemDetailZp kpCheckItemDetailZp = new KpCheckItemDetailZp();
                    kpCheckItemDetailZp.setItemId(new BigDecimal(item.getId()));
                    kpCheckItemDetailZp.setOrgId(new BigDecimal(companyId));
                    kpCheckItemDetailZp.setDetailId(new BigDecimal(detail.getId()));
                    kpCheckItemDetailZp.setZpId(kpCheckItemZp.getId());

                    kpCheckItemDetailZpDao.insertSelective(kpCheckItemDetailZp);
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

                    kpCheckItemPfDao.insertSelective(kpCheckItemPf);

                    for(KpCheckItemDetail detail:itemDetails) {
                        KpCheckItemDetailPf kpCheckItemDetailPf = new KpCheckItemDetailPf();
                        kpCheckItemDetailPf.setToOrgId(new BigDecimal(companyId));
                        kpCheckItemDetailPf.setItemId(new BigDecimal(item.getId()));
                        kpCheckItemDetailPf.setOrgId(new BigDecimal(orgId));
                        kpCheckItemDetailPf.setItemDetailId(new BigDecimal(detail.getId()));
                        kpCheckItemDetailPf.setZpId(kpCheckItemZp.getId());
                        kpCheckItemDetailPf.setPfId(kpCheckItemPf.getId());

                        kpCheckItemDetailPfDao.insertSelective(kpCheckItemDetailPf);
                    }
                }
            }
        }
    }
}
