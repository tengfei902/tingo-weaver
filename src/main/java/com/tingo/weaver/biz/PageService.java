package com.tingo.weaver.biz;

import com.tingo.weaver.model.dto.Table;
import com.tingo.weaver.model.dto.Head;
import javafx.scene.control.Tab;

import java.util.List;

/**
 * Created by user on 17/10/17.
 */
public interface PageService {

    String generateHead(List<Head> heads) throws Exception;

    String generateBody(Table table) throws Exception;

    String generateDataBlock(Table table);
}
