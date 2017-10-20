package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemZp;
import java.math.BigDecimal;

public interface KpCheckItemZpDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemZp record);

    int insertSelective(KpCheckItemZp record);

    KpCheckItemZp selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemZp record);

    int updateByPrimaryKey(KpCheckItemZp record);
}