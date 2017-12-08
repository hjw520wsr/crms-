<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>欢迎来到黄家旺的课程资源管理系统</title>
  <link rel="stylesheet" href="/layui/css/layui.css">
</head>
<body class="layui-layout-body">
    <%  
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">课程资源管理系统</div>
 	
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
				<li class="layui-nav-item"><a href="/student">学生信息管理</a></li>
				<li class="layui-nav-item"><a href="/resource">学习资源管理</a></li>
				<li class="layui-nav-item"><a href="/t_password">修改密码</a></li>
      </ul>
    </div>
  </div>
  <div class="layui-body">
  		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  	<legend>密码修改</legend>
	</fieldset>
  		<form class="layui-form layui-form-pane" action="/tpassword" method="post">
			<div class="layui-form-item">
    			<label class="layui-form-label">工号</label>
    			<div class="layui-input-block">
      				<input type="text" name="tNum" lay-verify="tNum" placeholder="必填" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			  <div class="layui-form-item">
    			<label class="layui-form-label">旧密码</label>
    			<div class="layui-input-block">
      				<input type="text" name="oldpassword" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label">新密码</label>
    			<div class="layui-input-block">
      				<input type="text" name="password" lay-verify="password" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			 <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    		<button data-method="add" class="layui-btn" lay-submit lay-filter="demo1">提交</button>
    		</div>
		</form>
</div>
<script src="/layui/layui.js"></script>
<script>
	layui.use(['form','layer'], function(){
  var form = layui.form,
  layer = layui.layer;
  //监听提交
//   form.on('submit(demo1)', function(data){
//   	layer.msg("密码修改成功,请重新登录");
//   	window.location.href = "localhost:8080";
//   });
});
</script>
</body>
</html>


