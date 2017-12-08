<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理系统登陆</title>
    <link rel="stylesheet" href="/layui/css/layui.css">
    <link rel="stylesheet" href="/css/login.css">
    <script type="text/javascript" src="/layui/layui.js"></script>
</head>
<body>
<div class="layui-carousel video_mask" id="login_carousel" >
    <div carousel-item>
        <div class="carousel_div1"></div>
        <div class="carousel_div2"></div>
        <div class="carousel_div3"></div>
    </div>
    <div class="login layui-anim layui-anim-up">
        <h1>课程资源管理系统</h1></p>
        <form class="layui-form" action="/login" method="post">
            <div class="layui-form-item">
                <input type="text" name="username" lay-verify="required" placeholder="请输入账号" autocomplete="off"  value="" class="layui-input">
            </div>
            <div class="layui-form-item">
                <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" value="" class="layui-input">
            </div>
            <div class="layui-form-item">
			<input type="radio" name="type" value="0" title="教师"checked>
			<input type="radio" name="type" value="1" title="学生">
			</div>
            <button class="layui-btn login_btn" lay-submit="" lay-filter="login">登陆系统</button>
        </form>
    </div>

</div>
</body>

</html>
<script>
    layui.config({
        base : "js/"
    }).use(['form','layer','jquery','common','carousel'], function () {
        var $ = layui.jquery,
                form = layui.form,
                common = layui.common,
                carousel = layui.carousel;

        /**背景图片轮播*/
        carousel.render({
             elem: '#login_carousel',
             width: '100%',
             height: '100%',
             interval:2000,
             arrow: 'none',
             anim: 'fade',
             indicator:'none'
        });


        /**监听登陆提交*/
        form.on('submit(login)', function (data) {
            //弹出loading
            var loginLoading = top.layer.msg('登陆中，请稍候', {icon: 16, time: false, shade: 0.8});
            //记录ajax请求返回值
            var ajaxReturnData;

            //登陆验证
            $.ajax({
                url: '/login',
                type: 'post',
                async: false,
                data: data.field,
                success: function (data) {
                    ajaxReturnData = data;
                }
            });
            //登陆成功
            if (ajaxReturnData.returnCode == 0000) {
                window.location.href="/car";
                top.layer.close(loginLoading);
                return false;
            } else {
                top.layer.close(loginLoading);
                common.cmsLayErrorMsg(ajaxReturnData.returnMessage);
                reqCaptcha();
                return false;
            }
        });

    });

</script>