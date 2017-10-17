package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.PageService;
import com.tingo.weaver.biz.RefService;
import com.tingo.weaver.biz.common.BeanCache;
import com.tingo.weaver.model.dto.*;
import com.tingo.weaver.utils.Utils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Created by user on 17/10/17.
 */
@Service
public class PageServiceImpl implements PageService {
    @Autowired
    private RefService refService;

    @Override
    public String generateHead(List<Head> heads) throws Exception {

        StringBuilder result = new StringBuilder("<tbody>");

        if(CollectionUtils.isEmpty(heads)) {
            return result.append("</tbody>").toString();
        }

        Map<Integer,List<Head>> rowMap = heads.parallelStream().collect(Collectors.groupingBy(Head::getRow));

        for(Integer row:rowMap.keySet()) {
            result = result.append(buildHeadTr(rowMap.get(row)));
        }

        result.append("</tbody>");

        return result.toString();
    }

    private String buildHeadTr(List<Head> heads) throws Exception {
        StringBuilder result  = new StringBuilder("<tr>");

        for(Head head:heads) {
            result = result.append(buildHeadTd(head));
        }

        result = result.append("</tr>");

        return result.toString();
    }

    private String buildHeadTd(Head head) throws Exception {
        StringBuilder result = new StringBuilder("");

        if(!Objects.isNull(head.getLabel())) {
            result = result.append("<td class=\"fname\">").append(head.getLabel().getLabel()).append("</td>");
        }

        if(!Objects.isNull(head.getInput())) {

            result = result.append("<td class=\"fvalue\">");

            //init value
            String value = head.getInput().getValue();
            Object refValue = value;
            if(!Objects.isNull(value) && value.startsWith("ref:")) {
                value = value.replace("ref:","");
                String methodName = StringUtils.substringBefore(value,"(");
                String params = StringUtils.substringBefore(StringUtils.substringAfter(value,"("),")");

                Method method = BeanCache.getInstance().getCachedMethod("RefService",methodName);
                refValue = method.invoke(refService, Utils.convertStr2ObjArray(params));
            }

            switch (head.getInput().getTdType()) {
                case TEXT:
                    result = result.append("<input type=\"text\" id=\"").append(head.getInput().getId()).append("\" name=\"").append(head.getInput().getName()).append("\" value=\"").append(refValue).append("\" />");
                    break;
                case PASSWORD:
                    result = result.append("<input type=\"password\" id=\"").append(head.getInput().getId()).append("\" name=\"").append(head.getInput().getName()).append("\" />");
                    break;
                case BUTTON:
                    Button button = (Button) head.getInput();
                    result = result.append("<BUTTON class=Browser type=\"button\"");
                    result = result.append(" id=").append(button.getId());
                    if(!StringUtils.isEmpty(button.getOnclickFunction())) {
                        result = result.append(" onClick=\"").append(button.getOnclickFunction()).append("\"");
                    }
                    result = result.append("></BUTTON>");

                    String spanId = String.format("%s_span",button.getId());
                    result = result.append("<span id=").append(spanId).append(">").append(refValue).append("</span>");
                    //<INPUT class=inputstyle id=subcompanyid type=hidden name=subcompanyid value=<%=subcompanyid%>>
                    String hiddenId = String.format("%s_id",button.getId());
                    String hiddenName = String.format("%s_id",button.getName());
                    result = result.append("<INPUT class=inputstyle id=").append(hiddenId).append(" type=hidden").append(" name=").append(hiddenName).append(" value=").append(button.getParams()).append(">");
                    break;
                case SELECT:
                    Select select = (Select)head.getInput();
                    result = result.append("<select id=\"").append(select.getId()).append("\"");

                    if(!StringUtils.isEmpty(select.getOnChangeAction())) {
                        result = result.append(" onChange=\"").append(select.getOnChangeAction()).append("\"");
                    }

                    result = result.append(">");

                    List<Option> options = select.getOptions();
                    options = options.stream().sorted((o1, o2) -> o1.getOrder().compareTo(o2.getOrder())).collect(Collectors.toList());

                    Method checkedMethod = BeanCache.getInstance().getCachedMethod("RefService",select.getOptionCheckFunction());

                    for(Option option:options) {
                        result = result.append("<option value=\"").append(option.getValue()).append("\"");
                        boolean selected = Boolean.valueOf(checkedMethod.invoke(refService,option.getValue()).toString());
                        if(selected) {
                            result = result.append(" selected=\"selected\" ");
                        }
                        result.append(">");
                        result.append(option.getName());
                        result.append("</option>");
                    }

                    result = result.append("</select>");

                    break;
                default:
                    break;
            }

            result = result.append("</td>");
        }
        return result.toString();
    }

    @Override
    public String generateBody(Table table) {
        StringBuilder result = new StringBuilder("<table");
        result = result.append(" id = \"").append(table.getId()).append("\"");
        result = result.append(" class=\"").append(table.getClazz()).append("\"");
        result = result.append(" style=\"").append(table.getStyle()).append("\"");
        result = result.append(" border=\"").append(table.getBorder()).append("\"");
        result = result.append(" name=\"").append(table.getName()).append("\"");
        result = result.append(">");

        List<Column> columns = table.getColumns().stream().sorted((o1, o2) -> o1.getOrder().compareTo(o2.getOrder())).collect(Collectors.toList());

        StringBuilder cols = new StringBuilder("");
        for(Column column:columns) {
            cols.append("<COL width=\"").append(column.getWidth()).append("\">");
        }

        //cols
        result = result.append("<colgroup>");
        result = result.append(cols);
        result = result.append("</colgroup>");

        //title
        StringBuilder title = new StringBuilder("");
        title = title.append("<tbody>");
        title = title.append("<tr class=\"header detailtitle\">");

        for (Column column:columns) {
            title = title.append("<td class=\"detailtitle\" nowrap=\"nowrap\" align=\"center\">");
            title = title.append("<input id=\"").append(column.getId()).append("\"").append(" class=\"Label\" name=\"").append(column.getName()).append("\"").append( "value=\"").append(column.getValue()).append("\"").append(" disabled=\"true\" ").append(" style=\"").append(column.getStyle()).append("\" />");
            title = title.append("</td>");
        }

        title = title.append("</tr>");
        title = title.append("</tbody>");

        result = result.append(title);

        result = result.append("</table>");
        return result.toString();
    }
}
