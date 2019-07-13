<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus?">
    <meta name="Author" content="">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/assets/css/layui.css">
    <link rel="stylesheet" href="/assets/css/admin.css">
    <link rel="icon" href="/favicon.ico">
    <title>管理后台</title>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header custom-header">

        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item slide-sidebar" lay-unselect>
                <a href="javascript:;" class="icon-font"><i class="ai ai-menufold"></i></a>
            </li>
        </ul>

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">BieJun</a>
                <dl class="layui-nav-child">
                    <dd><a href="#" id="login_edit">个人信息</a></dd>
                    <dd><a href="login">退出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side custom-admin">
        <div class="layui-side-scroll">

            <div class="custom-logo">
                <img src="/assets/images/logo.png" alt=""/>
                <h1>Admin Pro</h1>
            </div>
            <ul id="Nav" class="layui-nav layui-nav-tree">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe609;</i>
                        <em>主页</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="views/console">控制台</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe857;</i>
                        <em>组件</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="views/form">表单</a></dd>
                        <dd>
                            <a href="javascript:;">页面</a>
                            <dl class="layui-nav-child">
                                <dd>
                                    <a href="login">登录页</a>
                                </dd>
                            </dl>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <i class="layui-icon">&#xe612;</i>
                        <em>用户</em>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="views/users">用户组</a></dd>
                        <dd><a href="views/operaterule">权限配置</a></dd>
                    </dl>
                </li>
            </ul>

        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab app-container" lay-allowClose="true" lay-filter="tabs">
            <ul id="appTabs" class="layui-tab-title custom-tab"></ul>
            <div id="appTabPage" class="layui-tab-content"></div>
        </div>
    </div>

    <div class="layui-footer">
        <p>© 2018 更多模板：<a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>
    </div>

    <div class="mobile-mask"></div>
</div>
<script src="/assets/layui.js"></script>
<script src="/js/index.js" data-main="home"></script>
<script>
    layui.use(['layer'], function () {
        //iframe层-父子操作
        var $ = layui.jquery;
        $("#login_edit").click(function () {
            layer.open({
                area: ['330px', '510px'],
                fixed: false, //不固定
                type: 2,
                title: '修改个人信息',
                shadeClose: true,
                shade: 0.8,
                content: '/admin/views/login_edit'
            });
        })
    })
</script>
</body>
</html>