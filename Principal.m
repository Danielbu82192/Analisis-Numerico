#MENU PRINCIPAL

function Principal()
  fprintf ("***Taller Menu principal***\n");
  Men1=0;
  while(Men1!=6)
    try
      Men1=menu("Menu principal","Metodos Cerrados",
      "Metodos Abiertos", "Metodos Matriciales","Ajuste de Curva",
      "Metodos Solucion EDO", "Salir");
      switch(Men1)
        case 1
           MetodosCerrados();
           Men1=6;
        case 2
           MetodosAbiertos();
           Men1=6;
        case 3
           MetodosMatriciales();
           Men1=6;
        case 4
           MetodosAjusteCurva();
           Men1=6;
        case 5
           MetodosEDO();
           Men1=6;
        case 6
           printf ("Sistema finalizado\n");
        otherwise
           msgbox("Debe seleccionar una opcion correcta")
      endswitch
    catch err
      msgbox(err.identifier, err.message);
      msgbox("Error en el menu principal","Error")
    end_try_catch
   endwhile

endfunction
