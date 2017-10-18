package com.tingo.weaver.model.gson;

/**
 * Created by Administrator on 2017/10/18.
 */
public class QingdanGson {

    private Long id;
    private String qingdanmc;

    public QingdanGson(Long id ,String qingdanmc) {
        this.id = id;
        this.qingdanmc = qingdanmc;
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
}
