data training;
    infile "/home/u64333706/STAT6338/HW 6/CH25PR17.txt";
    input Efficiency FactorA FactorB Replication;
run;
quit;

/* (1) Interaction Plot */
proc sgplot data=training;
    title "Interaction Plot: Factor A and Factor B";
    series x=FactorA y=Efficiency / group=FactorB markers;
run;
quit;

/* (2) Interaction Model: PROC GLM */
proc glm data=training;
    class FactorA FactorB;
    model Efficiency = FactorA FactorB FactorA*FactorB / ss3;
    random FactorB FactorA*FactorB / test;
    title "PROC GLM: Testing Interaction Term";
run;
quit;

/* (2) PROC MIXED: REML */
proc mixed data=training method=reml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth;
    random FactorB FactorA*FactorB;
    title "PROC MIXED: REML Estimates for Variance Components";
run;
quit;

/* (2) PROC MIXED: ML */
proc mixed data=training method=ml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth;
    random FactorB FactorA*FactorB;
    title "PROC MIXED: ML Estimates for Variance Components";
run;
quit;

/* (3) PROC GLM: Main Effects Tests */
proc glm data=training;
    class FactorA FactorB;
    model Efficiency = FactorA FactorB FactorA*FactorB / ss3;
    random FactorB FactorA*FactorB / test;
    title "PROC GLM: Main Effects Tests (Unrestricted)";
run;
quit;

/* (3) PROC MIXED: Fixed Effect A and Variance Components REML */
proc mixed data=training method=reml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth;
    random FactorB FactorA*FactorB;
    title "PROC MIXED: Fixed Effect A and Variance Components (REML)";
run;
quit;

/* (4) Compare Factor A means */
proc mixed data=training method=reml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth;
    random FactorB FactorA*FactorB;
    lsmeans FactorA / pdiff=all adjust=tukey;
    title "Comparison of Factor A Means (REML)";
run;
quit;

/* (5) ML Estimates for fixed A and variance components (25.27a) */
proc mixed data=training method=ml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth solution;
    random FactorB FactorA*FactorB;
    title "PROC MIXED (ML): Fixed Effect A and Variance Components (25.27a)";
run;
quit;

/* (6a) LRT: Full model under ML */
proc mixed data=training method=ml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth solution;
    random FactorB FactorA*FactorB;
    title "PROC MIXED (ML): Full Model for LRT H0: sigma2_B = 0";
run;
quit;

/* (6a) LRT: Reduced model under ML -- FactorB dropped from random */
proc mixed data=training method=ml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth solution;
    random FactorA*FactorB;
    title "PROC MIXED (ML): Reduced Model for LRT H0: sigma2_B = 0";
run;
quit;
/* LRT chi2 = (-2 log L reduced) - (-2 log L full), df=1
   p-value from chi-square table; halve it because boundary test */

/* (6b) Confidence intervals for variance components */
proc mixed data=training method=ml cl;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth solution;
    random FactorB FactorA*FactorB;
    title "PROC MIXED (ML): CI for Variance Components (25.27b)";
run;
quit;

/* (6c) Factor A pairwise comparisons under ML */
proc mixed data=training method=ml;
    class FactorA FactorB;
    model Efficiency = FactorA / ddfm=satterth solution;
    random FactorB FactorA*FactorB;
    lsmeans FactorA / pdiff=all adjust=tukey;
    title "PROC MIXED (ML): Factor A Means Comparison (25.27b)";
run;
quit;
