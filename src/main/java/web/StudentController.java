package web;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dto.StudentResult;
import dto.UploadStudentResult;
import entity.Student;
import service.impl.StudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private StudentService studentService;
	@RequestMapping("/list")
	@ResponseBody
	public StudentResult list(int page, int limit, String sNum) {
		return studentService.list(page, limit, sNum);
	}
	@RequestMapping("/update")
	@ResponseBody
	public void update(Student student) {
		studentService.update(student);
	}
	@RequestMapping("/add")
	public String add(Student student) {
		studentService.add(student);
		return "addstudent";
	}
	@RequestMapping("/delete")
	@ResponseBody
	public void delete(Student student) {
		studentService.delete(student);
	}
	//导入excel数据
	@RequestMapping("/import")
	@ResponseBody
	public UploadStudentResult importExcel(HttpServletRequest request, Model model,@RequestParam(value="file") MultipartFile file) throws Exception {  
	     //获取上传的文件  
	     MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;    
	     InputStream in = file.getInputStream();  
	     //数据导入  
	     UploadStudentResult uploadStudentResult = new UploadStudentResult();
	     uploadStudentResult = studentService.importExcelInfo(in,file);  
	     in.close();  
	     return uploadStudentResult ;  
	}
}
