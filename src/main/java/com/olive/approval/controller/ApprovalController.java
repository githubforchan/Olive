package com.olive.approval.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.olive.approval.service.ApprovalService;
import com.olive.approval.utils.ApprovalCriteria;
import com.olive.dto.Approver;
import com.olive.dto.Doc_Type;
import com.olive.dto.Document;
import com.olive.dto.Emp;
import com.olive.dto.Doc_form;
import com.olive.utils.Pagination;

@Controller
@RequestMapping("/approval/")
public class ApprovalController {
	private ApprovalService approvalService;

	@Autowired
	public void setApprovalService(ApprovalService approvalService) {
		this.approvalService=approvalService;
	}
	
	
	
	//전자결재 메인페이지
	@RequestMapping(value = "ApprovalHome.do", method = RequestMethod.GET)
	public String approvalHome(Model model,Principal principal) {
		String empno = principal.getName();
		//전체 내가올린 문서 
		List<Document> document = approvalService.getDocument(empno);
		List<Document> documentrec = approvalService.getDocument(empno,0,3);
		//전체 내가 결재 해야할 문서
		List<Approver> approver = approvalService.getApprover(empno);
		List<Approver> approverrec = approvalService.getApprover(empno,0,3);
		
		model.addAttribute("arrangedDoc", approvalService.arrangeDoc(document));
		model.addAttribute("arrangedAppDoc", approvalService.arrangedAppDoc(approver));
		
		model.addAttribute("approver", approverrec);
		model.addAttribute("document", documentrec);
		return "approval/ApprovalHome";
	}
	
	@RequestMapping(value = "DocWrite.do", method = RequestMethod.GET)
	public String docWrite(Model model, HttpServletRequest request) {
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		model.addAttribute("time", sf.format(nowTime));
		String empno = request.getUserPrincipal().getName();
		Emp emp = approvalService.selectEmp(empno);
		List<Doc_Type> docType = approvalService.selectDocType();
		List<Doc_form> form = approvalService.formList();
		
		model.addAttribute("formList",form);
		model.addAttribute("docType", docType);
		model.addAttribute("emp", emp);
		
		
		return "approval/DocWirte";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value="DocWrite.do", method=RequestMethod.POST)
	public String docInsert(Document doc,BindingResult result,HttpServletRequest request) {
		try {
			approvalService.writeDoc(doc,request);
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		return "redirect:/approval/ApprovalHome.do";
	}
	
	@RequestMapping(value = "PersonalDoc.do", method = RequestMethod.GET)
	public String showPersonalDoc(ApprovalCriteria cri, Principal principal,Model model) {
		String empno = principal.getName();
		cri.setCriteria("getDoc", "docno", "desc");
		cri.setSearchType("empno");
		cri.setKeyword(empno);
		int totalCount =approvalService.getListCount(cri);
		System.out.println(totalCount);
		Pagination pagenation = new Pagination(cri,totalCount);
		List<Map<String,Object>> pagingList = approvalService.getList(cri);
		System.out.println(cri);
		 
		List<Document> document = approvalService.getDocument(empno,0,10);
		System.out.println(approvalService.arrangeDoc(document));
		
		model.addAttribute("criteria", cri); //이전에 조회 했던 데이터
		model.addAttribute("pagination", pagenation); //페이징 처리 위해서 몇개 있는지 알 수 있음 
		model.addAttribute("pagingList", pagingList); //데이터 결과값 
		
		return "approval/PersonalDoc";
	}
	
	@RequestMapping(value = "ProgressDoc.do", method = RequestMethod.GET)
	public String showPregressDoc(ApprovalCriteria cri,Model model, Principal principal) {
		String empno = principal.getName();
		cri.setCriteria("getApproverDoc", "docno", "desc");
		cri.setSearchType("empno");
		cri.setKeyword(empno);
		
		int totalCount =approvalService.getAppListCount(cri);
		System.out.println(totalCount);
		Pagination pagenation = new Pagination(cri,totalCount);
		List<Map<String,Object>> pagingList = approvalService.getList(cri);
		System.out.println(cri);
		
		List<Document> document = approvalService.getDocument(empno,0,10);
		System.out.println(approvalService.arrangeDoc(document));
		
		model.addAttribute("criteria", cri); //이전에 조회 했던 데이터
		model.addAttribute("pagination", pagenation); //페이징 처리 위해서 몇개 있는지 알 수 있음 
		model.addAttribute("pagingList", pagingList); //데이터 결과값 
		
		
		List<Approver> approverDoc = approvalService.getApprover(empno);
		model.addAttribute("appdoc", approverDoc);
		System.out.println(pagingList);
		System.out.println(approverDoc);
		return "approval/ProgressDoc";
	}
	

	@RequestMapping(value = "viewDocument.do", method = RequestMethod.GET)
	public String viewDocument(String docno,Model model,Principal principal) {
		Document document = approvalService.viewDocumnet(docno); 
		Emp emp = approvalService.selectEmp(principal.getName());
		List<Approver> apps = approvalService.viewApprovers(docno);
		model.addAttribute("document", document);
		model.addAttribute("emp",emp);
		model.addAttribute("apps",apps);
	
		return "papers/document"; 
	}
	
	@RequestMapping(value="AddForm.do", method=RequestMethod.GET)
	public String AddFormPage(Model model) {
		List<Doc_form> formList = approvalService.formList();
		model.addAttribute("formList",formList);
		
		return "approval/AddForm";
	}
	
	@RequestMapping(value="AddForm.do", method=RequestMethod.POST)
	public String AddForm(Doc_Type doctype) {
		
		System.out.println();
		approvalService.addForm(doctype);
		return "redirect:/approval/ApprovalHome.do";
	}
	
	
	
}
