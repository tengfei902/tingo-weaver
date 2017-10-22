package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.HrmSubCompany;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface HrmSubCompanyDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(HrmSubCompany record);

    int insertSelective(HrmSubCompany record);

    HrmSubCompany selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(HrmSubCompany record);

    int updateByPrimaryKey(HrmSubCompany record);

    List<HrmSubCompany> selectByIds(@Param("ids") List<BigDecimal> ids);
}