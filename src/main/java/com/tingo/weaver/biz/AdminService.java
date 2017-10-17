package com.tingo.weaver.biz;

import com.tingo.weaver.model.po.Qingdan;

/**
 * Created by user on 17/10/16.
 */
public interface AdminService {

    Long saveQingdan(Qingdan qingdan);

    void updateQingdanValid(Long id);

    void updateQingdanInvalid(Long id);


}
