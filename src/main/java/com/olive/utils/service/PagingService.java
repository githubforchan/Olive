package com.olive.utils.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.olive.utils.Criteria;
import com.olive.utils.dao.PagingDao;

@Service
@Component
public class PagingService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	public List<Map<String, Object>> getList(Criteria cri) {
		System.out.println("getList 서비스 시작");
		PagingDao dao = sqlsession.getMapper(PagingDao.class);
		return dao.getList(cri);
	}

	public int getListCount(Criteria cri) {
		System.out.println("getListCount 서비스 시작");
		PagingDao dao = sqlsession.getMapper(PagingDao.class);
		return dao.getListCount(cri);
	}
}
