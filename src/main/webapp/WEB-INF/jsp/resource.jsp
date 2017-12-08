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
  	<legend>学习资源</legend>
	</fieldset>
	<div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
	<div class="layui-upload">
    <button type="button" class="layui-btn" id="test1">
  	<i class="layui-icon">&#xe67c;</i>上传资源
	</button>
	</div>
	输入资源名称查询：
  	<div class="layui-inline">
    <input class="layui-input" name="rName"   id="demoReload" autocomplete="off">
  	</div>
  	<button class="layui-btn" data-type="reload">查询</button>
   </div>
   <table class="layui-table" lay-data="{width: 1130, height:600, url:'/resource/list', page:true, id:'demo', limits:[30,60,90,150,300], limit:30, even: true}" lay-filter="demo">
  	<thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'rId', width:90, fixed: true}">ID</th>
      <th lay-data="{field:'rName', width:200, edit: true}">资源名</th>
      <th lay-data="{field:'uploader', width:90, edit: true}">上传者</th>
      <th lay-data="{field:'submitTime', width:170, edit: true}">上传时间</th>
      <th lay-data="{field:'url', width:150, edit: true}">路径</th>
      <th lay-data="{field:'downNum', width:90}">下载人数</th>
      <th lay-data="{field:'remark', width:200, edit: true}">备注</th>
      <th lay-data="{fixed: 'right', width:140, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
<a class="layui-btn layui-btn-mini" lay-event="down">下载</a>
 <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del" >删除</a>
</script>  
</div>
</div>
</div>
<script src="/layui/layui.js"></script>
<script>
	layui.use(['laypage', 'table', 'upload', 'element','layer'], function(){
  laypage = layui.laypage //分页
  ,table = layui.table //表格
  ,upload = layui.upload //上传
  ,layer = layui.layer
  ,element = layui.element; //元素操作
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
	if(obj.event === 'del'){
      layer.confirm('真的删除行么', function(index){
        obj.del();
        layer.close(index);
        $.ajax({
        	type:  "post",
        	url:  '/resource/delete',
        	data: JSON.stringify(obj.data),
        	dataType: "json",
        	contentType:"application/json"
        })
      });
    }else if(obj.event === 'down'){
		window.location.href="/resource/down?rId=" + obj.data.rId;            
    	layer.msg("下载中");
    }
  });
  table.on('edit(demo)', function(obj){
    var value = obj.value //得到修改后的值
    ,data = obj.data //得到所在行所有键值
    ,field = obj.field; //得到字段
    data[field] = value;
    layer.msg('[ID: '+ data.rId+'] ' + field + ' 字段更改为：'+ value);
    $.ajax({
    	type: "post",
    	url:  '/resource/update',
    	data: JSON.stringify(obj.data),
    	dataType: "json",
    	contentType:"application/json"
    })
  });
  var $ = layui.$, active = {
    getCheckData: function(){ //获取选中数据
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.alert(JSON.stringify(data));
    }
    ,getCheckLength: function(){ //获取选中数目
      var checkStatus = table.checkStatus('idTest')
      ,data = checkStatus.data;
      layer.msg('选中了：'+ data.length + ' 个');
    }
    ,isAll: function(){ //验证是否全选
      var checkStatus = table.checkStatus('idTest');
      layer.msg(checkStatus.isAll ? '全选': '未全选')
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
   $('#layerDemo .layui-btn').on('click', function(){
    var othis = $(this), method = othis.data('method');
    active[method] ? active[method].call(this, othis) : '';
  });
   upload.render({
	    elem: '#test1'
	    ,url: '/resource/upload'
	    ,multiple: true
	    ,accept: 'file'
	    ,before: function(obj){
	      //预读本地文件示例，不支持ie8
	      obj.preview(function(index, file, result){
	        $('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" class="layui-upload-img">')
	      });
	    }
	    ,done: function(res){
	    	location.reload();
	    }
	  });
  var $ = layui.$, active = {
		    reload: function(){
		      var demoReload = $('#demoReload');
		      if(demoReload.val() == ""){
			    	return layer.msg("请输入查询条件");
			      }
		      table.reload('demo', {
		    	method: 'post',
		        where: {
		        		rName:  demoReload.val() 	
		        }
		      });
		    }
		  };
});
</script>
</body>
</html>

