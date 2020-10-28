%Modelo generico

%Lectura de datos
int :n;
int :s;
float :CN;
float :CH;
float :CT;
array [1..s, 1..n] of float : ds;
float :PN;
float :PH;
float :PT;

%Variables:
array [1..n] of var float: x;
array [1..n] of var float: y;
array [1..n] of var float: z;

%Restricciones:
constraint forall(i in 1..n) (x[i] <= PN);
constraint forall(i in 1..n) (y[i] <= PH);
constraint forall(i in 1..n) (z[i] <= PT);
constraint forall(i in 1..n-1) (y[i]+y[i+1] <= 2*PH*0.8);
constraint forall(i in 1..n)(x[i]+y[i]+z[i]>=sum(j in 1..s)(ds[j,i]));
constraint forall(i in 1..n)(x[i]>=0);
constraint forall(i in 1..n)(y[i]>=0);
constraint forall(i in 1..n)(z[i]>=0);

%Objetivo
var float: costoT;
constraint costoT =  sum (i in 1..n)(x[i]*CN + y[i]*CH + z[i]*CT);
solve minimize costoT;

