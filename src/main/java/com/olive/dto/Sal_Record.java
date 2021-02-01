package com.olive.dto;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Sal_Record {
	
	private String sal_date;
	private int empno;
	
	private int basic_pay;
	private int overtime_pay;
	private int position_pay;
	private int bonus;
	private int maintenance_of_vehicle;
	private int educational_supports;
	private int mess_allowance;
	
	private int income_tax;				//소득세 평균 소득 세율(21%) 가정 
	private int local_income_tax;		//지방소득세 10%
	private int employment_insurance;	//고용보험	0.8%
	private int health_insurance;		//건강보험 3.43%
	private int care_insurance;			//요양보험 11.52%
	private int national_pension;		//국민연금 4.5%
	
	public void calcTax() {
		double totalIncome = basic_pay+overtime_pay+position_pay+bonus+maintenance_of_vehicle+educational_supports+mess_allowance;
		income_tax = (int)Math.round( totalIncome * (0.21));
		local_income_tax = (int)Math.round(income_tax * (0.1));
		employment_insurance = (int)Math.round(totalIncome * (0.008));
		health_insurance = (int)Math.round(totalIncome * (0.0343));
		care_insurance = (int)Math.round(health_insurance * (0.1152));
		national_pension = (int)Math.round(totalIncome * (0.045));
	}
}
