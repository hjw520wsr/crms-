package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.StudentMapper;
import dao.TeacherMapper;
import entity.Student;
import entity.StudentExample;
import entity.StudentExample.Criteria;
import entity.Teacher;
import entity.TeacherExample;

@Service
public class PasswordServiceImpl implements PasswordService {
	@Autowired
	private TeacherMapper teacherMapper;
	@Autowired
	private StudentMapper studentMapper;
	public Boolean modifyTPassword(String tNum, String password, String oldpassword) {
		TeacherExample example = new TeacherExample();
		entity.TeacherExample.Criteria criteria = example.createCriteria();
		criteria.andTNumEqualTo(tNum);
		criteria.andPasswordEqualTo(oldpassword);
			if (teacherMapper.selectByExample(example).size() == 0) {
				return false;
			}else {
				Teacher teacher = teacherMapper.selectByExample(example).get(0);
				teacher.setPassword(password);
				teacherMapper.updateByPrimaryKey(teacher);
				return true;
			}
	}

	public Boolean modifySPassword(String sNum, String password, String oldpassword) {
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andSNumEqualTo(sNum);
		criteria.andPasswordEqualTo(oldpassword);
		if (studentMapper.selectByExample(example).size() == 0) {
			return  false;
		}else {
			Student student = studentMapper.selectByExample(example).get(0);
			student.setPassword(password);
			studentMapper.updateByPrimaryKey(student);
			return true;
		}
			
		
		
	}

}
