title1 'STAT 717 SAS HW2 Q4';

data set2;
  input cigar $ cancer control;
COUNT=cancer;disease='cancer';OUTPUT;
COUNT=control;disease='control';OUTPUT;
cards;
0 7 61
<5 55 129
5-14 489 570
15-24 475 431
25-49 293 154
>50 38 12
;
run;

proc freq data=set2 order=data;
tables cigar*disease/nocol nopercent nopercent or;;
weight count;
run;




/*second way*/ 

data set1;
  input CIGAR $  DISEASE $ COUNT;
cards;
0 cancer 7
<5 cancer 55
5-14 cancer 489
15-24 cancer 475
25-49 cancer 293
>50 cancer 38
0 control 61
<5 control 129
5-14 control 570
15-24 control 431
25-49 control 154
>50 control 12
;
run;

proc freq data=set1 order=data;
tables cigar*disease/oddsratio ;
/*measures or relrisk*/
weight count;
run;

proc freq data=set1;
tables cigar*disease/nocol nopercent alpha=0.1  ;/*measures or relrisk*/
weight count;
run;

proc freq data=set1 order=data;
tables cigar*disease/MEASURES NOCOL NOROW NOPERCENT;
weight count;

run;



