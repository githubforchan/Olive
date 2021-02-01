package com.olive.dto;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SalaryInfo{
   
   private String ename;
   private String deptname;
   private String headname;
   private String positionname;
   private String classname;
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private String hiredate;
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private String sal_date;
   private String empno;
   
   private String basic_pay;
   private String overtime_pay;
   private String position_pay;
   private String bonus;
   private String maintenance_of_vehicle;
   private String educational_supports;
   private String mess_allowance;
   
   private String income_tax;            //소득세 평균 소득 세율(21%) 가정 
   private String local_income_tax;      //지방소득세 10%
   private String employment_insurance;   //고용보험   0.8%
   private String health_insurance;      //건강보험 3.43%
   private String care_insurance;         //요양보험 11.52%
   private String national_pension;      //국민연금 4.5%
   
   private String totalIncome;
   private String exemption;
   private String afterTaxIncome;
   
   public void conversionFormality () {
      calcTotal();
      this.basic_pay = numberFormality(this.basic_pay);
      this.overtime_pay = numberFormality(this.overtime_pay);
      this.position_pay = numberFormality(this.position_pay);
      this.bonus = numberFormality(this.bonus);
      this.maintenance_of_vehicle = numberFormality(this.maintenance_of_vehicle);
      this.educational_supports = numberFormality(this.educational_supports);
      this.mess_allowance = numberFormality(this.mess_allowance);
      
      this.income_tax = numberFormality(this.income_tax);
      this.local_income_tax = numberFormality(this.local_income_tax);
      this.employment_insurance = numberFormality(this.employment_insurance);
      this.health_insurance = numberFormality(this.health_insurance);
      this.care_insurance = numberFormality(this.care_insurance);
      this.national_pension = numberFormality(this.national_pension);

      this.totalIncome = numberFormality(this.totalIncome);
      this.exemption = numberFormality(this.exemption);
      this.afterTaxIncome = numberFormality(this.afterTaxIncome);
      
      this.hiredate = dateFormality(this.hiredate);
      this.sal_date = dateFormality(this.sal_date);   
   }
   
   private String numberFormality(String data) {
      return new DecimalFormat("###,###,###,###").format(Integer.parseInt(data));
   }
   
   private String dateFormality(String data){
      Date temp = null;
      try {
         temp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(data);
      } catch (ParseException e) {
         e.printStackTrace();
         e.getMessage();
      } finally {         
         return new SimpleDateFormat("yyyy/MM/dd").format(temp);
      }
   }
   private void calcTotal() {
      int temp1= (Integer.parseInt(basic_pay)
            +Integer.parseInt(overtime_pay)
            +Integer.parseInt(position_pay)
            +Integer.parseInt(bonus)
            +Integer.parseInt(maintenance_of_vehicle)
            +Integer.parseInt(educational_supports)
            +Integer.parseInt(mess_allowance));
      
      int temp2 = Integer.parseInt(income_tax)
               +Integer.parseInt(local_income_tax)
               +Integer.parseInt(employment_insurance)
               +Integer.parseInt(health_insurance)
               +Integer.parseInt(care_insurance)
               +Integer.parseInt(national_pension);
      
      int temp3 = temp1 - temp2;
      this.totalIncome = temp1+"";
      this.exemption = temp2+"";
      this.afterTaxIncome = temp3+"";   
   }
}
