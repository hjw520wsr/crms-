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
  	<legend>添加学生</legend>
	</fieldset>
  		<form class="layui-form layui-form-pane" action="/student/add" method="post">
			<div class="layui-form-item">
    			<label class="layui-form-label">姓名</label>
    			<div class="layui-input-block">
      				<input type="text" name="sName" lay-verify="required" placeholder="必填" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
  			<label class="layui-form-label">性别</label>
  			<div class="layui-input-block">
  			<input type="radio" name="sex" value="男" title="男" checked>
			<input type="radio" name="sex" value="女" title="女">
			</div>
			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label">学号</label>
    			<div class="layui-input-block">
      				<input type="text" name="sNum" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label">联系方式</label>
    			<div class="layui-input-block">
      				<input type="text" name="tel" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			<div class="layui-form-item">
    			<label class="layui-form-label">学院</label>
    			<div class="layui-input-block">
      				<input type="text" name="institute" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
    		<div class="layui-form-item">
    			<label class="layui-form-label">专业</label>
    			<div class="layui-input-block">
      				<input type="text" name="major" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">
    			</div>
  			</div>
  			 <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    		<button data-method="add" class="layui-btn">提交</button>
    		</div>
		</form>
</div>
<script src="/layui/layui.js"></script>
<script>
	layui.use(['form','layer'], function(){
  var form = layui.form
  ,layer = layui.layer
  //监听提交
  form.on('submit(add)', function(data){
    layer.alert("添加成功")
    return false;
  });
});
</script>
</body>
</html>

