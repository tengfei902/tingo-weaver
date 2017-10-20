package com.tingo.weaver;

import com.tingo.BaseTestCase;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.KpCheckItemDao;
import com.tingo.weaver.model.po.KpCheckItem;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Administrator on 2017/10/20.
 */
public class ItemTest extends BaseTestCase {
    @Autowired
    private KpService kpService;
    @Autowired
    private KpCheckItemDao kpCheckItemDao;

    @Test
    public void testPublish() {
        Long userId = 1000L;
        List<String> qdIds = Arrays.asList("5","6");
        Integer jd = 4;
        List<String> companyIds = Arrays.asList("12","15","15");
        kpService.doPublish(userId,qdIds,jd,companyIds);
    }
}
