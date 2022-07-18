function MetodosAjusteCurva()    
    Men=0;
    while(Men!=4) 
      try
        Men=menu("Menu Ajuste de Curva","Polinomio de interpolación de newton",
        "Polinomio de interpolación de lagrange", "Regresion polinomial por minimo cuadrado","Atras")
        
        switch(Men)      
          case 1
            Newton
            
          case 2
            lagrange()
            
           otherwise
           msgbox("Debe seleccionar una opcion correcta")
    
        endswitch
      catch err
        waitfor(msgbox(err.identifier, err.message))
        msgbox("Error en el menu de metodos Abiertos","Error")
      end_try_catch   
    endwhile
 endfunction
 
 function Newton()
   x=PedirVectores("x");
   y=PedirVectores("y");
  ## x=partirCadena("0 600 1200 1800 2400")
  ## y=partirCadena("350 247 185 140 105")
   matriz={};   
   matrizF={};
   aux=y;
   for i=1:length(y)-1
         maux={};
     for j=1:length(y)-i  
       aux
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
     matriz{i}=maux
     matrizF{i}=maux{1};
     aux=maux;
   endfor
   
   cadena=y{1} 
   
  for i=1:length(matrizF)
    cadena=[cadena "+ " mat2str(matrizF{i}) ];
    for j=0:i-1
      cadena=[cadena  "(x-x" mat2str(j) ")" ];
    endfor
  endfor
  cadena
 endfunction
 
function lagrange()
  #x=PedirVectores("x");
  #y=PedirVectores("y");
   x=partirCadena("0 0.2 0.4 0.6")
   y=partirCadena("15 21 30 51")
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
        fun=[fun,sprintf("(x-%d)",datoV)]
        ban=0
       else
        fun=[fun sprintf("*(x-%d)",datoV)]
       endif
       a=(val-datoV)
       cactu=cactu*(a)
       endif     
     endfor
     allFun{i}=fun;
     allcalcu{i}=cactu;
       datoy=str2double(y{i});     
     allcalcuxY{i}=datoy/cactu;
   endfor
   cadena=[];
   cadena=[cadena sprintf("[%d*[%s]]",allcalcuxY{1},allFun{1})]
   for i=2:length(allFun)
    cadena=[cadena sprintf("+[%d*[%s]]",allcalcuxY{i},allFun{i})]
   endfor
      eval(['funct = @(x) (' cadena ');']);
      asd=feval(funct,0.4);
  
 endfunction
 
  function dato=PedirVectores(msg)
   ban=1;
   while ban!=0
     val=0;
     try 
       dato{1,1}="";
       dato=inputdlg(sprintf('El vector %s separados por espacio:',msg))
       expresion='[\d+\s+\d]';
       val=regexp(dato{1,1}, expresion, 'match');
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"))
        ban=1;
        
      else if(length(val)==0)
        
        waitfor(msgbox ("Debe cumplir la expresion separados por espacio (Fila Columna)","Alerta"))
        
        ban=1;
        else 1
        ban=0;
        dato=partirCadena(dato{1,1})
        endif
        
      endif
     catch err
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
 endfunction

function palabras = partirCadena(cadena)
resto = cadena;
palabras = {};
i = 1;
while length(resto) ~=0
[primera,resto] = strtok(resto);
palabras{i} = primera;
i = i+1;
endwhile
endfunction