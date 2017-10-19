package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.HrmDepartment;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface HrmDepartmentDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(HrmDepartment record);

    int insertSelective(HrmDepartment record);

    HrmDepartment selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(HrmDepartment record);

    int updateByPrimaryKey(HrmDepartment record);

    List<HrmDepartment> selectByIds(@Param("ids") List<BigDecimal> ids);
}