package service.impl;

import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dao.ResourceMapper;
import dto.ResourceResult;
import dto.UploadResourceResult;
import entity.Resource;
import entity.ResourceExample;
import entity.ResourceExample.Criteria;
@Service
public class ResourceServiceImpl implements ResourceService {
@Autowired
private ResourceMapper resourceMapper;
	public ResourceResult list(int page, int limit, String rName) {
		PageHelper.startPage(page,limit);
		ResourceExample example = new ResourceExample();
		if (rName != null ) {
			Criteria criteria = example.createCriteria();
			criteria.andRNameEqualTo(rName);
		}
		List<Resource> list = resourceMapper.selectByExample(example);
		ResourceResult resultList = new ResourceResult();
		resultList.setData(list);
		PageInfo<Resource> pageInfo = new PageInfo<Resource>(list);
		resultList.setCount(pageInfo.getTotal());
		return resultList;
	}

	public void update(Resource resource) {
		resourceMapper.updateByPrimaryKey(resource);
	}

	public void delete(Resource resource) {
		resourceMapper.deleteByPrimaryKey(resource.getrId());
	}

	public void upload(Resource resource) {
		resourceMapper.insertSelective(resource);
	}



}
