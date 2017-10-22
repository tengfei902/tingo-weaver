package com.tingo.weaver;

import com.google.gson.Gson;
import com.tingo.BaseTestCase;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.dao.KpCheckItemDao;
import com.tingo.weaver.dao.KpCheckItemZpDao;
import com.tingo.weaver.model.gson.ZcListGson;
import com.tingo.weaver.model.gson.ZcListRequest;
import com.tingo.weaver.model.po.KpCheckItemZp;
import com.tingo.weaver.utils.MapUtils;
import junit.framework.Assert;
import org.apache.commons.collections.CollectionUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/10/20.
 */
public class ItemTest extends BaseTestCase {
    @Autowired
    private KpService kpService;
    @Autowired
    private KpCheckItemDao kpCheckItemDao;
    @Autowired
    private KpCheckItemZpDao kpCheckItemZpDao;

    @Test
    public void testPublish() {
        Long userId = 1000L;
        List<String> qdIds = Arrays.asList("5","6");
        Integer jd = 4;
        List<String> companyIds = Arrays.asList("12","15","15");
        String result = kpService.doPublish(userId,qdIds,jd,companyIds);

        System.out.println(result);

        result = kpService.doPublish(userId,qdIds,jd,companyIds);

        System.out.println(result);
    }

    @Test
    public void testGetZpList() {
        ZcListRequest request = new ZcListRequest();
        request.setQd("6");
        request.setJd("4");
        request.setStatus("0");
        request.setUserId("123");
        List<ZcListGson> list = kpService.getKpZcGson(request);

        Assert.assertTrue(CollectionUtils.isEmpty(list));

        request.setUserId("1243");
        list = kpService.getKpZcGson(request);
        System.out.println(new Gson().toJson(list));

        request.setJd("3");
        list = kpService.getKpZcGson(request);
        Assert.assertTrue(CollectionUtils.isEmpty(list));

        request.setJd("4");
        request.setStatus("1");
        list = kpService.getKpZcGson(request);
        Assert.assertTrue(CollectionUtils.isEmpty(list));
    }

    @Test
    public void testGetZpItemList() {
        Map<String,Object> params = MapUtils.buildMap("orgIds",Arrays.asList(6L,5L),"qdId",6L,"jd",4);
        List<KpCheckItemZp> zps = kpCheckItemZpDao.selectForList(params);
    }
}
