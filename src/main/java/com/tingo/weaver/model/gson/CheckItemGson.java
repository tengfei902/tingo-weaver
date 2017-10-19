package com.tingo.weaver.model.gson;

import java.util.List;

/**
 * Created by user on 17/10/19.
 */
public class CheckItemGson {

    private Long itemId;
    private Long qdId;
    private String qd;
    private String kpnr;
    private String kpfs;
    private String pfbm;
    private String jd;
    private List<CheckItemDetailGson> details;

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Long getQdId() {
        return qdId;
    }

    public void setQdId(Long qdId) {
        this.qdId = qdId;
    }

    public String getKpnr() {
        return kpnr;
    }

    public void setKpnr(String kpnr) {
        this.kpnr = kpnr;
    }

    public String getKpfs() {
        return kpfs;
    }

    public void setKpfs(String kpfs) {
        this.kpfs = kpfs;
    }

    public String getPfbm() {
        return pfbm;
    }

    public void setPfbm(String pfbm) {
        this.pfbm = pfbm;
    }

    public String getJd() {
        return jd;
    }

    public void setJd(String jd) {
        this.jd = jd;
    }

    public List<CheckItemDetailGson> getDetails() {
        return details;
    }

    public void setDetails(List<CheckItemDetailGson> details) {
        this.details = details;
    }

    public String getQd() {
        return qd;
    }

    public void setQd(String qd) {
        this.qd = qd;
    }
}
