package web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.StudentMapper;
import dao.TeacherMapper;
import entity.Student;
import entity.StudentExample;
import entity.Teacher;
import entity.TeacherExample;
import entity.TeacherExample.Criteria;

@Controller
public class ShowPage {
	@RequestMapping("/")
	public String showlogin() {
		return "login";
	}
	@Autowired
	private StudentMapper studentMapper;
	@Autowired
	private TeacherMapper teacherMapper;
	@RequestMapping("/login")
	public String showIndex(String username, String password, int type) {
		if (type == 0  ) {
			TeacherExample example = new TeacherExample();
			Criteria criteria = example.createCriteria();
			criteria.andTNumEqualTo(username);
			criteria.andPasswordEqualTo(password);
			if (teacherMapper.selectByExample(example) != null) {
				return "index";
			}
			else {
				return "login";
			}
		}
		else if (type == 1) {
			StudentExample example1 = new StudentExample();
			entity.StudentExample.Criteria criteria1 = example1.createCriteria();
			criteria1.andSNumEqualTo(username);
			criteria1.andPasswordEqualTo(password);
			if (studentMapper.selectByExample(example1) != null) {
				return "index2";
			}else {
				return "login";
			}
		}
		else {
			return "login";
		}
	}
	@RequestMapping("/student")
	public String showStudent() {
		return "student";
	}
	@RequestMapping("/addstudent")
	public String showAddStudent() {
		return "addstudent";
	}
	@RequestMapping("/resource")
	public String showResource() {
		return "resource";
	}
	@RequestMapping("/t_password")
	public String showTPassword() {
		return "t_password";
	}
	@RequestMapping("/s_password")
	public String showSPassword() {
		return "s_password";
	}
	@RequestMapping("s_resource")
	public String showsResource() {
		return "s_resource";
	}
}
