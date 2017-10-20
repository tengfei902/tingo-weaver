package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailZp;
import java.math.BigDecimal;

public interface KpCheckItemDetailZpDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailZp record);

    int insertSelective(KpCheckItemDetailZp record);

    KpCheckItemDetailZp selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailZp record);

    int updateByPrimaryKey(KpCheckItemDetailZp record);
}