package web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import service.impl.PasswordService;

@Controller
public class PasswordController {
	@Autowired
	private PasswordService passwordService;
	@RequestMapping("/tpassword")
	public String modifyTPassword(String tNum, String password, String oldpassword) {
		if (passwordService.modifyTPassword(tNum, password,oldpassword)) {
			return "login";
		}else {
			return "t_password";
		}
		
	}
	@RequestMapping("/spassword")
	public String modifySPassword(String sNum, String password, String oldpassword) {
		if (passwordService.modifySPassword(sNum, password,oldpassword)) {
			return "login";
		}else {
			return "s_password";
		}
	}
}
