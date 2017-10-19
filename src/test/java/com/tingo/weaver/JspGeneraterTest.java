package com.tingo.weaver;

import com.tingo.BaseTestCase;
import com.tingo.weaver.biz.PageBuilder;
import com.tingo.weaver.biz.PageService;
import com.tingo.weaver.model.dto.*;
import com.tingo.weaver.utils.enums.TdType;
import javafx.scene.control.Tab;
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
        Table table = new Table("oTable1","oTable1")
                .clazz("ListStyle detailtable detailtableTopTable")
                .style("width: 100%")
                .border(1)
                .addColumn(new Column("xuanze","xuanze","选择",1).style("width:80px;").width("1%"))
                .addColumn(new Column("bkp","bkp","被考评公司",2).style("width:80px;").width("10%"))
                .addColumn(new Column("nr","nr","内容",3).style("width:120px;").width("10%"))
                .addColumn(new Column("tkxz","tkxz","条款细则",4).style("width:120px;").width("3%"))
                .addColumn(new Column("fssx","fssx","分数上限",5).style("width:60px;").width("20%"))
                .addColumn(new Column("ysfs","ysfs","验收方式",6).style("width:120px;").width("15%"))
                .addColumn(new Column("pfbz","pfbz","评分标准",7).style("width:120px;").width("10%"))
                .addColumn(new Column("zpfs","zpfs","自评分数",8).style("width:60px;").width("10%"))
                .addColumn(new Column("zl","zl","资料",9).style("width:60px;").width("15%"))
                .addColumn(new Column("kpfs","kpfs","考评方式",10).style("width:60px;").width("20%"))
                .addColumn(new Column("fs","fs","分数",11).style("width:30px;").width("10%"))
                .addColumn(new Column("qrkp","qrkp","确认考评",12).style("width:60px;").width("10%"));

        try {
            String jsp = pageService.generateBody(table);

            System.out.println(jsp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Test
    public void testBuildDataBlock() {
        Table table = new Table("oTable1","oTable1")
                .clazz("ListStyle detailtable detailtableTopTable")
                .style("width: 100%")
                .border(1)
                .addColumn(new Column("xmnr","xmnr","项目内容",1).style("width:80px;").width("10%").type(TdType.LABEL))
                .addColumn(new Column("tkxz","tkxz","条款细则",2).style("width:80px;").width("20%").type(TdType.LABEL))
                .addColumn(new Column("fz","fz","分值",3).style("width:80px;").width("5%").type(TdType.LABEL))
                .addColumn(new Column("pfbz","pfbz","评分标准",4).style("width:80px;").width("10%").type(TdType.LABEL))
                .addColumn(new Column("kpjd","kpjd","考评季度",5).style("width:80px;").width("5%").type(TdType.LABEL))
                .addColumn(new Column("zt","zt","状态",6).style("width:80px;").width("5%").type(TdType.LABEL))
                .addColumn(new Column("zpf","zpf","自评分",7).style("width:80px;").width("5%").type(TdType.TEXT))
                .addColumn(new Column("zpsm","zpsm","自评说明",8).style("width:80px;").width("20%").type(TdType.TEXT));

        String jsp = pageService.generateDataBlock(table);
        System.out.println(jsp);
    }

    @Test
    public void testWriteLine() {
        System.out.println(new Date().getTime());
    }

    @Test
    public void testAppend() {
        StringBuilder sb = new StringBuilder("asfdgdfh");
        sb.append("---------------------------");
        System.out.println(sb.toString());
    }
}
