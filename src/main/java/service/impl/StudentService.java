package service.impl;

import dto.StudentResult;
import dto.UploadStudentResult;
import entity.Student;
import java.io.InputStream;

import org.springframework.web.multipart.MultipartFile;
public interface StudentService {
	StudentResult list(int page, int limit, String sNum);
	void add(Student student);
	void update(Student student);
	void delete(Student student);
	UploadStudentResult importExcelInfo(InputStream in, MultipartFile file) throws Exception;
}
