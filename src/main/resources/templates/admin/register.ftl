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
        <form class="login-form" id="onfrom" >
            <div class="layui-upload" style="text-align: center;" >
                <div class="layui-upload-list">
                    <button type="button" name="img" id="choose">
                        <img width="100" height="100" onerror="this.src='/static/images/toUpload.jpg'" src="" id="img">
                    </button>
                    <p id="demoText"></p>
                </div>
            </div>
            <div class="input-group">
                <input type="text"id="username" name="userName" class="input-field">
                <label for="username" class="input-label">
                    <span class="label-title">用户名</span>
                </label>
            </div>
            <div class="input-group">
                <input type="password" id="passwordto" class="input-field">
                <label for="password" class="input-label">
                    <span class="label-title">密码</span>
                </label>
            </div>
            <div class="input-group">
                <input type="password" name="userPassword" id="password" class="input-field">
                <label for="password" class="input-label">
                    <span class="label-title">确认密码</span>
                </label>
            </div>
            <button type="submit" id="onReg" class="login-button">注册<i class="ai ai-enter"></i></button>
        </form>
    </div>
</body>
<script src="/assets/layui.js"></script>
<script src="/static/js/jquery.min.js"></script>
<script src="/js/index.js" data-main="login"></script>
<script>

    //只注册账号密码不上传图片
    $("#onfrom").on("submit",function(){
        var src =  $("#img").attr("src");
        if("/static/images/toUpload.jpg"!=src){//判断图片是否被修改，如果没有被修改则执行以下代码
            return false;
        }
        var formData = $(this).serialize();
        $.ajax({
            url: "/user/reg",
            type: "POST",
            data: formData,
            dataType: 'json',
            beforeSend: function () {
                layer.load(); //上传loading
            },
            success: function (data) {
                layer.closeAll('loading'); //关闭loading
                //发异步删除数据
                layer.msg(data.msg+'--'+data.code,function () {
                    if("操作成功！"==data.msg){
                        window.parent.location.href="/admin/login";
                    }
                });
            }
        });
        //阻止表单默认提交行为
        return false
    })

    //账号密码并携带图片一起注册
    layui.use('upload', function(){
        var $ = layui.jquery
                ,upload = layui.upload;

        //普通图片上传
        var  uploadInst  = upload.render({
            elem: '#choose'//选择文件的DOM对象
            ,auto: false //选择文件后不自动上传
            ,bindAction: '#onReg' //指向一个按钮触发上传
            ,url: '/user/reg'
            ,size: 1024 //限制文件大小，单位 KB
            ,choose: function(obj){//选择文件的回调，obj为选中的文件
                //预读本地文件示例，不支持ie8
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                obj.preview(function(index, file, result){
                    $('#img').attr('src', result); //图片链接（base64）
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">已经选择了哦，点击<a id="del_img" href="#" >&nbsp;移除图片</a></span> ');
                    demoText.find('#del_img').on('click', function(){   //添加一个取消选择图片的按钮
                        $('#img').attr('src', ""); //图片链接（base64）
                        delete files[index];
                        uploadInst.config.elem.next()[0].value = '';
                        demoText.html("");
                    });
                });
            }
            ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                if(""!=uploadInst.config.elem.next()[0].value){
                    layer.load(); //上传loading
                    var myData = {
                        "userName": $("#username").val(),
                        "userPassword": $("#password").val()
                    }
                    this.data = myData;
                }
             }
            ,done: function(res){
                if(res.code ==200){

                //如果上传失败
                }else if(res.code==500) {

                }
                layer.msg(res.msg+'--'+res.code);
                layer.closeAll('loading'); //关闭loading
                //上传成功
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