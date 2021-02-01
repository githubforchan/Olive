package com.olive.utils.dao;

import java.util.List;
import java.util.Map;

import com.olive.dto.Approver;
import com.olive.utils.Criteria;

public interface PagingDao {
	public int getListCount(Criteria cri);
	public List<Map<String, Object>> getList(Criteria cri);
}


	