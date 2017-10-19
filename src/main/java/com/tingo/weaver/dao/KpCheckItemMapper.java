package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItem;
import java.math.BigDecimal;

public interface KpCheckItemMapper {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItem record);

    int insertSelective(KpCheckItem record);

    KpCheckItem selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItem record);

    int updateByPrimaryKey(KpCheckItem record);
}