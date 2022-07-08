function MetodosCerrados()     
   try
    Men=0;
    while(Men!=3)
      Men=menu("Menu Metodos Cerrados","Metodo de Bisección",
      "Metodo de falsa posición", "Atras")
       switch(Men)
          case 1
            Biseccion()
        endswitch
    endwhile
   catch
    msgbox("Error en el menu de metodos cerrados","Error")
   end_try_catch
   
 endfunction
 
 
 function Biseccion()
   PedirFormula()
 endfunction

 
 
 function funct=PedirFormula()
   try
    funcInput=inputdlg ("Ingrese funcion")
    eval(['func = @(x) (' funcInput{1,1} ');']);   
    x=[1 1 1 1 1 1];
    func();
   catch err
    if(err.identifier=="Octave:undefined-function")    
     err_msg ("La funcion solo resive una variable","Error")
   else
     
      msgbox("Error al ingresar la funcion","Error")
    endif
   end_try_catch
 endfunction
