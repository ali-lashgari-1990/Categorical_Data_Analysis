title1 'STAT 717 SAS EXAMPLE';
data set1;
  input COUNTRY $ SEX $ COUNT;
cards;
USA       FEMALE     524
USA       MALE       476
BRAZIL    FEMALE     189
BRAZIL    MALE       211
;
run;
proc freq data=set1;
tables country*sex/nocol nopercent alpha=0.1 riskdiff ;/*measures or relrisk*/
weight count;
run;
/*By default, riskdiff option provides exact (Clopper-Pearson) confidence limits for 
the row 1, row 2, and total risks*/

proc freq data=set1;
tables country*sex/nocol nopercent chisq cmh;
weight count;
run;
title2 'Follow up Chi-square test';
proc freq data=set1;
tables country*sex/nocol nopercent norow CROSSLIST( PEARSONRES STDRES) deviation expected;
weight count;
run;
/*
STDRES:displays the standardized residuals of the table cells in the CROSSLIST table.
PEARSONRES:displays the Pearson residuals of the table cells in the CROSSLIST table.
*/

/**********
Below is a way to compute adjusted residuals.
It uses PROC GENMOD, which we will learn more about later.  
**********/
/*proc genmod;
  class country sex;
  model count = country sex /dist=poi link=log obstats residuals;
  ods output obstats=set2;
run;

proc print data=set2;
  var country sex count pred resraw reschi streschi;
run;
*/
data set2;
  input COUNTRY $ FEMALE MALE;
COUNT=FEMALE;GENDER='FEMALE';OUTPUT;
COUNT=MALE;GENDER='MALE';OUTPUT;
cards;
USA       524 476
BRAZIL    189 211
;
run;
proc freq data=set2;
tables country*GENDER/nocol nopercent chisq;;
weight count;
run;
