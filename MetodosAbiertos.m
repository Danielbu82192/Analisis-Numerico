## METODO ABIERTOS
function MetodosAbiertos()
  fprintf ("***Metodos Abiertos***\n");
    Men=0;
    while(Men!=5)
      try
        Men=menu("Menu de Metodos Abiertos","Metodo de Newton Raphson",
        "Punto fijo", "Metodo de la secante","Atras","Salir");
        switch(Men)
          case 1
            N_R();
          case 2
            PF()
          case 3
            Secante()
          case 4
            Principal();
            Men=5
          case 5
            printf ("Sistema finalizado\n");
        endswitch
      catch
        waitfor(msgbox("Error en el menu de Metodos Abiertos","Error"));
      end_try_catch
   endwhile

endfunction

#Codigo Newton Rahpson
function N_R()
  clc;
  printf ("Metodo Newton Raphson\n");
  x=[];
  y=[];
  try
    E=100;
    xi = ValidarUndato("xi");
    func = PedirFormula();
    fdev = PedirDerivada();

    i = 0;
    while (E > (1*10^(-3)))

      fcn = feval(func,xi);
      derv = feval(fdev,xi);

      if(i ~= 0)
        E = (abs((xi_s - ant)/xi_s))*100;
      endif
      xi_s = xi - (fcn/derv);
      ant = xi;
      xvec(i+1) = xi;
      fvec(i+1) = fcn;
      dvec(i+1) = derv;
      Evec(i+1) = E;
      x=[x,i];
      y=[y,fcn];
      xi = xi_s;
      i++;
    endwhile

  atras=true;
  while (atras)
    mostrar = menuOpcion();
    grafica = mostrar(1);
    tabla = mostrar (2);
    vraiz = mostrar (3);
    atras = mostrar (4);
    if(grafica == true)
      plot(x,y);
    endif
     if(vraiz == true)
      raiz=xvec(length(xvec));
      errorV=Evec(length(Evec));
      fprintf("La raiz aproximada es:%d y el porcentaje de error es:%d \n", raiz, errorV);
    endif
    if(tabla == true)
      Mostrar(xvec,fvec,dvec,Evec);
    endif
  endwhile
  catch
    waitfor(msgbox("Error en Newton Rahpson","Error"));
  end_try_catch

endfunction
#Pedir Formula
function funct=PedirFormula()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion sin derivar");
      eval(['funct = @(x) (' funcInput{1,1} ');']);
      ban=0;
     catch err
      ban=1;
      if(err.identifier=="Octave:undefined-function")
       waitfor(msgbox ("La funcion solo recibe una variable","Error"));
     else
        waitfor(msgbox("Error al ingresar la funcion","Error"));
      endif
     end_try_catch
   endwhile
 endfunction

 #Pedir Formula derivada
 function funct=PedirDerivada()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese la funcion derivada");
      eval(['funct = @(x) (' funcInput{1,1} ');']);
      ban=0;
     catch err
      ban=1;
      if(err.identifier=="Octave:undefined-function")
       waitfor(msgbox ("La funcion solo resive una variable","Error"));
     else
        waitfor(msgbox("Error al ingresar la funcion","Error"));
      endif
     end_try_catch
   endwhile
 endfunction

  #Validacion de datos
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
        waitfor(msgbox(err.identifier, err.message));
        waitfor(msgbox ("Error al ingresar el dato","Error"));
     end_try_catch
   endwhile
 endfunction

#Funcion para mostrar Metodo Newton Raphson
function Mostrar(xvec,fvec,dvec,Evec)
    try
           answer=[1,xvec(1),fvec(1),dvec(1),100000];
           for i=2:length(xvec)
            newLine = [i,xvec(i),fvec(i),dvec(i),Evec(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer);
           newLine=[" i |"," X |"," F(xi) |","F_d(xi)"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"));
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
endfunction

#Metodo Punto Fijo
function PF()
  clc;
  printf ("Metodo Punto Fijo\n");
  x=[];
  y=[];
  try
    E = 100;
    xi =ValidarUndato("xi");
    gx = PedirEcn();
    i = 0;
    while (E > (1*10^(-3)) && i<100)

      fcn = feval(gx,xi);

      if(i ~= 0)
        E = (abs((xi - ant)/xi))*100;
      endif
      ant = xi;

      vecx(i+1) = fcn;
      vecE(i+1) = E;

      xi = fcn;
      i++;
      x=[x,ant];
      y=[y,fcn];
    endwhile
    atras=true;
    while (atras)
      mostrar = menuOpcion();
      grafica = mostrar(1);
      tabla = mostrar (2);
      vraiz = mostrar (3);

      if(grafica == true)
        plot(x,y);
      endif
       if(vraiz == true)
        raiz=vecx(length(vecx));
        errorV=vecE(length(vecE));
        fprintf("La raiz aproximada es:%d y el porcentaje de error es:%d \n", raiz, errorV);
      endif
      if(tabla == true)
        MostrarPF(vecx,vecE);
      endif
    endwhile


  catch
    waitfor(msgbox("Error en Punto Fijo","Error"));
  end_try_catch
endfunction
#Pedir ecuacion
function funct=PedirEcn()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion despejada de la forma g(x)");
      eval(['funct = @(x) (' funcInput{1,1} ');']);
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
#Funcion para Mostrar el Metodo Punto Fijo
function MostrarPF(vecx,vecE)
    try
           answer=[1,vecx(1),100000];

           for i=2:length(vecx)
            newLine = [i,vecx(i),vecE(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer);
           newLine=[" i |"," G(xi) |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"));
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
endfunction

#Metodo de la Secante
function Secante()
  clc;
  printf ("Metodos de la Secante\n");
  funcion1 = input("\nPor favor ingrese la función:","s");
  funcion1 = inline(funcion1);
  xi = input("\nPor favor ingrese el valor de xi:");
  xi_1 = input("\nPor favor ingrese el valor de xi+1:");
  # opciones a mostrar
  mostrar = menuOpcion();
  if(isnumeric(xi) && isnumeric(xi_1))
     calcularSecante(funcion1,xi,xi_1,mostrar)
  else
    print("Los parámetros ingresados son inválidos");
    opcion = menu("Desea Continuar?", "1. Sí, deseo intentar nuevamente", "2. No, deseo salir al menú principal");
    if(opcion==1)
      secante();
    endif
  endif
 endfunction

function calcularSecante(funcion, xi, xi_1,mostrar)
  grafica = mostrar(1);
  tabla = mostrar (2);
  vraiz = mostrar (3);
  error = 100;
  i = 0;
  resultado = [];
  x=[];
  y=[];

  while((error > (1 * 10^(-3))) &&  (i < 50))

    f_xi = feval(funcion, xi);
    f_xi_1 = feval(funcion, xi_1);
    x1_2 = xi_1 - ( ((xi - xi_1) * f_xi_1) / (f_xi - f_xi_1)); #cálculo de X_n+1

    if(i ~= 0)
      error = abs((x1_2 - xi_1) / x1_2 * 100); #Cálculo del error
    endif
    #Ingresa nueva fila a matriz respuesta
    newLine = [i, xi, f_xi, error];
    before = resultado;
    resultado = [before; newLine];
    # valores para graficar
    x=[x,xi];
    y=[y,xi_1];

    xi = xi_1;
    xi_1 = x1_2;
    i++;
  endwhile

  if(grafica == true)
    plot(x,y)
  endif
  if(tabla == true)
    fprintf("%s%s%s%s\n","[iteracion]", "[Xi]", "[f_Xi]","[Error]");
    resultado
  endif
  if(vraiz == true)
    fprintf("La raiz aproximada es:%d y el porcentaje de error es:%d \n", xi, error);
  endif
 endfunction

#Pedir ecuacion
function funct=PedirEcuacion()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese la Funcion")
      eval(['funct = @(x) (' funcInput{1,1} ');']);
      x=[1 1 1 1 1 1];
      funct(x);
      funcInput=inputdlg ("Ingrese la Funcion");
      eval(['funct = @(x) (' funcInput{1,1} ');']);
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
#Validacion primer parametro
 function dato=ValidarPrimerdato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato de %s',msg));
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
        waitfor(msgbox(err.identifier, err.message));
        waitfor(msgbox ("Error al ingresar el dato","Error"));
     end_try_catch
   endwhile
 endfunction
#Validacion segundo parametro
 function dato=ValidarSegundodato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato de %s',msg));
       if(isnan(dato{1,1})||isempty(dato{1,1}))
        waitfor(msgbox ("Debe ingresar un dato","Alerta"))
        ban=1;
       else  if(isnan(str2double(dato{1,1})))
        waitfor(msgbox ("El dato debe ser numerico","Alerta"))
      else
        dato=str2double(dato{1,1});
        ban=0;
      endif
      endif
     catch err
        waitfor(msgbox(err.identifier, err.message));
        waitfor(msgbox ("Error al ingresar el dato","Error"));
     end_try_catch
   endwhile
 endfunction


