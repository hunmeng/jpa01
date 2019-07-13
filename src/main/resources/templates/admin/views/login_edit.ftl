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
<body>
    <form class="login-form" style="margin-top: -20px;" id="onfrom" >
        <div class="layui-upload" style="text-align: center;" >
            <div class="layui-upload-list">
                <button type="button" name="img" id="choose">
                    <img width="100" height="100" src="${Session.user.imageUrl}" onerror="this.src='${Session.user.imageUrl}'" id="img">
                </button>
                <p id="demoText">点击修改图片</p>
            </div>
        </div>
        <div class="input-group">
            <input type="text"id="opassword" name="opassword" class="input-field">
            <label for="username" class="input-label">
                <span class="label-title">原密码</span>
            </label>
        </div>
        <div class="input-group">
            <input type="password" id="passwordNew" class="input-field">
            <label for="password" class="input-label">
                <span class="label-title">新密码</span>
            </label>
        </div>
        <div class="input-group">
            <input type="password"id="password" name="userPassword" class="input-field">
            <label for="password" class="input-label">
                <span class="label-title">确认新密码</span>
            </label>
        </div>
        <input type="hidden" id="username" name="userName" value="${Session.user.userName}" >
        <button type="submit" id="onReg" class="login-button">确认修改<i class="ai ai-enter"></i></button>
    </form>
</body>
<script src="/assets/layui.js"></script>
<script src="/js/jquery.min.js"></script>
<script src="/js/index.js" data-main="login"></script>
<script>
    //只修改信息不修改图片
    $("#onfrom").on("submit",function(){
        //设置img背景图片，还有
        var src =  $("#img").attr("src");
        if("${user.imageUrl!}"!=src){//判断图片是否被修改，如果没有被修改则执行以下代码
            return false;
        }
        var formData = $(this).serialize();
        $.ajax({
            url: "/user/editUser",
            type: "POST",
            data: formData,
            dataType: 'json',
            beforeSend: function () {
                //注意，layer.msg默认3秒自动关闭，如果数据加载耗时比较长，需要设置time
                loadingFlag = layer.msg('修改中...', {icon: 16, shade: 0.01, shadeClose: false, time: 60000});
            },
            success: function (data) {
                //发异步删除数据
                layer.close(loadingFlag);
                layer.msg(data.msg+'--'+data.code,function () {
                    if("原密码错误！"!=data.msg){
                        window.parent.location.href="/admin/login";
                    }
                });
            }
        });
        //阻止表单默认提交行为
        return false
    })

    //修改信息也修改图片
    layui.use('upload', function(){
        var $ = layui.jquery
                ,upload = layui.upload;

        //普通图片上传
        var  uploadInst  = upload.render({
            elem: '#choose'//选择文件的DOM对象
            ,auto: false //选择文件后不自动上传
            ,bindAction: '#onReg' //指向一个按钮触发上传
            ,url: '/user/editUser'
            ,size: 1024 //限制文件大小，单位 KB
            ,choose: function(obj){//选择文件的回调，obj为选中的文件
                //预读本地文件示例，不支持ie8
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                obj.preview(function(index, file, result){
                    $('#img').attr('src', result); //图片链接（base64）
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">已经选择了哦，点击<a id="del_img" href="#" >&nbsp;移除图片</a></span> ');
                    demoText.find('#del_img').on('click', function(){
                        $('#img').attr('src', ""); //图片链接（base64）
                        delete files[index];
                        uploadInst.config.elem.next()[0].value = '';
                        demoText.html("点击修改图片");
                    });
                });
            }
            ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                if(""!=uploadInst.config.elem.next()[0].value){
                    layer.load(); //上传loading
                    var myData = {
                        "userName": $("#username").val(),
                        "userPassword": $("#password").val(),
                        "opassword": $("#opassword").val()
                    }
                    this.data = myData;
                }
            }
            ,done: function(data){
                layer.closeAll('loading'); //关闭loading
                //上传成功
                layer.msg(data.msg+'--'+data.code,function () {
                    if("原密码错误！"!=data.msg){
                        window.parent.location.href="/admin/login";
                    }
                });
            }
            ,error: function(){
                //演示失败状态，并实现重传
                layer.closeAll('loading'); //关闭loading
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">图像上传失败，请重新提交</span> ');
            }
        });

    });


</script>
</html>