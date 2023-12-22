/** Import an XLSX file.  **/

PROC IMPORT DATAFILE="/home/u40967678/sasuser.v94/input/hw1.xlsx"
		    OUT=hw1
		    DBMS=XLSX
		    RANGE="Sheet1$";
		    SCANTEXT=YES;
		    REPLACE;
		    getnames=yes;
		    if Height = "M" then delete;
RUN;
 
/** Print the results. **/
PROC PRINT DATA=hw1; RUN;

