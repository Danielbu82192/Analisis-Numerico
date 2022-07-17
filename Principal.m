function Principal()
  Men1=0;
  while(Men1!=7)
    try
      Men1=menu("Menu principal","Metodos Cerrados",
      "Metdoso Abiertos", "Metodos Matriciales","Ajuste de Curva",
      "Metodos Solucion EDO", "Integrales Numericas", "Salir")
      switch(Men1)
        case 1
           MetodosCerrados()
        case 2
           MenMetodosAbiertos()
        case 3
           MenMetodosMatriciales()
        case 4
           MetodosAjusteCurva()
        case 5
           MenMetodosEDO()
        case 6
           MenMetodosAbiertos()    
        case 7
           #opt=questdlg("¿Seguro desea salir?", "Salir", "Si", "No") 
           #if(opt=="No")
          #    Men1=0
          # endif
        otherwise
           msgbox("Debe seleccionar una opcion correcta")
      endswitch
    catch err
      msgbox(err.identifier, err.message);
      msgbox("Error en el menu principal","Error")
    end_try_catch
   endwhile

endfunction


 
 
 


 

 

 
 function MenMetodosEDO()     
   try
    Men5=0;
    while(Men5!=4)
      Men5=menu("Menu Metodos Solucion EDO","Metodo de euler",
      "Polinomio de interpolación de lagrange", "Runge-Kutta","Atras")
            
    endwhile
   catch
    msgbox("Error en el menu de metodos Abiertos","Error")
   end_try_catch
   
 endfunction