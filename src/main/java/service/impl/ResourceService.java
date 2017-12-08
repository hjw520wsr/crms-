package service.impl;



import dto.ResourceResult;
import dto.UploadResourceResult;
import entity.Resource;

public interface ResourceService {
	ResourceResult list(int page, int limit, String rName);
	void update(Resource resource);
	void delete(Resource resource);
	void upload(Resource resource);
}
