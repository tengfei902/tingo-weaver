package com.tingo.weaver.model.gson;

/**
 * Created by user on 17/10/18.
 */
public class ZcListRequest {
    private String userId;
    private String status;
    private String jd;
    private String qd;
    private String companyids;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getJd() {
        return jd;
    }

    public void setJd(String jd) {
        this.jd = jd;
    }

    public String getQd() {
        return qd;
    }

    public void setQd(String qd) {
        this.qd = qd;
    }

    public String getCompanyids() {
        return companyids;
    }

    public void setCompanyids(String companyids) {
        this.companyids = companyids;
    }
}
