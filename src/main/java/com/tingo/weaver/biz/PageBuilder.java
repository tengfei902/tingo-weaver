package com.tingo.weaver.biz;

import com.tingo.weaver.model.dto.Head;
import com.tingo.weaver.model.dto.Page;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by user on 17/10/17.
 */
public class PageBuilder {

    private Page page;
    private List<Head> heads;

    public PageBuilder() {

    }

    public PageBuilder addHead(Head head) {
        if(CollectionUtils.isEmpty(heads)) {
            heads = new ArrayList<>();
        }
        heads.add(head);
        return this;
    }

    public Page build() {
        page = new Page();
        page.setHeads(heads);
        return page;
    }
}
