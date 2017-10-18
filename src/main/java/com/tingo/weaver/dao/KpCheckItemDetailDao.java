package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetail;
import java.math.BigDecimal;

public interface KpCheckItemDetailDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetail record);

    int insertSelective(KpCheckItemDetail record);

    KpCheckItemDetail selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetail record);

    int updateByPrimaryKey(KpCheckItemDetail record);
}