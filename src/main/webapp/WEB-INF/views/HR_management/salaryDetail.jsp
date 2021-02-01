<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=Content-Type
	content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 15">
<link rel=File-List href="real급여명세서.files/filelist.xml">
<style id="급여명세서_8672_Styles">
<!--
table {
	mso-displayed-decimal-separator: "\.";
	mso-displayed-thousand-separator: "\,";
}

.font58672 {
	color: windowtext;
	font-size: 8.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
}

.xl638672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl648672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl658672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: normal;
}

.xl668672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl678672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: 1.0pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl688672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl698672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl708672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl718672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl728672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl738672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl748672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: underline;
	text-underline-style: single;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl758672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: underline;
	text-underline-style: single;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl768672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl778672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl788672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl798672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 20.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl808672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: underline;
	text-underline-style: single;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl818672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl828672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl838672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: 1.0pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl848672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: 1.0pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl858672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl868672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl878672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl888672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl898672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl908672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl918672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl928672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: none;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl938672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: 1.0pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl948672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: 1.0pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl958672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: 1.0pt solid windowtext;
	border-bottom: 1.0pt solid windowtext;
	border-left: none;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl968672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl978672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl988672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl998672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1008672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1018672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1028672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1038672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 1.0pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1048672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: 1.0pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1058672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: 1.0pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1068672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: 1.0pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1078672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1088672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1098672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: 2.0pt double windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1108672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: 2.0pt double windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1118672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: 2.0pt double windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1128672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 2.0pt double windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: 1.0pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1138672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 2.0pt double windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

.xl1148672 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 돋움, monospace;
	mso-font-charset: 129;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: 2.0pt double windowtext;
	border-right: 1.0pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	background: white;
	mso-pattern: black none;
	white-space: nowrap;
}

ruby {
	ruby-align: left;
}

rt {
	color: windowtext;
	font-size: 8.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: "맑은 고딕", monospace;
	mso-font-charset: 129;
	mso-char-type: none;
}
-->
</style>
<title>급여명세서</title>
</head>
<body>
<c:set var="salaryInfo" value="${salaryInfo}"/>
	<!--[if !excel]>　　<![endif]-->
	<!--다음 내용은 Microsoft Excel의 웹 페이지로 게시 마법사를 사용하여 작성되었습니다.-->
	<!--같은 내용의 항목이 다시 게시되면 DIV 태그 사이에 있는 내용이 변경됩니다.-->
	<!----------------------------->
	<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 시작 -->
	<!----------------------------->
	<div style="text-align:right">
		<input id="printBtn" type="button" value="인쇄하기">
	</div>
	<div>
	<br>
	</div>
	
	<div id="print" align=center x:publishsource="Excel">

		<table border=0 cellpadding=0 cellspacing=0 width=660 class=xl638672
			style='border-collapse: collapse; table-layout: fixed; width: 500pt'>
			<col class=xl638672 width=33 span=20 style='width: 25pt'>
			<tr height=29 style='mso-height-source: userset; height: 21.9pt'>
				<td colspan=13 rowspan=2 height=58 class=xl768672 width=429
					style='border-right: .5pt solid black; height: 43.8pt; width: 325pt'><a
					name="RANGE!A1:T29">급 여 지 급 명 세 서</a></td>
				<td colspan=2 class=xl968672 width=66
					style='border-left: none; width: 50pt'>소<span
					style='mso-spacerun: yes'>&nbsp;&nbsp; </span>속
				</td>
				<td colspan=5 class=xl978672 width=165
					style='border-right: 1.0pt solid black; border-left: none; width: 125pt'>${salaryInfo.headname} / ${salaryInfo.deptname}</td>
			</tr>
			<tr height=29 style='mso-height-source: userset; height: 21.9pt'>
				<td colspan=2 height=29 class=xl998672
					style='height: 21.9pt; border-left: none'>성<span
					style='mso-spacerun: yes'>&nbsp;&nbsp; </span>명
				</td>
				<td colspan=5 class=xl1008672
					style='border-right: 1.0pt solid black; border-left: none'>${salaryInfo.ename}</td>
			</tr>
			<tr height=29 style='mso-height-source: userset; height: 21.9pt'>
				<td colspan=13 rowspan=2 height=58 class=xl808672
					style='border-right: .5pt solid black; height: 43.8pt'>${fn:substring(salaryInfo.sal_date,0,4)}년<span
					style='mso-spacerun: yes'>&nbsp; </span>${fn:substring(salaryInfo.sal_date,5,7)}월
				</td>
				<td colspan=2 class=xl998672 style='border-left: none'>입사일</td>
				<td colspan=5 class=xl1008672
					style='border-right: 1.0pt solid black; border-left: none'>${salaryInfo.hiredate}</td>
			</tr>
			<tr height=29 style='mso-height-source: userset; height: 21.9pt'>
				<td colspan=2 height=29 class=xl998672
					style='height: 21.9pt; border-left: none'>직<span
					style='mso-spacerun: yes'>&nbsp;&nbsp; </span>위
				</td>
				<td colspan=5 class=xl1008672
					style='border-right: 1.0pt solid black; border-left: none'>${salaryInfo.positionname} / ${salaryInfo.classname}</td>
			</tr>
			<tr height=29 style='mso-height-source: userset; height: 21.9pt'>
				<td height=29 class=xl818672 style='height: 21.9pt'></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl658672 width=33 style='width: 25pt'></td>
				<td class=xl658672 width=33 style='width: 25pt'></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl668672></td>
				<td class=xl668672></td>
				<td class=xl668672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl668672></td>
				<td class=xl668672></td>
				<td class=xl828672></td>
			</tr>
			<tr height=34 style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=20 height=34 class=xl838672
					style='border-right: 1.0pt solid black; height: 26.1pt'>1. 실
					지급액</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=6 height=34 class=xl1028672 style='height: 26.1pt'>지급
					합계</td>
				<td colspan=6 class=xl968672 style='border-left: none'>공제 합계</td>
				<td colspan=8 class=xl968672
					style='border-right: 1.0pt solid black; border-left: none'>실
					수령액</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=6 height=34 class=xl1048672 style='height:26.1pt' >&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.totalIncome}원</td>
				<td colspan=6 class=xl1058672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.exemption}원</td>
				<td colspan=8 class=xl1058672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.afterTaxIncome}원</td>
			</tr>
			<tr class=xl638672 height=29
				style='mso-height-source: userset; height: 21.9pt'>
				<td height=29 class=xl818672 style='height: 21.9pt'></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl648672></td>
				<td class=xl668672></td>
				<td class=xl668672></td>
				<td class=xl828672></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=20 height=34 class=xl858672
					style='border-right: 1.0pt solid black; height: 26.1pt'>2. 지급
					내역</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=10 height=34 class=xl1078672 style='height: 26.1pt'>지급항목</td>
				<td colspan=10 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>공제항목</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>기본급여</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.basic_pay}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'>소 득 세</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.income_tax}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>시간외
					수당</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.overtime_pay}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'>지방소득세</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.local_income_tax}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>직책수당</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.position_pay}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'>고용보험</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.employment_insurance}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>상
					여 금</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.bonus}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'>건강보험</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.health_insurance}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>차량유지</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.maintenance_of_vehicle}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'>요양보험</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.care_insurance}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>식<span
					style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span>대</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.mess_allowance}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'><span
					style='mso-spacerun: yes'>국민연금</span>
				</td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.national_pension}원</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>교육지원</td>
				<td colspan=6 class=xl998672 style='border-left: none'>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;${salaryInfo.educational_supports}원</td>
				<td colspan=4 class=xl998672 style='border-left: none'></td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl998672 style='border-left: none'></td>
				<td colspan=4 class=xl998672 style='border-left: none'></td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl998672 style='border-left: none'></td>
				<td colspan=4 class=xl998672 style='border-left: none'></td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl998672 style='border-left: none'></td>
				<td colspan=4 class=xl998672 style='border-left: none'></td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1078672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl998672 style='border-left: none'></td>
				<td colspan=4 class=xl998672 style='border-left: none'></td>
				<td colspan=6 class=xl998672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1098672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl1108672 style='border-left: none'></td>
				<td colspan=4 class=xl1108672 style='border-left: none'></td>
				<td colspan=6 class=xl1108672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=4 height=34 class=xl1128672 style='height: 26.1pt'>
				</td>
				<td colspan=6 class=xl1138672 style='border-left: none'></td>
				<td colspan=4 class=xl1138672 style='border-left: none'></td>
				<td colspan=6 class=xl1138672
					style='border-right: 1.0pt solid black; border-left: none'></td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=20 rowspan=2 height=68 class=xl878672
					style='border-right: 1.0pt solid black; height: 52.2pt'>노고에
					대단히 감사드립니다.</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=20 height=34 class=xl898672
					style='border-right: 1.0pt solid black; height: 26.1pt'>${fn:substring(salaryInfo.sal_date,0,4)}<span
					style='mso-spacerun: yes'></span>년<span
					style='mso-spacerun: yes'>&nbsp;&nbsp; </span>${fn:substring(salaryInfo.sal_date,5,7)}월<span
					style='mso-spacerun: yes'>&nbsp;&nbsp; </span>${fn:substring(salaryInfo.sal_date,8,10)}일
				</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
				<td colspan=20 rowspan=2 height=68 class=xl918672
					style='border-right: 1.0pt solid black; border-bottom: 1.0pt solid black; height: 52.2pt'>㈜올리브
					대표이사 홍길동</td>
			</tr>
			<tr class=xl638672 height=34
				style='mso-height-source: userset; height: 26.1pt'>
			</tr>
			<![if supportMisalignedColumns]>
			<tr height=0 style='display: none'>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
				<td width=33 style='width: 25pt'></td>
			</tr>
			<![endif]>
		</table>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		$('#printBtn').click(function(){
			printpage();
		})
		
		function printpage(){
			let initBody;
			window.onbeforeprint = function(){
				initBody = document.body.innerHTML;
				document.body.innerHTML = document.getElementById("print").innerHTML;
			};
			window.onafterprint = function(){
				document.body.innerHTML = initBody;
			};
			window.print();
		}
		window.onfocus=function(){ window.close();}


		$('#collapseInfo').addClass('show');
		$('#collapseInfo').prev().removeClass('collapsed');
		$('#collapseInfo').prev().children().css("color","#fff");
		
	</script>
</body>

</html>
