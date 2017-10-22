package com.tingo.weaver.model.gson;

import java.util.List;

/**
 * Created by user on 17/10/18.
 */
public class ZcListGson {
    private Long zpId;
    private Long itemId;
    private Long orgId;
    private String orgName;
    private Long qdId;
    private String qd;
    private String kpnr;
    private String jd;
    private int status;
    private String statusDesc;
    private String zpsm;
    private List<ZcDetailListGson> details;

    public Long getZpId() {
        return zpId;
    }

    public void setZpId(Long zpId) {
        this.zpId = zpId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Long getQdId() {
        return qdId;
    }

    public void setQdId(Long qdId) {
        this.qdId = qdId;
    }

    public String getQd() {
        return qd;
    }

    public void setQd(String qd) {
        this.qd = qd;
    }

    public String getKpnr() {
        return kpnr;
    }

    public void setKpnr(String kpnr) {
        this.kpnr = kpnr;
    }

    public String getJd() {
        return jd;
    }

    public void setJd(String jd) {
        this.jd = jd;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getZpsm() {
        return zpsm;
    }

    public void setZpsm(String zpsm) {
        this.zpsm = zpsm;
    }

    public List<ZcDetailListGson> getDetails() {
        return details;
    }

    public void setDetails(List<ZcDetailListGson> details) {
        this.details = details;
    }
}
