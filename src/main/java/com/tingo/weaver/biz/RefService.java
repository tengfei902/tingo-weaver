package com.tingo.weaver.biz;

/**
 * Created by user on 17/10/17.
 */
public interface RefService {
    String getSubCompanyname(Long id);
    boolean checkSex(String sex);
    boolean checkDateSeason(String currentSeason);
}
