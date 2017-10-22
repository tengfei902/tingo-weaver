package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.HrmSubCompany;
import java.math.BigDecimal;

public interface HrmSubCompanyDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(HrmSubCompany record);

    int insertSelective(HrmSubCompany record);

    HrmSubCompany selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(HrmSubCompany record);

    int updateByPrimaryKey(HrmSubCompany record);
}