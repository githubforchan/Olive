package com.olive.approval.dao;

import java.util.List;
import java.util.Map;

import com.olive.dto.Approver;
import com.olive.dto.Dept;
import com.olive.dto.Doc_Type;
import com.olive.dto.Document;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.dto.Reference;
import com.olive.dto.Doc_form;
import com.olive.utils.Criteria;
import com.olive.utils.dao.PagingDao;

public interface ApprovalDao extends PagingDao{
	public Emp selectEmp(String empno); //기안문서작성페이지 개인 정보
	public List<Doc_Type> selectDocType(); //기안 문서 작성페이지 문서 종류
	public List<Emp> getAllEmpList(); //결재선 결정시 
	public List<Dept> getAllDeptList(); //결재선 결정시 
	public List<Head> getAllHeadList(); //결재선 결정시 
	public void writeDocument(Document doc); //기안하기 문서 작성  
	public void insertApprover(Document doc); //결재자 추가 
	public void insertReferrer(Document doc); //참조자 추가
	public List<Document> getDocument(String empno); //전자결재 메인페이지
	public List<Document> getDocumentRec(String empno,int start, int size); //전자결재 메인페이지
	public List<Approver> getApprover(String empno); //전자결재 메인페이지 내가 받은 결재 
	public List<Approver> getApproverRec(String empno,int start, int size); //전자결재 메인페이지 페이징 내가 받은 결재 
	public List<Reference> getRefference(String empno); //전자결재 메인페이지 참조
	public List<Document> getArrangedDocList(String statusCode,String empno); //전자결재 내가 올린 결재 (테이블)
	public List<Approver> getArrangedAppList(String statusCode,String empno); //전자결재 내가 받은 결재 (테이블)
	public Document viewDocument(String docno); //하나의 문서 보기
	public List<Approver> viewApprovers(String docno); //내가  문서 승인자들 들고오기
	public void approve(Approver app);//승인
	public List<Map<String, Object>> getList(Criteria cri); //페이징용 문서 들고오기
	public int getAppListCount(Criteria cri); //페이징용 몇갠지 들고오기
	public List<Map<String, Object>> getAppList(Criteria cri); //페이징용 내가 승인자인 문서 들고오기 
	public String getMaxDocno(String typeCode); //문서 번호 생성용 
	public int checkTypeName(String typename); // 문서 양식 있는지 확인하기 
	public void addForm(Doc_Type doctype); //문서 양식 추가하기
	public String selectSpecialForm(String typename); // 기본적으로 등록되어 있는 문서 양식 보기
	public String selectForm(String formname); //(추가된)문서 양식 선택
	public List<Doc_form> formList(); //(추가된) 문서 양식 리스트
	public void deleteDoc(String docno); //(추가된) 문서 양식 삭제 
	public Doc_form getFormContent(String formName); //(추가된) 문서 양식 내용물 들고오기 
	public void deleteForm(String formName); //(추가된) 문서 양식 삭제
}
