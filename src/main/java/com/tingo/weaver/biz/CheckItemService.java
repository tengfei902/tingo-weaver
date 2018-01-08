package com.tingo.weaver.biz;

import com.tingo.weaver.model.po.KpCheckItem;
import com.tingo.weaver.model.po.KpCheckItemDetail;
import com.tingo.weaver.model.po.Qingdan;

import java.util.List;
import java.util.Map;

/**
 * Created by user on 17/10/19.
 */
public interface CheckItemService {

    void saveCheckItem(KpCheckItem item, List<KpCheckItemDetail> details);

    Map<String,List<String>> publishItem(String qdId, Integer jd, List<String> companyIds);

    void saveQingdan(String qdid,Qingdan qingdan);
}
