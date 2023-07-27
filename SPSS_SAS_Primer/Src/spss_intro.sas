/******************
Input: hw1.csv
Output: Just some testing on using SAS to convert sav data into data used for excel
Written by:Tingwei Adeck
Date: August 25 2022
Description: Modify data in SAS
Requirements: Need library called project, hw1.csv file.
Dataset description: Data obtained from Dr. Gaddis (small dataset)
Input: hw1.csv
Output: HW_BMI (with calculated BMI in SAS)
******************/

%let path=/home/u40967678/sasuser.v94;


libname project
    "&path/sas_umkc/input";
    
filename hw1
    "&path/sas_umkc/input/hw1.csv";   

ods pdf file=
    "&path/sas_umkc/output/BMI_calculated.pdf";
    
options papersize=(8in 4in) nonumber nodate;

proc import file= hw1
	out=project.hw1
	dbms=csv
	replace;
run;

proc FORMAT;
	value Smoking
		1= 'yes'
		2='no'
		;
	run;
	
proc FORMAT;
	value sex
		1= 'Male'
		2='Female'
		;
	run;

data project.hw1_clean; set project.hw1; /*remove the first dirty row using conditionals*/
if Height EQ "M" then delete;
run;

data project.hw1_long; set project.hw1_clean;
	format sex sex.;
	format smoking smoking.;
	run;

data project.hw1_wrang; set project.hw1_long;
	 numeric_smoking = input(smoking, comma9.);
	 drop smoking;
	run;
	
data project.hw1_final; 
	set project.hw1_wrang(rename=(numeric_smoking=smoking_binary));
	run;
	
data project.hw1_bmi;
set project.hw1_final;
BMI_calculated=Weight/(Height**2);
drop BMI;
run;

proc print data=project.hw1_bmi;
   title 'Smoking status with calculated BMI';
run;

ods pdf close;

	