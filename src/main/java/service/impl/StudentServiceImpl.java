package service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dao.StudentMapper;
import dto.StudentResult;
import dto.UploadStudentResult;
import entity.Student;
import entity.StudentExample;
import entity.StudentExample.Criteria;
import utils.ExcelUtil;
@Service
public class StudentServiceImpl implements StudentService {
	@Autowired
	private StudentMapper studentMapper;
	public StudentResult list(int page, int limit, String sNum) {
		PageHelper.startPage(page,limit);
		StudentExample example = new StudentExample();
		if (sNum != null ) {
			Criteria criteria = example.createCriteria();
			criteria.andSNumEqualTo(sNum);
		}
		List<Student> list = studentMapper.selectByExample(example);
		StudentResult resultList = new StudentResult();
		resultList.setData(list);
		PageInfo<Student> pageInfo = new PageInfo<Student>(list);
		resultList.setCount(pageInfo.getTotal());
		return resultList;
	}

	public void add(Student student) {
		student.setPassword(student.getsNum().substring(4));
		studentMapper.insert(student);
	}

	public void update(Student student) {
		studentMapper.updateByPrimaryKey(student);
	}

	public void delete(Student student) {
		studentMapper.deleteByPrimaryKey(student.getsId());
	}

	public UploadStudentResult importExcelInfo(InputStream in, MultipartFile file) throws Exception {
		List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());  
	    List<Student> studentlist = new ArrayList<Student>();  
	    //遍历listob数据，把数据放到List中  
	    for (int i = 0; i < listob.size(); i++) {  
	        List<Object> ob = listob.get(i);  
	        Student student = new Student();   
	        //通过遍历实现把每一列封装成一个model中，再把所有的model用List集合装载  
	        student.setsNum(String.valueOf(ob.get(0)));
	        student.setsName(String.valueOf(ob.get(1)));
	        student.setPassword(String.valueOf(ob.get(0)).substring(4));
	        student.setSex(String.valueOf(ob.get(2)));
	        student.setTel(String.valueOf(ob.get(3)));
	        student.setInstitute(String.valueOf(ob.get(4)));
	        student.setMajor(String.valueOf(ob.get(5)));  
	        studentlist.add(student); 
	    }  
	    UploadStudentResult uploadStudentResult = new UploadStudentResult();
	    uploadStudentResult.setData(studentlist);
	    //批量插入  
	    studentMapper.insertInfoBatch(studentlist); 
	    return uploadStudentResult;
	}

}
