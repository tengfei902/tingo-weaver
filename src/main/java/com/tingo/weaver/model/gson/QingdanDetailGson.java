package com.tingo.weaver.model.gson;

/**
 * Created by user on 17/10/18.
 */
public class QingdanDetailGson extends QingdanGson {

    private String canZp;
    private String canPf;

    public QingdanDetailGson(Long id, String qingdanmc) {
        super(id, qingdanmc);
    }

    public String getCanZp() {
        return canZp;
    }

    public void setCanZp(String canZp) {
        this.canZp = canZp;
    }

    public String getCanPf() {
        return canPf;
    }

    public void setCanPf(String canPf) {
        this.canPf = canPf;
    }
}
