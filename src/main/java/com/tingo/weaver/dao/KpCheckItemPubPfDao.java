package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemPubPf;
import java.math.BigDecimal;

public interface KpCheckItemPubPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemPubPf record);

    int insertSelective(KpCheckItemPubPf record);

    KpCheckItemPubPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemPubPf record);

    int updateByPrimaryKey(KpCheckItemPubPf record);
}