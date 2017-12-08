package service.impl;

public interface PasswordService {
	Boolean modifyTPassword(String tNum, String password, String oldpassword);
	Boolean modifySPassword(String sNum, String password, String oldpassword);
}
