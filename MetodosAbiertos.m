function MetodosAbiertos()
    Men=0;
    while(Men!=4)
      try
        Men=menu("Menu Metodos Abiertos","Metodo de Newton Raphson",
        "Punto fijo", "Metodo de la secante","Atras")
        switch(Men)
          case 1
            N_R()
        endswitch

      catch
        waitfor(msgbox("Error en el menu de metodos Abiertos","Error"))
      end_try_catch
   endwhile

endfunction

function N_R()
  try
    E=100;
    #xi=0;
    #func(xi)=0;
    #fdev(xi)=0;
    xi = ValidarUndato();
    func = PedirFormula();
    fdev = PedirDerivada();

    i = 0;
    while (E > (1*10^(-3)))

      fcn = feval(func,xi);
      derv = feval(fdev,xi);
      xi_s = xi - (fnc/derv);

      if(i ~= 0)
        E = (abs((xi_s - xi)/xi_s))*100;
      else
        E = 100;
      endif
    endwhile

  catch
    waitfor(msgbox("Error en Newton Rahpson","Error"));
  end_try_catch

endfunction

function funct=PedirFormula()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion sin derivar")
      eval(['funct = @(x) (' funcInput{1,1} ');']);
      x=[1 1 1 1 1 1];
      funct(x);
      ban=0;
     catch err
      ban=1;
      if(err.identifier=="Octave:undefined-function")
       waitfor(msgbox ("La funcion solo recibe una variable","Error"))
     else
        waitfor(msgbox("Error al ingresar la funcion","Error"))
      endif
     end_try_catch
   endwhile
 endfunction

 function funct=PedirDerivada()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese la funcion derivada")
      eval(['funct = @(x) (' funcInput{1,1} ');']);
      x=[1 1 1 1 1 1];
      funct(x);
      ban=0;
     catch err
      ban=1;
      if(err.identifier=="Octave:undefined-function")
       waitfor(msgbox ("La funcion solo resive una variable","Error"))
     else
        waitfor(msgbox("Error al ingresar la funcion","Error"))
      endif
     end_try_catch
   endwhile
 endfunction

function dato=ValidarUndato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato inicial %s',msg))
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
