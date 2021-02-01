package com.olive.approval.service;

import java.io.FileOutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.olive.approval.dao.ApprovalDao;
import com.olive.approval.utils.ApprovalCriteria;
import com.olive.dto.Approver;
import com.olive.dto.Dept;
import com.olive.dto.Doc_Type;
import com.olive.dto.Document;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.dto.Reference;
import com.olive.dto.Doc_form;
import com.olive.utils.service.PagingService;

@Service
public class ApprovalService extends PagingService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
		System.out.println(this.sqlsession);
	}
	
	//maxdocno
	public String getMaxDocno(String typeCode) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		
		return approvalDao.getMaxDocno(typeCode);
	}

	// 전체 뽑기
	public List<Document> getDocument(String empno) {
		System.out.println("empno는 "+empno);
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		List<Document> document = approvalDao.getDocument(empno);
		return document;
	}

	// 전자결재 메인페이지 들어올때 필요한 최근 문서 정보
	public List<Document> getDocument(String empno, int start, int size) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		List<Document> document = approvalDao.getDocumentRec(empno, start, size);

		return document;
	} 

	// 내가 기안한 문서 분류하기 (카운트용)
	public Map arrangeDoc(List<Document> document) {
		Map<String, List<Document>> arrangedDoc = new HashMap();
		List<Document> doc_ready = new ArrayList();
		List<Document> doc_ing = new ArrayList();
		List<Document> doc_cmp = new ArrayList();
		List<Document> doc_rej = new ArrayList();
		for (Document doc : document) {
			if (doc.getStatusCode() == 10) {
				doc_ready.add(doc);
			} else if (doc.getStatusCode() == 20) {
				doc_ing.add(doc);
			} else if (doc.getStatusCode() == 30) {
				doc_cmp.add(doc);
			} else if (doc.getStatusCode() == 40) {
				doc_rej.add(doc);
			}
		}
		arrangedDoc.put("doc_ready", doc_ready);
		arrangedDoc.put("doc_ing", doc_ing);
		arrangedDoc.put("doc_cmp", doc_cmp);
		arrangedDoc.put("doc_rej", doc_rej);

		return arrangedDoc;
	}
 
	// 내가 결재자인 문서 분류
	public Map arrangedAppDoc(List<Approver> approver) {
		Map<String, List<Approver>> arrangedAppDoc = new HashMap();
		List<Approver> doc_ready = new ArrayList();
		List<Approver> doc_ing = new ArrayList();
		List<Approver> doc_cmp = new ArrayList();
		List<Approver> doc_rej = new ArrayList();
		for (Approver doc : approver) {
			if (doc.getCurr_Approval() == 0 && doc.getApp_Order()==1) {
				doc_ready.add(doc);
			} else if (doc.getCurr_Approval() > 0 && doc.getTotal_Approval() > doc.getCurr_Approval()) {
				doc_ing.add(doc);
			} else if (doc.getCurr_Approval() == doc.getTotal_Approval() && doc.getStatusCode()==30) {
				doc_cmp.add(doc);
			} else {
				doc_rej.add(doc);
			}
		}

		arrangedAppDoc.put("doc_ready", doc_ready);
		arrangedAppDoc.put("doc_ing", doc_ing);
		arrangedAppDoc.put("doc_cmp", doc_cmp);
		arrangedAppDoc.put("doc_rej", doc_rej);

		return arrangedAppDoc;
	}

	public List<Approver> getApprover(String empno) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getApprover(empno);
	}

	public List<Approver> getApprover(String empno, int start, int size) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getApproverRec(empno, start, size);
	}

	//내가 참조자인 문서
	public List<Reference> getRefference(String empno) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getRefference(empno);
	}

	// 기안하기 페이지 들어갈때 필요한 개인정보
	public Emp selectEmp(String empno) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.selectEmp(empno);
	}

	// 기안하기 페이지 들어갈때 필요한 문서종류 정보
	public List<Doc_Type> selectDocType() {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.selectDocType();
	}

	@Transactional // 기안하기
	public void writeDoc(Document doc, HttpServletRequest request) throws Exception {
		Calendar cal = Calendar.getInstance();
		doc.setWritedate(cal.getTime());
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		List<Approver> appList = new ArrayList();
		List<Reference> refList = new ArrayList();

		CommonsMultipartFile multifile = doc.getFile();
		String filename = multifile.getOriginalFilename();
		String path = request.getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		String fpath = path + "/" + filename;

		if (!filename.equals("")) {
			// 실 파일 업로드
			try {
				FileOutputStream fs = new FileOutputStream(fpath);
				fs.write(multifile.getBytes());
				fs.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		doc.setFilename(filename);
		int i=0;
		// 결재자 추가
		for(String app : doc.getApprovers()) {
			if(!app.equals("")) {
				i++;
			}
		}
		doc.setTotal_Approval(i);
		System.out.println(doc.getTotal_Approval());
		System.out.println(doc.getReferrers());
		
		
		System.out.println(doc);

		// Transaction
		try {
			if (doc.getApprovers()!=null) {
				approvalDao.writeDocument(doc);
				approvalDao.insertApprover(doc);
			}
			if (doc.getReferrers() != null) {
				approvalDao.insertReferrer(doc);
			}
			System.out.println("정상처리");

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("Transaction Exception :" + e.getMessage());
			throw e;
		}

	}

	// 전자결재 메인페이지에서 결재상태 비동기용 , 개인 문서함
	public List<Document> getArrangedDocList(String statusCode, Principal principal) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
	
		
		return approvalDao.getArrangedDocList(statusCode, principal.getName());
	}

	// 전자결재 메인페이지에서 내가 받은 결재상태 비동기용 , 결재 문서함
	public List<Approver> getArrangedAppList(String statusCode, Principal principal) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);

		return approvalDao.getArrangedAppList(statusCode, principal.getName());
	}

	public List<Emp> getAllEmpList() { // 결재선용
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getAllEmpList();
	}

	public List<Dept> getAllDeptList() { // 결재선용
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getAllDeptList();
	}

	public List<Head> getAllHeadList() { // 결재선용
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getAllHeadList();
	}

	public Document viewDocumnet(String docno) {// 문서 조회시
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);

		return approvalDao.viewDocument(docno);
	}

	public List<Approver> viewApprovers(String docno) {// 문서 조회시 결재자
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);

		return approvalDao.viewApprovers(docno);
	} 
	public void approve(Approver app) {
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		approvalDao.approve(app);
	} 
	public int getListCount(ApprovalCriteria cri) {
		System.out.println("getListCount 서비스 시작");
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getListCount(cri);
	}	
	
	public int getAppListCount(ApprovalCriteria cri) {
		System.out.println("getListCount 서비스 시작");
		ApprovalDao approvalDao = sqlsession.getMapper(ApprovalDao.class);
		return approvalDao.getAppListCount(cri);
	}	
	
	public List<Map<String, Object>> getList(ApprovalCriteria cri) {
		System.out.println("getList 서비스 시작");
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.getList(cri);
	}
	public List<Map<String, Object>> getAppList(ApprovalCriteria cri) {
		System.out.println("getAppList 서비스 시작");
		System.out.println(cri);
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.getAppList(cri);
		
	}
	
	public int checkTypeName(String typename) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		
		return dao.checkTypeName(typename);
	}
	
	public void addForm(Doc_Type doctype) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		dao.addForm(doctype);
	}
	
	public String selectSpecialForm(String typename) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.selectSpecialForm(typename);
	}
	
	public String selectForm(String formname) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.selectForm(formname);
	}
	
	public List<Doc_form> formList() {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.formList(); 
	}
	
	public void deleteDoc(String docno) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		dao.deleteDoc(docno);
	}
	
	public Doc_form getFormContent(String formName) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		return dao.getFormContent(formName);
	}
	
	public void deleteForm(String formName) {
		ApprovalDao dao = sqlsession.getMapper(ApprovalDao.class);
		dao.deleteForm(formName);
	}
}
