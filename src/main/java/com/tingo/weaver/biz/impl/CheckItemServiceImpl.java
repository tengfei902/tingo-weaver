package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.dao.KpCheckItemDao;
import com.tingo.weaver.dao.KpCheckItemDetailDao;
import com.tingo.weaver.model.po.KpCheckItem;
import com.tingo.weaver.model.po.KpCheckItemDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
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
}
