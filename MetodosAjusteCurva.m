function MetodosAjusteCurva()
   fprintf ("***Metodos Ajuste de Curva***\n");
    Men=0;
    while(Men!=5)
      try
        Men=menu("Menu Ajuste de Curva","Pol. Inter. Newton",
        "Pol. Inter. Lagrange", "Regresion Pol. minimo cuadrado","Atras", "Salir");
        switch(Men)
          case 1
            Newton();
          case 2
            lagrange();
          case 3
            MinimosCuadrados();
          case 4
            Principal();
          case 5
            printf ("Sistema finalizado\n");
        endswitch
      catch err
        waitfor(msgbox(err.identifier, err.message))
        msgbox("Error en el menu de metodos de ajuste de curva","Error")
      end_try_catch
    endwhile
 endfunction

 #Codigo Polinomio de interpolacion de newton
 function Newton()
   try
   clc;
   fprintf ("***Polinomio de interpolacion de newton***\n");
   x=PedirVectores("x - Independiente");
   y=PedirVectores("y - Dependiente");
  # x=partirCadena("0 600 1200 1800 2400")
  # y=partirCadena("350 247 185 140 105")
   x_i =[];
   y_i =[];
   matriz={};
   matrizF={};
   aux=y;
   for i=1:length(y)-1
         maux={};
     for j=1:length(y)-i
       aux;
       if(i==1)
         a=str2double(aux{j});
         b=str2double(aux{j+1});
         c=str2double(x{j});
         d=str2double(x{j+i});
       else
         a=aux{j};
         b=aux{j+1};
         c=str2double(x{j+i-1});
         d=str2double(x{j+i});
       endif
       e=(b-a);
       f=(d-c);
       dat=e/f;
       maux=[maux,dat];
     endfor
     matriz{i}=maux;
     matrizF{i}=maux{1};
     aux=maux;
   endfor

   for j=1:length(y)
     q=str2double(x{j});
     x_i =[x_i, q];
   endfor
   for j=1:length(y)
     k=str2double(y{j});
     y_i =[y_i, k];
   endfor
   cadena=y{1};

  for i=1:length(matrizF)
    cadena=[cadena "+ " mat2str(matrizF{i}) ];
    for j=1:i
      cadena=[cadena  "*(x-" x{j} ")" ];
    endfor
  endfor
    atras=true;
   while(atras)
    mostrar = menuAjuste();
    atras = mostrar(5);
    grafica = mostrar(1);
    tabla = mostrar (2);
    evaluar = mostrar (4)
    resultadoCadena = mostrar (3);
    if(grafica == true)
     plot(x_i,y_i);
    endif
    if(resultadoCadena == true)
      fprintf ("***Taller Menu principal***\n");
      cadena
      waitfor(msgbox ("La respuesta se encuentra en consola"));
    endif
    if(tabla == true)
      M2(matriz,x_i,y_i);
    endif
    if(evaluar == true)
      n=ValidarPunto("n");
      f=eval(['funct = @(x) (' cadena ');']);
      resul=feval(f,n);
      waitpid(msgbox(sprintf("El polinomio en el punto: %d es: %d \n", n, resul)))
    endif
  endwhile
  catch err
        waitfor(msgbox(err.identifier, err.message))
        msgbox("Error en newton","Error")
        end_try_catch
 endfunction

 function dato=ValidarPunto(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese punto a evaluar %s',msg));
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"));
        ban=1;
       else  if(isnan(str2double(dato{1,1})))
        waitfor(msgbox ("El dato debe ser numerico","Alerta"));
      else
        dato=str2double(dato{1,1});
        ban=0;
      endif
      endif
     catch err

        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
 endfunction
  ## VALIDACION DATOS
 function dato=ValidarUndato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato inicial %s',msg));
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"));
        ban=1;
       else  if(isnan(str2double(dato{1,1})))
        waitfor(msgbox ("El dato debe ser numerico","Alerta"));
      else
        dato=str2double(dato{1,1});
        ban=0;
      endif
      endif
     catch err

        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
 endfunction

 function M2(x,x_i,y_i)

           xi= transpose(x_i);
           yi= transpose(y_i);
           resultado=[xi,yi];
           newLine=[];

           for i=1:length(x)

             newLine=[];
             val=transpose(x{i});

             for j=1:length(x)+1
             if(j<=length(val))
              newLine = [newLine; val{j}];
            else
              newLine = [newLine;0];
             endif
             endfor
             before = resultado;
             resultado = [before, newLine];
           endfor
           resultado=num2str(resultado);
           waitfor(msgbox(num2str(resultado),"Tabla"));
endfunction

 #Codigo Polinomio de interpolaci??n de lagrange
function lagrange()
  try
  clc;
  fprintf ("***Polinomio de interpolacion de lagrange***\n");
  x=PedirVectores("x");
  y=PedirVectores("y");
  # x=partirCadena("0 0.2 0.4 0.6");
 #  y=partirCadena("15 21 30 51");
   x_i =[];
   y_i =[];
   fun=[];
   allFun={};
   allcalcu={};
   allcalcuxY={};
   cactu=0;
   for i=1:length(x)
     val=str2double(x{i});
   fun=[];
      cactu=1;
      ban=1;
     for j=1:length(x)
       datoV=str2double(x{j});
       if(val!=datoV)
       if(ban==1)
        fun=[fun,sprintf("(x-%d)",datoV)];
        ban=0;
       else
        fun=[fun sprintf("*(x-%d)",datoV)];
       endif
       a=(val-datoV);
       cactu=cactu*(a);
       endif
     endfor
     allFun{i}=fun;
     allcalcu{i}=cactu;
       datoy=str2double(y{i});
     allcalcuxY{i}=datoy/cactu;
   endfor

   cadena=[];
   cadena=[cadena sprintf("[%d*[%s]]",allcalcuxY{1},allFun{1})];
   for i=2:length(allFun)
    cadena=[cadena sprintf("+[%d*[%s]]",allcalcuxY{i},allFun{i})];
   endfor
   for j=1:length(y)
     q=str2double(x{j});
     x_i =[x_i, q];
   endfor
   for j=1:length(y)
     k=str2double(y{j});
     y_i =[y_i, k];
   endfor

   atras=true;
   while(atras)
    mostrar = menuAjuste();
    atras = mostrar(5);
    grafica = mostrar(1);
    tabla = mostrar (2);
    evaluar = mostrar (4)
    resultadoCadena = mostrar (3);
    if(grafica == true)
     plot(x_i,y_i);
    endif
    if(resultadoCadena == true)
      fprintf("El polinomio es: \n");
      cadena
    endif
    if(tabla == true)
       mostrarLagrange(allFun,allcalcu);
    endif
    if(evaluar == true)
      n=ValidarPunto("n");
      f=eval(['funct = @(x) (' cadena ');']);
      resul=feval(f,n);
      fprintf("El polinomio en el punto: %d  es: %d \n", n,resul);
    endif
    if(atras==true)
      waitfor(msgbox ("La respuesta se encuentra en consola"))
    endif
  endwhile
  catch
        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox("Error en Lagrange","Error"))
        end_try_catch
endfunction

function mostrarLagrange(allFun,allcalcu)
  clc;
  polinomio=[];
  for i=1:length(allFun)
    Lx =[sprintf("1/%d*[%s]",allcalcu{i},allFun{i})]
    polinomio =[polinomio,Lx];
  endfor
  polinomio
endfunction

# Codigo Polinomio Minimos cuadrados
function MinimosCuadrados()
  try
  clc;
  fprintf ("***Regresion polinomial por minimo cuadrado***\n");
  #  x=PedirVectores("x");
 #   y=PedirVectores("y");
  #  n=ValidarUndato("n");
   x=partirCadena("0 2.3 4.9 9.1 13.7 18.3 22.9 27.2");
   y=partirCadena("22.8 22.8 22.8 20.6 13.9 11.7 11.1 11.1");
   matrizValores={};
   n=2;
   da=0;
   dy=0;
   xa=[];
   ya=[];
   gElevada=n*2;
   j=2;
   x=invertirTipoVector(x);

   y=invertirTipoVector(y);
   xa=[x,sum(x)];
   ya=[y,sum(y)];
   Tablax{1}=xa;
   for i=2:gElevada
     xas=x.^i;
     xaux=[xas, sum(xas)];
     Tablax{j}=xaux;
     matrizValores{i-1}=xaux;
     j=j+1;
   endfor

   Tablaxel={};
   for i=1:length(Tablax)
     vec=Tablax{i};
     vec=vec.*ya;
     vec(length(vec))=0;

     vec(length(vec))=sum(vec);
     Tablaxel{i}=vec;
   endfor
   c=invertirTipoVector(x);
   for i=1:n+1
    for j=1:n+1
      if(i==1&&j==1)
        Matriz(1,1)=length(x);
      else
        a=i+j-1;
        M=Tablax{i+j-2};
        Matriz(i,j)=M(length(M));
      endif
    endfor
   endfor
   vectorB=[];
   vectorB(1)=sum(y);
   for i=2:n+1
     M=Tablaxel{i-1};
     vectorB=[vectorB;M(length(M))];
   endfor

  k=1;
  i=length(matrizValores);
  while(k<=n)
      valorxy=Tablaxel{k};
     matrizValores{i+1}=valorxy;
     k=k+1;
     i=i+1;
  endwhile


  atras=true;
   while(atras)
    mostrar = menuAjuste();
    atras = mostrar(5);
    grafica = mostrar(1);
    tabla = mostrar (2);
    evaluar = mostrar (4)
    resultadoCadena = mostrar (3);
    if(grafica == true)
     plot(xa,ya);
    endif
    if(resultadoCadena == true)
      fprintf("El polinomio es: \n");
      sol=inv(Matriz)*vectorB;
      cadena=[num2str(sol(1))];
      for i=2:length(sol)
        cadena=[cadena sprintf("+[%d*x^%d]",sol(i),i-1)];
      endfor
        cadena
      waitfor(msgbox ("La respuesta se encuentra en consola"))
    endif
    if(tabla == true)
        mostrarMinimos(matrizValores,xa,ya)
    endif
    if(evaluar == true)
      n=ValidarPunto("n");
      sol=inv(Matriz)*vectorB;
      cadena=[num2str(sol(1))];
      for i=2:length(sol)
        cadena=[cadena sprintf("+[%d*x^%d]",sol(i),i-1)];
      endfor
        cadena;
        eval(['funct = @(x) (' cadena ');']);
        resul=feval(funct,n);
        waitpid(msgbox(sprintf("El polinomio en el punto: %d  es: %d \n", n, resul)))

    endif
  endwhile


  catch err
        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox("Error en minimos cuadrados","Error"))
  end_try_catch
endfunction

function mostrarMinimos(x,x_i,y_i)

           xi= transpose(x_i);
           yi= transpose(y_i);
           resultado=[xi,yi];
           newLine=[];
           for i=1:length(x)
             newLine=[];
             val=transpose(x{i});
             newLine = [newLine; val];
             before = resultado;
             resultado = [before, newLine];
           endfor
           resultado=num2str(resultado);
           waitfor(msgbox(num2str(resultado),"Tabla"));
endfunction

function Nvec=invertirTipoVector(vec)
  try
    Nvec=[];
    for i=1:length(vec)
      Nvec=[Nvec,str2double(vec{i})];
    endfor
  catch
  end_try_catch
  endfunction

  #Obtener valores vector
function dato=PedirVectores(msg)
   ban=1;
   while ban!=0
     val=0;
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Valores de la matriz %s separados por espacio:',msg));
       expresion='[\d+\s+\d]';
       val=regexp(dato{1,1}, expresion, 'match');
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"));
        ban=1;

      else if(length(val)==0)

        waitfor(msgbox ("Debe cumplir la expresion separados por espacio (Fila Columna)","Alerta"));

        ban=1;
        else 1
        ban=0;
        dato=partirCadena(dato{1,1});
        endif

      endif
     catch err
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
 endfunction
 #Partir cadena
function palabras = partirCadena(cadena)
  try
resto = cadena;
palabras = {};
i = 1;
while length(resto) ~=0
[primera,resto] = strtok(resto);
palabras{i} = primera;
i = i+1;
endwhile
  catch err
        waitfor(msgbox(err.identifier, err.message))
        msgbox("Error","Error")
        end_try_catch
endfunction

 #SubMenu Ajuste de curva
function visualizar = menuAjuste()
  #inicio de variables
  grafica = false;
  tabla = false;
  cadenaFinal = false;
  evaluar = false;
  atras=true;
  opcion = menu("Resultado a ver", "1. Gr??fica\n","2. Mostrar tabla\n", "3. Valor cadena Final \n", "4.Evaluar en un punto", "5. Todo\n", "6. Atras\n");

  if(opcion == 1)
    grafica = true;
  elseif(opcion == 2)
    tabla = true;
  elseif(opcion == 3)
    cadenaFinal = true;
  elseif(opcion == 4)
    evaluar = true;
  elseif(opcion == 5)
    grafica = true;
    tabla = true;
    cadenaFinal = true;
    evaluar =true;
  elseif(opcion == 6)
    atras=false;
  endif

  visualizar = [grafica, tabla, cadenaFinal,evaluar,atras];
endfunction


