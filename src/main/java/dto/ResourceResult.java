package dto;

import java.util.List;

import entity.Resource;


public class ResourceResult {
	private int code;
	private String msg;
	private long count;
	private List<Resource> data;
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
	}
	public List<Resource> getData() {
		return data;
	}
	public void setData(List<Resource> data) {
		this.data = data;
	}
	
}
