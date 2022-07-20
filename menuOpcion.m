function mostrar = menuOpcion()
  #inicio de variables
  grafica = false;
  tabla = false;
  vraiz = false;
  atras=true;
  opcion = menu("Resultado a ver", "1. Gráfica\n","2. Mostrar tabla\n", "3. Valor de la raíz con error \n", "4. Todo\n", "5.Atras");

  if(opcion == 1)
    grafica = true;
  elseif(opcion == 2)
    tabla = true;
  elseif(opcion == 3)
    vraiz = true;
  elseif(opcion == 4)
    grafica = true;
    tabla = true;
    vraiz = true;
  elseif(opcion == 5)
    atras = false;
  endif

  mostrar = [grafica, tabla, vraiz, atras];
 endfunction

