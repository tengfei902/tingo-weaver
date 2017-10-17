package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.Qingdan;
import java.math.BigDecimal;

public interface QingdanDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(Qingdan record);

    int insertSelective(Qingdan record);

    Qingdan selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(Qingdan record);

    int updateByPrimaryKey(Qingdan record);
}