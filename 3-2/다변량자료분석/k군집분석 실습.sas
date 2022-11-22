proc import datafile="C:\Users\OWNER\Downloads\iris.csv"
       dbms=csv
       out=ex1;
run;

*계층적 군집분석;
proc cluster data=ex1 standard
method=complete outtree=tree_out CCC PSEUDO;
var Sepal_Length Sepal_Width Petal_Length Petal_Width;
run;

proc sort data=tree_out out=sort_tree;
by _NCL_;
run;

symbol i=join v=dot ci=blue cv=red;
proc gplot data=sort_tree;
plot(_rsq_ _ccc_ _psf_ _pst2_)*_ncl_;
where _ncl_<=15;
run;

*덴드로그램;
axis1 order=(0 to 1 by 0.1);
proc tree data=tree_out haxis=axis1 horizontal
out=output nclusters=5;
height _RSQ_;
id _NAME_;
copy Sepal_Length Sepal_Width Petal_Length Petal_Width;
run;

*k-means 군집;
proc fastclus data=ex1 out=out_ex1
maxclusters=3 maxiter=150;
var Sepal_Length Sepal_Width Petal_Length Petal_Width;
run;

