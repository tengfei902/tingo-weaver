package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.HrmResource;
import java.math.BigDecimal;

public interface HrmResourceDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(HrmResource record);

    int insertSelective(HrmResource record);

    HrmResource selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(HrmResource record);

    int updateByPrimaryKey(HrmResource record);
}