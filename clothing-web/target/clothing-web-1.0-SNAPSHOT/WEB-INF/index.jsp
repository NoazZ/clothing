<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="Bookmark" href="/favicon.ico" >
    <link rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5shiv.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>H-ui.admin v3.0</title>
    <meta name="keywords" content="H-ui.admin v3.0,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="H-ui.admin v3.0，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" href="/aboutHui.shtml">企业班服管理系统</a> <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="/aboutHui.shtml">H-ui</a>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs">v1.0</span>
            <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li>${orgUserEntityDto.department}
                    </li>
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">${orgUserEntityDto.realName}<i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onclick="myselfinfo()">个人信息</a></li>
                            <li><a href="#">切换账户</a></li>
                            <li><a onclick="loginout()">退出</a></li>
                        </ul>
                    </li>
                    <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
                    <li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<aside class="Hui-aside">

    <c:if test="${orgUserEntityDto.permission==1}">
    <div class="menu_dropdown bk_2">
        <dl id="menu-order1">
            <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="order/writeOrder" data-title="填写订单" href="javascript:void(0)">填写订单</a></li>
                    <li><a data-href="order/myOrder/${sessionScope.orgUserEntityDto.id}" data-title="我的订单" href="javascript:void(0)">我的订单</a></li>
                </ul>
            </dd>
        </dl>
        </c:if>
        <c:if test="${orgUserEntityDto.permission==2}">
        <div class="menu_dropdown bk_2">
            <dl id="menu-order2">
                <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <li><a data-href="order/getFlowOrder/0" data-title="审核" href="javascript:void(0)">审核</a></li>
                        <li><a data-href="order/getFlowOrder/2" data-title="审批" href="javascript:void(0)">审批</a></li>
                        <li><a data-href="order/getFlowOrder/6" data-title="已完成回款订单" href="javascript:void(0)">已完成回款订单</a></li>
                    </ul>
                </dd>
            </dl>
            </c:if>

            <c:if test="${orgUserEntityDto.permission==3}">
            <div class="menu_dropdown bk_2">
                <dl id="menu-order3">
                    <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                    <dd>
                        <ul>
                            <li><a data-href="order/getFlowOrder/1" data-title="受理订单" href="javascript:void(0)">受理订单</a></li>
                        </ul>
                    </dd>
                </dl>
                </c:if>

                <c:if test="${orgUserEntityDto.permission==4}">
                <div class="menu_dropdown bk_2">
                    <dl id="menu-order3">
                        <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                        <dd>
                            <ul>
                                <li><a data-href="order/getFlowOrder/3" data-title="订单初款" href="javascript:void(0)">订单初款</a></li>
                                <li><a data-href="order/getFlowOrder/5" data-title="尾款订单" href="javascript:void(0)">尾款订单</a></li>
                                <li><a data-href="order/getFlowOrder/6" data-title="已完成回款订单" href="javascript:void(0)">已完成回款订单</a></li>
                            </ul>
                        </dd>
                    </dl>
                    </c:if>

                    <c:if test="${orgUserEntityDto.permission==5}">
                    <div class="menu_dropdown bk_2">
                        <dl id="menu-order3">
                            <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                            <dd>
                                <ul>
                                    <li><a data-href="order/getFlowOrder/4" data-title="排单生产" href="javascript:void(0)">排单生产</a></li>
                                    <li><a data-href="order/getFlowOrder/6" data-title="已完成回款订单" href="javascript:void(0)">已完成回款订单</a></li>
                                </ul>
                            </dd>
                        </dl>
                        </c:if>

                        <c:if test="${orgUserEntityDto.permission==0}">
                        <div class="menu_dropdown bk_2">
                            <dl id="menu-order">
                                <dt><i class="Hui-iconfont">&#xe613;</i> 订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                                <dd>
                                    <ul>
                                        <li><a data-href="order/listOrder" data-title="所有订单" href="javascript:void(0)">全都订单</a></li>
                                        <li><a data-href="order/writeOrder" data-title="填写订单" href="javascript:void(0)">填写订单</a></li>
                                        <li><a data-href="order/getFlowOrder/0" data-title="审核订单" href="javascript:void(0)">审核订单</a></li>
                                        <li><a data-href="order/getFlowOrder/1" data-title="设计订单" href="javascript:void(0)">设计订单</a></li>
                                        <li><a data-href="order/getFlowOrder/2" data-title="审批订单" href="javascript:void(0)">审批订单</a></li>
                                        <li><a data-href="order/getFlowOrder/3" data-title="财务收款" href="javascript:void(0)">财务收款</a></li>
                                        <li><a data-href="order/getFlowOrder/4" data-title="排单" href="javascript:void(0)">排单</a></li>
                                        <li><a data-href="order/getFlowOrder/5" data-title="回款完成" href="javascript:void(0)">回款完成</a></li>
                                        <li><a data-href="order/getFlowOrder/6" data-title="已完成回款订单" href="javascript:void(0)">已完成回款订单</a></li>
                                        <li><a data-href="order/getFlowOrder/7" data-title="异常订单" href="javascript:void(0)">异常订单</a></li>
                                    </ul>
                                </dd>
                            </dl>

                            <dl id="menu-fashion">
                                <dt><i class="Hui-iconfont">&#xe613;</i> 款式管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                                <dd>
                                    <ul>
                                        <li><a data-href="fashion/getAll" data-title="所有款式" href="javascript:void(0)">所有款式</a></li>
                                    </ul>
                                </dd>
                            </dl>


                            <dl id="menu-user">
                                <dt><i class="Hui-iconfont">&#xe613;</i> 用户管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                                <dd>
                                    <ul>
                                        <li><a data-href="admin/getAllUser" data-title="用户管理" href="javascript:void(0)">用户管理</a></li>
                                    </ul>
                                </dd>
                            </dl>

                            <dl id="menu-system">
                                <dt><i class="Hui-iconfont">&#xe62e;</i> 系统管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                                <dd>
                                    <ul>
                                        <li><a data-href="system-log.jsp" data-title="系统日志" href="javascript:void(0)">系统日志</a></li>
                                    </ul>
                                </dd>
                            </dl>
                        </div>
                        </c:if>



</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="welcome.jsp">我的桌面</span>
                    <em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="../welcome.jsp"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前 </li>
        <li id="closeall">关闭全部 </li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
<!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
    $(function(){
        /*$("#min_title_list li").contextMenu('Huiadminmenu', {
            bindings: {
                'closethis': function(t) {
                    console.log(t);
                    if(t.find("i")){
                        t.find("i").trigger("click");
                    }
                },
                'closeall': function(t) {
                    alert('Trigger was '+t.id+'\nAction was Email');
                },
            }
        });*/
    });

    function loginout() {
        $.ajax({
            async:true,//异步
            type:'GET',
            url:'login?param=exit',
        });
        //var index = layer.getFrameIndex(window.name);
        location.reload();
        /* $.ajax({
             async:true,//异步
             type: 'GET',
             url: 'login',
         });*/
    }
    /* 个人信息 */
    function myselfinfo() {
        layer.open({
            type: 1,
            area: ['300px', '200px'],
            fix:false,
            maxmin:true,
            shade:0.4,
            title:'查看信息',
            content:'<div>您好！</div>'
        });
    }

    /* 咨询-添加 */
    function article_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*图片-添加*/
    function picture_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*产品-添加*/
    function product_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

</script>


</body>
</html>
