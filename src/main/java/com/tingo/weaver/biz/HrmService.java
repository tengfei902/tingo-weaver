package com.tingo.weaver.biz;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by Administrator on 2017/10/18.
 */
public interface HrmService {

    List<String> getDebtName(List<BigDecimal> ids);
}
