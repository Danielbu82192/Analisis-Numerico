function MetodosAbiertos()
    Men=0;
    while(Men!=4)
      try
        Men=menu("Menu de Metodos Abiertos","Metodo de Newton Raphson",
        "Punto fijo", "Metodo de la secante","Atras")
        switch(Men)
          case 1
            N_R()
          case 2
            PF()
          case 3
            Secante()
        endswitch
      catch
        waitfor(msgbox("Error en el menu de Metodos Abiertos","Error"))
      end_try_catch
   endwhile

endfunction

#Codigo Newton Rahpson
function N_R()
  try
    E=100;
    #xi=0;
    #func(xi)=0;
    #fdev(xi)=0;
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

      xi = xi_s;
      i++;
    endwhile
    Mostrar(xvec,fvec,dvec,Evec);
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

#Funcion para mostrar Metodo Newton Raphson
function Mostrar(xvec,fvec,dvec,Evec)
Men1=0;
  while(Men1!=4)
    try
      Men1=menu("Menu Mostrar",
      "Tabla", "Valor de la raíz con error menor 0.001","Todo",  "Atras")
      switch(Men1)
        case 1
           answer=[1,xvec(1),fvec(1),dvec(1),100000];

           for i=2:length(xvec)
            newLine = [i,xvec(i),fvec(i),dvec(i),Evec(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer)
           newLine=[" i |"," X |"," F(xi) |","F_d(xi)"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))
        case 2
           raiz=xvec(length(xvec));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
        case 3
           answer=[1,xvec(1),fvec(1),dvec(1),100000];
           for i=2:length(xvec)
           newLine = [i,xvec(i),fvec(i),dvec(i),Evec(i)];
           before = answer;
           answer = [before; newLine];
         endfor
          answer=num2str(answer);
           newLine=[" i |"," X |"," F(xi) |"," F_d(xi) |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))
           raiz=xvec(length(xvec));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
          case 4
        otherwise
           waitfor(msgbox("Debe seleccionar una opcion correcta"))
      endswitch
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
  endwhile
endfunction

#Metodo Punto Fijo
function PF()
  try
    E = 100;
    xi =ValidarUndato("xi");
    gx = PedirEcn();
    i = 0;
    while (E > (1*10^(-3)))

      fcn = feval(gx,xi);

      if(i ~= 0)
        E = (abs((xi - ant)/xi))*100;
      endif
      ant = xi;

      vecx(i+1) = fcn;
      vecE(i+1) = E;

      xi = fcn;
      i++;
    endwhile
    MostrarPF(vecx,vecE);
  catch
    waitfor(msgbox("Error en Punto Fijo","Error"));
  end_try_catch
endfunction

function funct=PedirEcn()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion despejada de la forma g(x)")
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
#Funcion para Mostrar el Metodo Punto Fijo
function MostrarPF(vecx,vecE)
Men1=0;
  while(Men1!=4)
    try
      Men1=menu("Menu Mostrar",
      "Tabla", "Valor de la raíz con error menor 0.001","Todo",  "Atras")
      switch(Men1)
        case 1
           answer=[1,vecx(1),100000];

           for i=2:length(vecx)
            newLine = [i,vecx(i),vecE(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer)
           newLine=[" i |"," G(xi) |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))
        case 2
           raiz=vecx(length(vecx));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
        case 3
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
           waitfor(msgbox(num2str(answer),"Tabla"))
           raiz=vecx(length(vecx));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
          case 4
        otherwise
           waitfor(msgbox("Debe seleccionar una opcion correcta"))
      endswitch
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
  endwhile
endfunction

#Metodo de la Secante
function Secante()
  try
    E=100;
    #xi=0;
    #func(xi)=0;
    #fdev(xi)=0;
    xi_1 = ValidarPrimerdato("x-1");
    xi = ValidarSegundodato("x0");
    func = PedirEcuacion();

    i = 0;
    while (E > (1*10^(-3)))

      fcn_1 = feval(func,xi_1); %funcion evaluada en x-1
      fcn1 = feval(func,xi); %funcion evaluada en x0
      derf = (fcn_1 - fcn1) / (xi_1 - xi);

      if(i ~= 0)
        E = (abs((xi_s - ant)/xi_s))*100;
      endif
      #xi_s = xi - (fcn_1/derf);
      xi_s = xi - (((xi_1 - xi)*fcn1)/(fcn_1-fcn1));
      ant = xi;

      xvect(i+1) = xi;
      fcnvec(i+1) = fcn_1;
      dervec(i+1) = derf;
      Evect(i+1) = E;

      xi_1 = xi;
      xi = xi_s;
      i++;
    endwhile
    MostrarSecante(xvect,fcnvec,dervec,Evect)
  catch
    waitfor(msgbox("Error en Metodo la Secante","Error"));
  end_try_catch
endfunction

function funct=PedirEcuacion()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese la Funcion")
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

 function dato=ValidarPrimerdato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato de %s',msg))
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

 function dato=ValidarSegundodato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el dato de %s',msg))
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

#Funcion para mostrar Metodo de la Secante
function MostrarSecante(xvect,fcnvec,dervec,Evect)
Men1=0;
  while(Men1!=4)
    try
      Men1=menu("Menu Mostrar",
      "Tabla", "Valor de la raíz con error menor 0.001","Todo",  "Atras")
      switch(Men1)
        case 1
           answer=[1,xvect(1),fcnvec(1),dervec(1),100000];

           for i=2:length(xvect)
            newLine = [i,xvect(i),fcnvec(i),dervec(i),Evect(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer)
           newLine=[" i |"," X |"," F(xi) |","F_d(xi)"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))
        case 2
           raiz=xvect(length(xvect));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
        case 3
           answer=[1,xvect(1),fcnvec(1),dervec(1),100000];
           for i=2:length(xvect)
           newLine = [i,xvect(i),fcnvec(i),dervec(i),Evect(i)];
           before = answer;
           answer = [before; newLine];
         endfor
          answer=num2str(answer);
           newLine=[" i |"," X |"," F(xi) |"," F_d(xi) |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))
           raiz=xvect(length(xvect));
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
          case 4
        otherwise
           waitfor(msgbox("Debe seleccionar una opcion correcta"))
      endswitch
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
  endwhile
endfunction
