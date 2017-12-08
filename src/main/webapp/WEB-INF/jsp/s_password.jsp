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
				<li class="layui-nav-item"><a href="/s_resource">学习资源</a></li>
				<li class="layui-nav-item"><a href="/s_password">修改密码</a></li>
      </ul>
    </div>
  </div>
  <div class="layui-body">
  		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
  	<legend>密码修改</legend>
	</fieldset>
  		<form class="layui-form layui-form-pane" action="/spassword" method="post">
			<div class="layui-form-item">
    			<label class="layui-form-label">学号</label>
    			<div class="layui-input-block">
      				<input type="text" name="sNum" lay-verify="required" placeholder="必填" autocomplete="off" class="layui-input">
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
      				<input type="text" name="password" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			 <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    		<button data-method="add" class="layui-btn">提交</button>
    		</div>
		</form>
</div>
<script src="/layui/layui.js"></script>
<script>
// layui.use('form', function(){
// 	  var form = layui.form
// 	  //监听提交
// 	  form.on('submit(demo1)', function(data){
// 	  	layer.msg("密码修改成功,请重新登录");
// 	  	window.location.href = "localhost:8080";
// 	    return false;
// 	  });
// 	  form.verify({
// 			password: [/(.+){6,12}$/, '密码必须6到12位']
// 		    ,content: function(value){
// 		      layedit.sync(editIndex);
// 		    }
// 		  });
// 	});
</script>
</body>
</html>


