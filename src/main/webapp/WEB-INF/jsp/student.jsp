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
  	<legend>学生信息</legend>
	</fieldset>
	<div class="demoTable">
    <div class="site-demo-button" id="layerDemo" style="margin-bottom: 0;">
    <a href = "/addstudent"><button data-method="add" class="layui-btn">添加学生</button></a>
    <button type="button" class="layui-btn" id="test1">
  	<i class="layui-icon">&#xe67c;</i>批量导入学生数据
	</button>
	
	输入学号查询：
  	<div class="layui-inline">
    <input class="layui-input" name="sNum"   id="demoReload" autocomplete="off">
  	</div>
  	<button class="layui-btn" data-type="reload">查询</button>
   </div>
    </div>
    <table class="layui-table" lay-data="{width: 1110, height:730, url:'/student/list', page:true, id:'demo', limits:[30,60,90,150,300], limit:30, even: true}" lay-filter="demo">
  	<thead>
    <tr>
      <th lay-data="{checkbox:true, fixed: true}"></th>
      <th lay-data="{field:'sId', width:100, fixed: true}">ID</th>
      <th lay-data="{field:'sName', width:150, edit: true}">姓名</th>
      <th lay-data="{field:'sNum', width:150, edit: true, sort: true}">学号</th>
      <th lay-data="{field:'sex', width:150, edit: true}">性别</th>
      <th lay-data="{field:'tel', width:150, edit: true}">联系方式</th>
      <th lay-data="{field:'institute', width:150, edit: true}">学院</th>
      <th lay-data="{field:'major', width:150, edit: true}">专业</th>
      <th lay-data="{fixed: 'right', width:70, align:'center', toolbar: '#barDemo'}"></th>
    </tr>
  </thead>
</table>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del">删除</a>
</script>    
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
        	url:  '/student/delete',
        	data: obj.data
        })
      });
    } 
  });
  table.on('edit(demo)', function(obj){
    var value = obj.value //得到修改后的值
    ,data = obj.data //得到所在行所有键值
    ,field = obj.field; //得到字段
    data[field] = value;
    layer.msg('[ID: '+ data.sId+'] ' + field + ' 字段更改为：'+ value);
    $.ajax({
    	type: "post",
    	url:  '/student/update',
    	data: obj.data	
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
  	,url: '/student/import'
  	,accept: 'file'
  	,size: 0
  	,auto: true
  	,exts: 'xls|xlsx'
  	,done: function(res, index, upload){ //上传后的回调
  		if(res.code == 200){
  			return layer.msg("导入成功");
  		}
  		if(res.code > 0){
        return layer.msg('导入失败');
      }
  }
  	,error: function(){
      var demoText = $('#demoText');
      demoText.html('<span style="color: #FF5722;">导入失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
      demoText.find('.demo-reload').on('click', function(){
        upload.upload();
      });
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
		        		sNum:  demoReload.val()
		        }
		      });
		      
		    }
		  };
});
</script>
</body>
</html>

