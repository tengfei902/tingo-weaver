package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailPubPf;
import java.math.BigDecimal;

public interface KpCheckItemDetailPubPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailPubPf record);

    int insertSelective(KpCheckItemDetailPubPf record);

    KpCheckItemDetailPubPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailPubPf record);

    int updateByPrimaryKey(KpCheckItemDetailPubPf record);
}