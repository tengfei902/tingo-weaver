package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.DebtSale;

public interface DebtSaleDao {
    int deleteByPrimaryKey(Long id);

    int insert(DebtSale record);

    int insertSelective(DebtSale record);

    DebtSale selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(DebtSale record);

    int updateByPrimaryKey(DebtSale record);
}