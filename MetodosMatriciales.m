function MetodosMatriciales()
    Men3=0;
    while(Men3!=5)
    try
      Men3=menu("Menu Metodos Matriciales","Metodo de cramer",
      "Metodo Sarrus", "Metodo laplace","Metodo de Gauss-Seidel","Atras")

    switch(Men3)
      case 1
        Cramer()
    endswitch

     catch
      msgbox("Error en el menu de metodos Matriciales","Error")
     end_try_catch
    endwhile
 endfunction


 function Cramer()
   #matrizA = PedirMatriz();
   #matrizB = PedirMatrizB();
   crearmatriz()

endfunction

function matriz=crearmatriz()

  n = ValidarUndatoFila("(n)")
  m = ValidarUndatoCol("(m)")

  for i=1:n
    for j=1:m
      disp(['Ingrese el Elemento (',num2str(i),',',num2str(j),')'])
      A(i,j) = input('');
    endfor
  endfor

  A

endfunction


 function Matriz=PedirMatriz()
   dato=ValidarUndato();
   dato=dato{1,1}
   fila=str2double(dato(1))
   colum=str2double(dato(1))
   Matriz=[];
   Aux=[];
   ban=0;
   i=2;
   while(ban==0)
        dato2 = inputdlg(sprintf('Ingrese la fila 1:'),'Sample', [1 10])
        m=strsplit(dato2{1,1})
        k=length(m)
        if(length(m)!=colum)
          waitfor(msgbox (sprintf("El tama�o de la columna de ser igual a %d",colum),"Alerta"))
          ban=0;
         else
          for k=1:length(m)
            Aux=[Aux,m(k)];
          endfor
          Matriz=[Matriz;Aux];
          ban=1;
        endif
   endwhile
   while(i<fila+1)
  ban=0;
    while(ban==0)
        Aux=[];
        dato2 = inputdlg(sprintf('Ingrese la fila %d:',i),'Sample', [1 10])
        m=strsplit(dato2{1,1})
        k=length(m)
        if(length(m)!=colum)
          waitfor(msgbox (sprintf("El tama�o de la columna de ser igual a %d",colum),"Alerta"))
          ban=0;
         else
          for k=1:length(m)
            Aux=[Aux,m(k)];
          endfor
          Matriz=[Matriz;Aux];
          ban=1;
        endif
    endwhile
        i=i+1;
    endwhile
   Matriz

 endfunction

function dato=ValidarUndatoFila(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el numero de Filas de la Matriz %s',msg))
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"))
        ban=1;
       else  if(isnan(str2double(dato{1,1})))
        waitfor(msgbox ("El dato debe ser numerico","Alerta"))
      else
        dato=str2double(dato{1,1})
        ban=0;
      endif
      endif
     catch err
        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
endfunction

function dato=ValidarUndatoCol(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el numero de Filas de la Matriz %s',msg))
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"))
        ban=1;
       else  if(isnan(str2double(dato{1,1})))
        waitfor(msgbox ("El dato debe ser numerico","Alerta"))
      else
        dato=str2double(dato{1,1})
        ban=0;
      endif
      endif
     catch err
        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
endfunction

#####################################################


