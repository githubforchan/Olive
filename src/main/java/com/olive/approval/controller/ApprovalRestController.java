package com.olive.approval.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.olive.approval.service.ApprovalService;
import com.olive.approval.utils.ApprovalCriteria;
import com.olive.dto.Approver;
import com.olive.dto.Dept;
import com.olive.dto.Doc_form;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.utils.Pagination;

@RestController
@RequestMapping("/approval/")
public class ApprovalRestController {

	@Autowired
	private ApprovalService approvalService;

	@RequestMapping(value = "/getMaxDocno.do")
	private String getMaxDocno(String typeCode) {
		System.out.println(
				"sijdiofjsdijfsiodjfios;adajsdif;asj iofjisdjfi asjdif ajsdiof jasido fjiaosdjfioasjdiofajsdiof jasid;fjaisdjfioasdjfiasjdifjaisdfjiaso;di");
		return approvalService.getMaxDocno(typeCode);
	}

	@RequestMapping(value = "/getAllEmpList.do")
	private List<Emp> getAllEmpList() {

		return approvalService.getAllEmpList();
	}

	@RequestMapping(value = "/getAllDeptList.do")
	private List<Dept> getAllDeptList() {

		return approvalService.getAllDeptList();
	}

	@RequestMapping(value = "/getAllHeadList.do")
	private List<Head> getAllHeadList() {

		return approvalService.getAllHeadList();
	}

	@RequestMapping(value = "/getArrangedDocList.do")
	private Map<String, Object> getArrangedDocList(String statusCode, String size, Principal principal,
			ApprovalCriteria cri) {
		cri.setCriteria("getDoc", "docno", "desc");
		cri.setSearchType("empno");
		cri.setKeyword(principal.getName());
		cri.setSearchType2("statusCode");
		cri.setKeyword2(statusCode);

		int totalCount = approvalService.getListCount(cri);

		Pagination pagenation = new Pagination(cri, totalCount);

		List<Map<String, Object>> pagingList = approvalService.getList(cri);

		Map<String, Object> list = new HashMap<String, Object>();
		list.put("criteria", cri);
		list.put("pagination", pagenation);
		list.put("pagingList", pagingList);

		return list;
	}

	@RequestMapping(value = "/getArrangedDocListAjax.do")
	private JSONObject getArrangedDocList(ApprovalCriteria cri) {
		cri.setCriteria("getDoc", "docno", "desc");

		int totalCount = approvalService.getListCount(cri);

		Pagination pagenation = new Pagination(cri, totalCount);

		List<Map<String, Object>> pagingList = approvalService.getList(cri);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pagingList", pagingList);
		jsonObject.put("pagination", pagenation);
		jsonObject.put("criteria", cri);

		return jsonObject;
	}

	// 참조하기 전용
	@RequestMapping(value = "/getArrangedAppListRef.do")
	private Map<String, Object> getArrangedRefList(String statusCode, Principal principal, ApprovalCriteria cri) {
		
		cri.setCriteria("getapproverdocrec", "docno", "desc");
		cri.setSearchType("empno");
		cri.setKeyword(principal.getName());
		cri.setSearchType2("statusCode");
		cri.setKeyword2(statusCode);

		int totalCount = approvalService.getAppListCount(cri);
		System.out.println(totalCount);
		Pagination pagination = new Pagination(cri, totalCount);
		System.out.println(cri);
		System.out.println(pagination);
		List<Map<String, Object>> pagingList = approvalService.getAppList(cri);

		Map<String, Object> list = new HashMap<String, Object>();
		list.put("criteria", cri);
		list.put("pagination", pagination);
		list.put("pagingList", pagingList); // 이게 결과값이랬음
		System.out.println("결과 : " + pagingList);

		return list;
	}

	@RequestMapping(value = "/getArrangedAppList.do")
	private Map<String, Object> getArrangedAppList(String statusCode, Principal principal, ApprovalCriteria cri) {
		System.out.println("statuscode:"+statusCode);
		cri.setCriteria("getApproverDoc", "docno", "desc");
		cri.setSearchType("empno");
		cri.setKeyword(principal.getName());
		cri.setSearchType2("statusCode");
		cri.setKeyword2(statusCode);

		int totalCount = approvalService.getAppListCount(cri);

		Pagination pagination = new Pagination(cri, totalCount);

		List<Map<String, Object>> pagingList = approvalService.getAppList(cri);

		Map<String, Object> list = new HashMap<String, Object>();
		list.put("criteria", cri);
		list.put("pagination", pagination);
		list.put("pagingList", pagingList); // 이게 결과값이랬음

		return list;
	}

	@RequestMapping(value = "/getArrangedAppListAjax.do", method = RequestMethod.POST)
	private JSONObject getArrangedAppList(ApprovalCriteria cri) {
		cri.setCriteria("getApproverDoc", "docno", "desc");
		System.out.println("getArrangedAppListAjax");
		int totalCount = approvalService.getAppListCount(cri);

		Pagination pagenation = new Pagination(cri, totalCount);

		List<Map<String, Object>> pagingList = approvalService.getAppList(cri);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("pagingList", pagingList);
		jsonObject.put("pagination", pagenation);
		jsonObject.put("criteria", cri);

		return jsonObject;
	}

	@RequestMapping(value = "/approve.do", method = RequestMethod.POST)
	private String approve(@RequestBody Approver app) {
		System.out.println(app);
		approvalService.approve(app);

		return "/approval/ProgressDoc.do";
	}

	@RequestMapping(value = "/download.do")
	private void download(@RequestParam String filename, HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 물리적 경로 얻기
		String downloadpath = request.getServletContext().getRealPath("/resources/upload");
		String FilePath = downloadpath + "/" + filename;
		// IO작업 하기
		File file = new File(FilePath);
		System.out.println(FilePath);
		// 파일을 읽어서 출력
		byte[] b = new byte[10000000]; // 4kb //요기는 필요에 따라 조정 가능
		FileInputStream in;
		ServletOutputStream out2;
		try {
			in = new FileInputStream(file);
			String sMimeType = request.getServletContext().getMimeType(FilePath); // 파일의 타입 정보
			System.out.println(sMimeType);
			if (sMimeType == null) {
				sMimeType = "application/octet-stream";
			}

			response.setContentType(sMimeType);

			response.setHeader("Content-Disposition",
					"attachment;filename=" + new String(filename.getBytes(), "ISO8859_1")); // filename.getBytes(),"ISO8859_1")
			out2 = response.getOutputStream();
			int numread;

			while ((numread = in.read(b, 0, b.length)) != -1) {
				out2.write(b, 0, numread);
			}

			out2.flush();
			out2.close();
			in.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

	}

	@RequestMapping(value = "checktypeName.do")
	private int checkTypeName(String typename) {
		System.out.println(typename);
		return approvalService.checkTypeName(typename);
	}

	@RequestMapping(value = "selectSpecialForm.do")
	private Map<String, String> selectSpecialForm(String typename) {
		Map<String, String> map = new HashMap<>();
		map.put("typename", approvalService.selectSpecialForm(typename));
		return map;
	}

	@RequestMapping(value = "selectForm.do")
	private Map<String, String> selectForm(String formname) {
		Map<String, String> map = new HashMap<>();
		map.put("formname", approvalService.selectForm(formname));
		return map;
	}

	@RequestMapping(value = "deleteDoc.do")
	private String deleteDoc(String docno) {

		approvalService.deleteDoc(docno);
		return "/approval/PersonalDoc.do";
	}
	
	@RequestMapping(value="getFormContent.do")
	private Doc_form getFormContent(String formName) {
		return approvalService.getFormContent(formName);
	}
	@RequestMapping(value="deleteForm.do")
	private void deleteForm(String formName) {
		approvalService.deleteForm(formName);
	}

}
