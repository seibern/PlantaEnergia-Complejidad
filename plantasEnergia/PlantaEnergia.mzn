%Modelo generico

%Lectura de datos

% n -> # de días totales
% s -> cantidad de clientes
% p -> porcentaje maximo
% ns -> cantidad de días seguidos
% CN -> costo por kw, planta nuclear
% CH -> costo por kw, planta hidraulica
% CT -> costo por kw, planta termica
% ds -> matriz formado por la cantidad de clientes y su demandas diarias
% PN -> capacidad de produccion maxima de la planta nuclear
% PH -> capacidad de produccion maxima de la planta hidraulica
% PT -> capacidad de produccion maxima de la planta termica

int :n;
int :s;
float :p;
int :ns;
float :CN;
float :CH;
float :CT;
array [1..s, 1..n] of float : ds;
float :PN;
float :PH;
float :PT;

%Variables:

% x -> variable para la producción de la planta nuclear
% y -> variable para la producción de la planta hidraulica
% z -> variable para la producción de la planta termica
array [1..n] of var float: x;
array [1..n] of var float: y;
array [1..n] of var float: z;

%Restricciones:
constraint forall(i in 1..n) (x[i] <= PN);
constraint forall(i in 1..n) (y[i] <= PH);
constraint forall(i in 1..n) (z[i] <= PT);
constraint forall(i in 1..n)(x[i]+y[i]+z[i]>=sum(j in 1..s)(ds[j,i]));
constraint forall(i in 1..n)(x[i]>=0);
constraint forall(i in 1..n)(y[i]>=0);
constraint forall(i in 1..n)(z[i]>=0);

constraint forall (i in 1..n-1, j in 1..ns) (
    if (ns-1)<1 then
      forall(i in 1..n-1)(y[i]<= ns*PH*p)
    else
          if (ns-1)>=1 then
            forall(i in 1..n-(ns-1))(sum(k in (i..(i+(ns-1))))(y[k])<= ns*PH*p)
           endif
        endif
);

%Objetivo
var float: costoT;
constraint costoT =  sum (i in 1..n)(x[i]*CN + y[i]*CH + z[i]*CT);
solve minimize costoT;

