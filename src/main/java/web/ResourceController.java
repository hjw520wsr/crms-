package web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.ResourceMapper;
import dto.ResourceResult;
import dto.UploadResourceResult;
import entity.Resource;
import service.impl.ResourceService;

@Controller
@RequestMapping("/resource")
public class ResourceController {
	@Autowired
	private ResourceService resourceService;
	@Autowired
	private ResourceMapper resourceMapper;
	@RequestMapping("/list")
	@ResponseBody
	public ResourceResult list(int page, int limit, String rName) {
		return resourceService.list(page, limit, rName);
	}
	@RequestMapping("/update")
	@ResponseBody
	public void update(@RequestBody Resource resource, HttpServletRequest request) {
		//修改文件名
		File file = new File(resource.getUrl());
		String newfilepath = request.getSession().getServletContext().getRealPath("") + "//upload//" + resource.getrName();
		file.renameTo(new File(newfilepath));
		resourceService.update(resource);
	}
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(@RequestBody Resource resource) {
		File file = new File(resource.getUrl());
		file.delete();
		resourceService.delete(resource);
	}
	@RequestMapping("/upload")
	@ResponseBody
	public UploadResourceResult upload(@RequestParam(value="file") MultipartFile[] file , HttpSession session) {
		List<Resource> list = new ArrayList<Resource>();
		for (MultipartFile multipartFile : file) {
			Resource resource = new Resource();
			String name = multipartFile.getOriginalFilename();
			String path = session.getServletContext().getRealPath("/upload");
			File file1 = new File(path, name);
			try {
				multipartFile.transferTo(file1);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			resource.setDownNum(0);
			resource.setrName(name);
			resource.setUrl(path + "\\" + name);
			resource.setUploader("");
			resource.setSubmitTime(new Date());
			resource.setRemark("");
			list.add(resource);
			resourceService.upload(resource);
		}
		UploadResourceResult result = new UploadResourceResult();
		result.setData(list);
		return result;
	}
	@RequestMapping("down")
	public void download(Integer rId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//下载人数加1
		System.out.println(rId);
		Resource resource = resourceMapper.selectByPrimaryKey(rId);
		resource.setDownNum(resource.getDownNum() + 1);
		resourceMapper.updateByPrimaryKeySelective(resource);
		request.setCharacterEncoding("UTF-8"); 
		response.setCharacterEncoding("UTF-8");
		String rName = resource.getrName();
		//rName = java.net.URLDecoder.decode(request.getParameter("rName"),"UTF-8"); 
		// 1.获取需要下载的文件  
	    String path = request.getSession().getServletContext().getRealPath("") + "//upload//" + rName;  
	    // 2.通知浏览器以下载方式打开  
	    // 如果文件名中包含中文，则文件名要进行URL编码，URLEncoding.encode;如果不进行编码则文件名显示错误并且不可下载。  
	    response.setHeader("content-disposition", "attachment;filename="  
	            + new String(rName.getBytes("utf-8"), "ISO8859-1"));  
	    // 3.向浏览器写出数据  
	    FileInputStream in = null;  
	    try {  
	        OutputStream out = response.getOutputStream();  
	        in = new FileInputStream(path);  
	        byte buffer[] = new byte[1024];  
	        int len = 0;  
	        while ((len = in.read(buffer)) > 0) {  
	            out.write(buffer, 0, len);  
	        }  
	    } finally {  
	        if (in != null) {  
	            in.close(); // 关闭流  
	        }  
	    }  
	}
    }  
	

