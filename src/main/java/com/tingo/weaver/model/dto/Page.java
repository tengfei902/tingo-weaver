package com.tingo.weaver.model.dto;

import java.util.List;

/**
 * Created by user on 17/10/17.
 */
public class Page {

    private String title;
    private String js;
    private List<Head> heads;
    private List<Table> bodies;
    private List<Action> actions;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getJs() {
        return js;
    }

    public void setJs(String js) {
        this.js = js;
    }

    public List<Head> getHeads() {
        return heads;
    }

    public void setHeads(List<Head> heads) {
        this.heads = heads;
    }

    public List<Table> getBodies() {
        return bodies;
    }

    public void setBodies(List<Table> bodies) {
        this.bodies = bodies;
    }

    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }
}
