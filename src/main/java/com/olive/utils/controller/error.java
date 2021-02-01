package com.olive.utils.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class error {
//	@GetMapping
//	public String defaultError() {
//		return "error/default";
//	}
//
//	@GetMapping("/no-resource")
//	public String noResource() {
//		return "error/noResource";
//	}

	@RequestMapping(value = "404.do")
	public String Error404() {
		return "error/404";
	}
	@RequestMapping(value = "403.do")
	public String Error403() {
		return "error/403";
	}
	@RequestMapping(value = "500.do")
	public String Error500() {
		return "error/500";
	}

}