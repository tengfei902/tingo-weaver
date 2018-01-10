package com.tingo.weaver.model.gson;

/**
 * Created by Administrator on 2017/10/18.
 */
public class QingdanGson {

    private Long id;
    private String qingdanmc;
    private int jd;

    public QingdanGson() {

    }

    public QingdanGson(Long id ,String qingdanmc,int jd) {
        this.id = id;
        this.qingdanmc = qingdanmc;
        this.jd = jd;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQingdanmc() {
        return qingdanmc;
    }

    public void setQingdanmc(String qingdanmc) {
        this.qingdanmc = qingdanmc;
    }

    public int getJd() {
        return jd;
    }

    public void setJd(int jd) {
        this.jd = jd;
    }
}
