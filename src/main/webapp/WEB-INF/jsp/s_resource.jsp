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
  	<legend>学习资源</legend>
	</fieldset>
	<div class="demoTable">
	<div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
	输入资源名称查询：
  	<div class="layui-inline">
    <input class="layui-input" name="rName"   id="demoReload" autocomplete="off">
  	</div>
  	<button class="layui-btn" data-type="reload">查询</button>
   </div>
   </div>
   <table class="layui-table" lay-data="{width: 1100, height:332, url:'/resource/list', page:true, id:'demo', limits:[30,60,90,150,300], limit:30, even: true}" lay-filter="demo">
  	<thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'rId', width:90, fixed: true}">ID</th>
      <th lay-data="{field:'rName', width:250}">资源名</th>
      <th lay-data="{field:'uploader', width:100}">上传者</th>
      <th lay-data="{field:'submitTime', width:200}">上传时间</th>
      <th lay-data="{field:'downNum', width:100}">下载人数</th>
      <th lay-data="{field:'remark', width:300}">备注</th>
      <th lay-data="{fixed: 'right', width:70, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
  <a class="layui-btn  layui-btn-mini" lay-event="download">下载</a>
</script>  
</div>
</div>
</div>
<script src="/layui/layui.js"></script>
<script>
layui.use(['laypage', 'table', 'element'], function(){
  laypage = layui.laypage //分页
  ,table = layui.table //表格
  ,element = layui.element; //元素操作
  //监听表格复选框选择
  table.on('checkbox(demo)', function(obj){
    console.log(obj)
  });
  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
	if(obj.event === 'download'){
		window.location.href="/resource/down?rId=" + obj.data.rId;            
    	layer.msg("下载中");
    } 
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

