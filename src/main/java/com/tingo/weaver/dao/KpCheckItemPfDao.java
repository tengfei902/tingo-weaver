package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemPf;
import java.math.BigDecimal;

public interface KpCheckItemPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemPf record);

    int insertSelective(KpCheckItemPf record);

    KpCheckItemPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemPf record);

    int updateByPrimaryKey(KpCheckItemPf record);
}