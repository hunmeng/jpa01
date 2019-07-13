<!DOCTYPE html>
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
    <link rel="stylesheet" href="/assets/css/login.css">
    <link rel="icon" href="/favicon.ico">
    <title>管理后台</title>
</head>
<body class="login-wrap">
<div class="login-container">
    <form action="/user/login" class="login-form">
        <div style="text-align: center">
            <img width="100" height="100" style="border: black dashed 1px" src="" onerror="this.src='/static/images/login.jpg'" id="img">
        </div>
        <div class="input-group">
            <input type="text" name="userName" onblur="onBlur(this.value)"  class="input-field"/>
            <label for="username" class="input-label">
                <span class="label-title">用户名</span>
            </label>
        </div>
        <div class="input-group">
            <input type="password" name="userPassword" class="input-field">
            <label for="password" class="input-label">
                <span class="label-title">密码</span>
            </label>
        </div>
        <button type="submit" class="login-button">登录<i class="ai ai-enter"></i></button>
    </form>
</div>
</body>
<script src="/assets/layui.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/index.js" data-main="login"></script>
<script>
    function onBlur(value) {
        if(""!=value) {
            $.post(
                    "/user/getImage",
                    {userName: value},
                    function (data) {
                        //回调函数方法体
                        if (null != data && "" != data) {
                            $("#img").attr("src", data);
                        } else {
                            $("#img").attr("src", "/images/login.jpg");
                        }
                    }
            )
        }
    }
</script>
<script>
    layui.use(['layer'], function () {
        var layer = layui.layer;
        $(".login-form").on("submit", function () {
            var url = this.action;   //可以直接取到表单的action
            var formData = $(this).serialize();
            $.ajax({
                url: url,
                type: "POST",
                data: formData,
                dataType: 'json',
                beforeSend: function () {
                    //注意，layer.msg默认3秒自动关闭，如果数据加载耗时比较长，需要设置time
                    loadingFlag = layer.msg('登录中...', {icon: 16, shade: 0.01, shadeClose: false, time: 60000});
                },
                success: function (data) {
                    //发异步删除数据
                    layer.close(loadingFlag);
                    if (data.code == 200) {
                        layer.msg(data.msg + '...!', {icon: 1, time: 1000},function () {
                            window.location.href = '/admin/index';
                        });
                    } else {
                        layer.msg(data.msg + '...!', {icon: 5, time: 1000});
                    }
                }
            });
            //阻止表单默认提交行为

            return false

        })
    });
</script>


</html>