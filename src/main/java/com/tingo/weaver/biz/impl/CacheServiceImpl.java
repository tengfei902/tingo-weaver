package com.tingo.weaver.biz.impl;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.tingo.weaver.biz.CacheService;
import com.tingo.weaver.dao.HrmDepartmentDao;
import com.tingo.weaver.dao.HrmSubCompanyDao;
import com.tingo.weaver.dao.KpCheckItemDao;
import com.tingo.weaver.dao.KpCheckItemDetailDao;
import com.tingo.weaver.model.po.HrmDepartment;
import com.tingo.weaver.model.po.HrmSubCompany;
import com.tingo.weaver.model.po.KpCheckItem;
import com.tingo.weaver.model.po.KpCheckItemDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.concurrent.TimeUnit;

/**
 * Created by user on 17/10/22.
 */
@Service
public class CacheServiceImpl implements CacheService {
    @Autowired
    private KpCheckItemDetailDao kpCheckItemDetailDao;
    @Autowired
    private KpCheckItemDao kpCheckItemDao;
    @Autowired
    private HrmSubCompanyDao hrmSubCompanyDao;
    @Autowired
    private HrmDepartmentDao hrmDepartmentDao;

    private LoadingCache<BigDecimal,KpCheckItemDetail> itemDetailCache = CacheBuilder.newBuilder()
            .expireAfterAccess(10, TimeUnit.MINUTES)
            .maximumSize(1000)
            .refreshAfterWrite(10,TimeUnit.MINUTES)
            .build(new CacheLoader<BigDecimal, KpCheckItemDetail>() {
                @Override
                public KpCheckItemDetail load(BigDecimal id) throws Exception {
                    return kpCheckItemDetailDao.selectByPrimaryKey(id.longValue());
                }
            });

    private LoadingCache<BigDecimal,KpCheckItem> itemCache = CacheBuilder.newBuilder()
            .expireAfterAccess(10, TimeUnit.MINUTES)
            .maximumSize(1000)
            .refreshAfterWrite(10,TimeUnit.MINUTES)
            .build(new CacheLoader<BigDecimal, KpCheckItem>() {
                @Override
                public KpCheckItem load(BigDecimal id) throws Exception {
                    return kpCheckItemDao.selectByPrimaryKey(id.longValue());
                }
            });

    private LoadingCache<BigDecimal,HrmSubCompany> companyCache = CacheBuilder.newBuilder()
            .expireAfterAccess(10, TimeUnit.MINUTES)
            .maximumSize(1000)
            .refreshAfterWrite(10,TimeUnit.MINUTES)
            .build(new CacheLoader<BigDecimal, HrmSubCompany>() {
                @Override
                public HrmSubCompany load(BigDecimal id) throws Exception {
                    return hrmSubCompanyDao.selectByPrimaryKey(id);
                }
            });

    private LoadingCache<BigDecimal,HrmDepartment> departmentCache = CacheBuilder.newBuilder().expireAfterAccess(10,TimeUnit.MINUTES).maximumSize(1000).refreshAfterWrite(10,TimeUnit.MINUTES).
            build(new CacheLoader<BigDecimal, HrmDepartment>() {
                @Override
                public HrmDepartment load(BigDecimal id) throws Exception {
                    return hrmDepartmentDao.selectByPrimaryKey(id);
                }
            });

    @Override
    public HrmDepartment getDept(BigDecimal deptId) {
        try {
            return departmentCache.get(deptId);
        } catch (Exception e) {
            return null;
        }

    }

    @Override
    public KpCheckItemDetail getItemDetail(BigDecimal detailId) {
        try {
            return itemDetailCache.get(detailId);
        } catch (Exception e){
            return null;
        }
    }

    public KpCheckItem getItem(BigDecimal itemId) {
        try {
            return itemCache.get(itemId);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public HrmSubCompany getCompany(BigDecimal id) {
        try {
            return companyCache.get(id);
        } catch (Exception e) {
            return null;
        }
    }
}
