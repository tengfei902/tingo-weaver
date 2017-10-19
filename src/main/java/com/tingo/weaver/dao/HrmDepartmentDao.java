package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.HrmDepartment;
import java.math.BigDecimal;

public interface HrmDepartmentDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(HrmDepartment record);

    int insertSelective(HrmDepartment record);

    HrmDepartment selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(HrmDepartment record);

    int updateByPrimaryKey(HrmDepartment record);
}