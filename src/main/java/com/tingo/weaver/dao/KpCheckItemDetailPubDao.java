package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailPub;
import java.math.BigDecimal;

public interface KpCheckItemDetailPubDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailPub record);

    int insertSelective(KpCheckItemDetailPub record);

    KpCheckItemDetailPub selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailPub record);

    int updateByPrimaryKey(KpCheckItemDetailPub record);
}