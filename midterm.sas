title 'Midterm STAT 717 Q2';
data set1;
  input age $ status $ COUNT;
cards;

<31 normal 46
<31 dubious 11
<31 abnormal 8

32-33 normal 111
32-33 dubious 15
32-33 abnormal 5

34-36 normal 169
34-36 dubious 19
34-36 abnormal 4

>37 normal 103
>37 dubious 11
>37 abnormal 3
;
run;
proc freq data=set1 order=data;
tables age*status/nocol nopercent alpha=0.1 riskdiff ;/*measures or relrisk*/
weight count;
run;
/*By default, riskdiff option provides exact (Clopper-Pearson) confidence limits for 
the row 1, row 2, and total risks*/

proc freq data=set1 order=data;
tables age*status/nocol nopercent chisq cmh;
weight count;
run;


title 'Midterm STAT 717 Q3';
data set1;
  input age $ status $ COUNT score1 score2 score3;
  
cards;
<31 normal 46 1 0 0
<31 dubious 11 2 2 4
<31 abnormal 8 3 3 5

32-33 normal 111 1 0 0
32-33 dubious 15 2 2 4
32-33 abnormal 5 3 3 5

34-36 normal 169 1 0 0
34-36 dubious 19 2 2 4
34-36 abnormal 4 3 3 5

>37 normal 103 1 0 0
>37 dubious 11 2 2 4
>37 abnormal 3 3 3 5
;
run;

proc print;
run;

title 'Mid-Rank Scores';

proc freq data=set1 order=data;
  tables age*status / cmh scores=rank noprint scorout;
  weight COUNT;
run;

title 'Scores = 1,2,3';

proc freq data=set1 order=data;
  tables age*score1 / cmh noprint score=table scorout;
  weight COUNT;
run;

title 'Scores = 0,2,3';

proc freq data=set1 order=data;
  tables age*score2 / cmh noprint score=table scorout;
  weight COUNT;
run;

title 'Scores = 0,4,5';

proc freq data=set1 order=data;
  tables age*score3 / cmh noprint score=table scorout;
  weight COUNT;
run;

title 'Midterm STAT 717 Q4';
title 'Computing Mean Scores For Each Row';

proc sort data=set1;
  by age;
run;

proc means data=set1 mean noprint;
  by age;
  var SCORE1 SCORE2 SCORE3;
  freq COUNT;
  output out=means mean = ;
run;

proc print data=means;
run;



title 'Midterm STAT 717 Q5';
data set2;
  input age $ status $ COUNT score1;
  
cards;
<31 normal 46 1.41538 
<31 dubious 11 0.70769 
<31 abnormal 8 1.29231

32-33 normal 111 1.19084 
32-33 dubious 15 0.34351 
32-33 abnormal 5 0.64885 

34-36 normal 169 1.14063 
34-36 dubious 19 0.26042 
34-36 abnormal 4 0.5 

>37 normal 103 1.14530
>37 dubious 11 0.26496 
>37 abnormal 3 0.50427 
;
run;

proc print;
run;
title3 'Score1 PAIRWISE COMPARISONS: <31 vs. 32-33';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('<31','32-33'); 
run;


title3 'Score1 PAIRWISE COMPARISONS: <31 vs. 34-36';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('<31','34-36'); 
run;


title3 'Score1 PAIRWISE COMPARISONS: <31 vs. >37';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('<31','>37'); 
run;

title3 'Score1 PAIRWISE COMPARISONS: 32-33 vs. 34-36';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('32-33','34-36'); 
run;

title3 'Score1 PAIRWISE COMPARISONS: 32-33 vs. >37';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('32-33','>37'); 
run;

title3 'Score1 PAIRWISE COMPARISONS: 34-36 vs. >37';

proc freq data=set2;
  tables age*score1 / cmh noprint;
  weight COUNT;
  where age in ('34-36','>37'); 
run;

title 'Midterm STAT 717 Q7';
data set3;
  input age $ status $ COUNT score1 score2 score3;
  cards;
<31 normal 46 1 1 0
<31 dubious 11 1 2 3
<31 abnormal 8 1 3 5

32-33 normal 111 2 1 0
32-33 dubious 15 2 2 3
32-33 abnormal 5 2 3 5

34-36 normal 169 3 1 0
34-36 dubious 19 3 2 3
34-36 abnormal 4 3 3 5

>37 normal 103 4 1 0
>37 dubious 11 4 2 3
>37 abnormal 3 4 3 5
;
run;



title2 'Test ignoring the order';

proc freq order=data data=set3;
  tables age*status / chisq norow nocol nopercent measures;
  weight COUNT;
run;


title2 'Test with Two Ordered Variables: No scores specified';

proc freq order=data data=set3;
  tables age*status / cmh noprint scorout chisq;
  weight COUNT;
run;


title2 'Age and Response (1,2,3) Scores';

proc freq data=set3;
  tables score1*score2 / cmh noprint scorout;
  weight COUNT;
run;

title2 'Age and Response (0,3,5) Scores';

proc freq data=set3;
  tables score1*score3 / cmh noprint scorout measures ;
  weight COUNT;
run;


title2 'Computing Mean Scores For Each Row';

proc means data=set3 mean noprint nway order=data;
class age;
  var score2 score3;
  weight COUNT;
  output out=means mean = ;
run;
proc print data=means;
run;



