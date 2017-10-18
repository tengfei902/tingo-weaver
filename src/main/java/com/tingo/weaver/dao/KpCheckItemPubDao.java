package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemPub;
import java.math.BigDecimal;

public interface KpCheckItemPubDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemPub record);

    int insertSelective(KpCheckItemPub record);

    KpCheckItemPub selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemPub record);

    int updateByPrimaryKey(KpCheckItemPub record);
}