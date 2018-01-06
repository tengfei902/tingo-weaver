package com.tingo.weaver.biz;

import com.tingo.weaver.model.po.HrmDepartment;
import com.tingo.weaver.model.po.HrmSubCompany;
import com.tingo.weaver.model.po.KpCheckItem;
import com.tingo.weaver.model.po.KpCheckItemDetail;

import java.math.BigDecimal;

/**
 * Created by user on 17/10/22.
 */
public interface CacheService {

    HrmDepartment getDept(BigDecimal deptId);
    KpCheckItemDetail getItemDetail(BigDecimal detailId);
    KpCheckItem getItem(BigDecimal itemId);
    HrmSubCompany getCompany(BigDecimal id);
}
