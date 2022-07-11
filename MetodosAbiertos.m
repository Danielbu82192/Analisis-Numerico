function MetodosAbiertos()
    Men=0;
    while(Men!=4)
      try
        Men=menu("Menu Metodos Abiertos","Metodo de Newton Raphson",
        "Punto fijo", "Metodo de la secante","Atras")

      catch
        waitfor(msgbox("Error en el menu de metodos Abiertos","Error"))
      end_try_catch
   endwhile

 endfunction
