package com.tingo.weaver.biz;

import com.tingo.weaver.model.po.HrmDepartment;

import java.math.BigDecimal;

/**
 * Created by user on 17/10/22.
 */
public interface CacheService {

    HrmDepartment getDept(BigDecimal deptId);
}
