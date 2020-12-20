<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布活动</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/page_institution_releaseActivity.css" type="text/css">
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/tinymce/js/tinymce/tinymce.min.js"></script>
    <script>
        tinymce.init({
            selector: '#detail',
            language:'zh_CN',
            width:565,
            height: 300,
            resize: false
        });
        $(function (){
            //登录用户信息显示
            var currentUser = "<%=session.getAttribute("sid")%>";
            var currentManager = "<%=session.getAttribute("mid")%>";
            if (currentUser != "null") {
                $("#afterLogin1").removeAttr("hidden");
            }
            else{
                $("#afterLogin1").attr("hidden","hidden");
            }
            if (currentManager != "null") {
                $("#afterLogin2").removeAttr("hidden");
            }
            else{
                $("#afterLogin2").attr("hidden","hidden");
            }
        })
    </script>
</head>

<body>
<!--头部-->
<div class="header w">
    <!--创建导航条-->
    <div class="nav">

        <div class="nav-left">
            <div>
                <a href="showAllNoticeByPage"><button class="btn">通知</button></a>
                <a href="student_login.jsp"><button class="btn">登录</button></a>
                <a href="student_register.jsp"	><button class="btn">注册</button></a>
            </div>
        </div>
        <div id="afterLogin1" class="nav-right">
            <span>当前用户 :<%=session.getAttribute("name")%>(<%=session.getAttribute("stuNum")%>)</span>
            <a href="showMyInfo"><button class="btn btn-primary">学生主页</button></a>
            <a href="stuExit"><button class="btn btn-warning">退出登录</button></a>
        </div>
        <div id="afterLogin2" class="nav-right">
            <span>当前管理员 :<%=session.getAttribute("username")%></span>
            <a href="showClassmatesByPage?_class=${sessionScope._class}"><button class="btn btn-primary">管理员主页</button></a>
            <a href="manExit"><button class="btn btn-warning">退出登录</button></a>
        </div>
    </div>
    <div class="logo">
        <a href="initIndex" title="活动管理网站">
            <img src="img/logo.jpg" alt="网站的logo">
        </a>
    </div>
</div>
<!--网站内容-->
<div class="content w clearfix">
    <div class="navBar">
        <p>导航栏</p>
        <a href="showClassmatesByPage"><button class="btn">党/团员管理</button></a>
        <a href="showPassActivityByPage"><button class="btn">活动管理</button></a>
        <a href="showVerifyingActivityByPage"><button class="btn">审核活动</button></a>
        <a href="institution_releaseActivity.jsp"><button class="btn">发布活动</button></a>
        <a href="institution_releaseNotice.jsp"><button class="btn">发布通知</button></a>
        <a href="showManNoticeByPage"><button class="btn">通知管理</button></a>
    </div>
    <div class="tip">
        <span>学院名称：
            <c:if test="${sessionScope.collegeName=='XX'}">
                信息学院
            </c:if>
            <c:if test="${sessionScope.collegeName=='HH'}">
                航海学院
            </c:if>
            <c:if test="${sessionScope.collegeName=='JT'}">
                交通学院
            </c:if>
            <c:if test="${sessionScope.collegeName=='WY'}">
                外语学院
            </c:if>
        </span>
        <span style="font-size: 20px;font-weight: bold ">发布活动</span>
    </div>
    <div class="applyActivyty clearfix">
        <form action="postActivity" method="get" class="clearfix">
            <c:if test="${sessionScope.collegeName=='XX'}">
                <input type="text" disabled="disabled" value="活动发起者：信息学院"/>
            </c:if>
            <c:if test="${sessionScope.collegeName=='HH'}">
                <input type="text" disabled="disabled" value="活动发起者：航海学院"/>
            </c:if>
            <c:if test="${sessionScope.collegeName=='JT'}">
                <input type="text" disabled="disabled" value="活动发起者：交通学院"/>
            </c:if>
            <c:if test="${sessionScope.collegeName=='WY'}">
                <input type="text" disabled="disabled" value="活动发起者：外语学院"/>
            </c:if>
            <input name="actTitle" type="text" placeholder="活动标题" required="required"/>
            <input class="show_placeholder" type="date" name="actBeginD"  placeholder="开始日期"required="required"/>
            <input class="show_placeholder" type="time" name="actBeginT" placeholder="开始时间"required="required"/>
            <input class="show_placeholder" type="date"  name="actEndD" placeholder="结束日期"required="required"/>
            <input class="show_placeholder" type="time"  name="actEndT" placeholder="结束时间"required="required"/>
            <select name="getPoints"required="required">
                <option value=""  style="display:none" >活动积分</option>
                <option value="1">1分</option>
                <option value="2">2分</option>
                <option value="3">3分</option>
            </select>
            <input name="actPlace" type="text" placeholder="活动地点" required="required"/>
            <input class="show_placeholder" name="enrollEndD" type="date" placeholder="报名截止日期" required="required" />
            <input class="show_placeholder" name="enrollEndT" type="time" placeholder="报名截止时间" required="required"/>
            <input name="numLevel" type="text" placeholder="报名名额上限" required="required"/>
            <select name="category" required="required">
                <option value="" style="display:none" >活动类型</option>
                <option value="4">学院党员活动(党员)</option>
                <option value="3">学院党团活动(党员+团员)</option>
            </select>
            <textarea id="detail" name="actContent" placeholder="活动详情""></textarea>
            <input class="btn btn-primary" type="submit" value="发布活动"/>
        </form>
        <lable>${msg}</lable>
    </div>


</div>
</div>
<!--内容结束-->
<!--网站底部-->

<div class="footer clearfix">
    <div class="w">
        <p>
            <a href="initIndex">网站主页</a>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="showAllNoticeByPage">网站通知</a>
        </p>
        <br/>

        <br/>
        <p>
            <a href="Mailto:yangfanjack1024@qq.com">如果您对该网站有任何意见，点击这里发送邮件给我们。</a>
        </p>
    </div>
</div>
</body>

</html>