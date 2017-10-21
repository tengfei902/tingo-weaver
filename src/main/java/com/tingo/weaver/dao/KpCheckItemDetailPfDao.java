package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailPf;
import java.math.BigDecimal;

public interface KpCheckItemDetailPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailPf record);

    int insertSelective(KpCheckItemDetailPf record);

    KpCheckItemDetailPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailPf record);

    int updateByPrimaryKey(KpCheckItemDetailPf record);
}