package com.tingo.weaver;

import com.tingo.BaseTestCase;
import com.tingo.weaver.biz.PageBuilder;
import com.tingo.weaver.biz.PageService;
import com.tingo.weaver.model.dto.*;
import com.tingo.weaver.utils.enums.TdType;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;

/**
 * Created by user on 17/10/17.
 */
public class JspGeneraterTest extends BaseTestCase {
    @Autowired
    private PageService pageService;

    @Test
    public void test() {
        System.out.println("---------");
    }

    @Test
    public void testBuildPage() {
        Page page = new PageBuilder().addHead(new Head().row(1).label(new Label("用户名")).input(new Input("username", TdType.TEXT,"username")))
                .addHead(new Head().row(1).label(new Label("年龄")).input(new Input("age",TdType.TEXT,"age")))
                .addHead(new Head().row(2).label(new Label("性别")).input(new Select("sex",TdType.SELECT,"sex").optionCheck("checkSex").onChange("onChange()").addOption(new Option("男","0",1)).addOption(new Option("女","1",2))))
                .addHead(new Head().row(2).label(new Label("部门")).input(new Button("debt",TdType.BUTTON,"debt").onclick("onCheck(<%=rowindex%>)")))
                .addHead(new Head().row(3).label(new Label("季度选择")).input(new Select("season",TdType.SELECT,"season").optionCheck("checkDateSeason").addOption(new Option("第一季度","1",1)).addOption(new Option("第二季度","2",2)).addOption(new Option("第三季度","3",3)).addOption(new Option("第四季度","4",4))))
                .build();

        try {
            String jspInfo = pageService.generateHead(page.getHeads());
            System.out.println(jspInfo);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    @Test
    public void testBuildBody() {

    }

    @Test
    public void testWriteLine() {
        System.out.println(new Date().getTime());
    }
}
