package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CacheService;
import com.tingo.weaver.model.po.HrmDepartment;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * Created by user on 17/10/22.
 */
@Service
public class CacheServiceImpl implements CacheService {

    @Override
    public HrmDepartment getDept(BigDecimal deptId) {
        return null;
    }
}
