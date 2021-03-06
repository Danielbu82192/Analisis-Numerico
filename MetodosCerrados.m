## METODO CERRADOS
function MetodosCerrado()
    fprintf ("***Metodos Cerrados***\n");
    Men=0;
    while(Men!=4)
    try
      Men=menu("Menu Metodos Cerrados","Metodo de Biseccion",
      "Metodo de falsa posicion", "Atras", "Salir");
       switch(Men)
          case 1
            Biseccion();
           case 2
            falsaPosicion();
           case 3
            Principal();
            Men=4
          case 4
            printf ("Sistema finalizado\n");

        endswitch
    catch
      waitfor(msgbox("Error en el menu de metodos cerrados","Error"))
    end_try_catch
   endwhile
 endfunction

## METODO BISECCION
 function Biseccion()
  clc;
  printf ("Metodo Biseccion\n");
  x=[];
  y=[];
   try
    error=100;
    ban=0;
    A=ValidarUndato("A");
    B=ValidarUndato("B");
    %datos iniciales
    MN=0;
    MNANT=0;
    Fa=0;
    Fmn=0;
    sig=0;
    funct=PedirFormula();
    %primer fila
    MN=(A+B)/2;
    Fa=feval(funct, A);
    Fmn=feval(funct, MN);
    sig=Fa*Fmn;
    Avec(1)=A;
    Bvec(1)=B;
    MNvec(1)=MN;
    sigvect(1)=sig;
    errorVect(1)=000000;
    i=2;
    %calculo
    while (error>(1*10^-3))
      MN=(A+B)/2;
      Fa=feval(funct, A);
      Fmn=feval(funct, MN);
      sig=Fa*Fmn;
      if(ban==1)
        error=abs((MN-MNANT)/MN)*100;
        errorVect(i)=error;
      endif
      if(sig<0)
        MNANT=MN;
        B=MN;
        A=A;
      else if(sig>=0)
        MNANT=MN;
        A=MN;
        B=B;
      endif
    endif
    Avec(i)=A;
    Bvec(i)=B;
    MNvec(i)=MN;
    sigvect(i)=sig;
    x=[x,MN];
    y=[y,Fmn];
    ban=1;
    i=i+1;
  endwhile
  atras=true;
  while (atras)
  % Mostrar datos
    mostrar = menuOpcion();
    grafica = mostrar(1);
    tabla = mostrar (2);
    vraiz = mostrar (3);
    atras = mostrar (4);
    if(grafica == true)
      plot(x,y);
    endif
     if(vraiz == true)
      raiz=MNvec(length(MNvec));
      errorV=errorVect(length(errorVect));
      waitpid(msgbox(sprintf("La raiz aproximada es:%d y el porcentaje de error es:%d \n", raiz, errorV)))
    endif
    if(tabla == true)
     Mostrar(Avec,Bvec,MNvec,sigvect,errorVect);
    endif
  endwhile

    catch
      waitfor(msgbox("Error en Biseccion","Error"))
    end_try_catch
 endfunction

 ## METODO FALSA POSICION
 function falsaPosicion()
   clc;
   printf ("Metodo Falsa Posicion\n");
   x=[];
   y=[];
   try
    error=100;
    ban=0;
    A=ValidarUndato("A");
    B=ValidarUndato("B");
    MN=0;
    MNANT=0;
    Fa=0;
    Fmn=0;
    sig=0;
    funct=PedirFormula();
    Fa=feval(funct, A);
    Favec(1)=Fa;
    Fb=feval(funct, B);
    Fbvec(1)=Fb;
    MN=((A*Fb)-(B*Fa))/(Fb-Fa);
    Fmn=feval(funct, MN);
    sig=Fa*Fmn;
    Avec(1)=A;
    Bvec(1)=B;
    MNvec(1)=MN;
    sigvect(1)=sig;
    errorVect(1)=000000;i=2;
    while (error>(1*10^-3))
    MN=((A*Fb)-(B*Fa))/(Fb-Fa);
      Fa=feval(funct, A);
      Fb=feval(funct, B);
      Favec(i)=Fa;
      Fbvec(i)=Fb;
      Fmn=feval(funct, MN);
      sig=Fa*Fmn;
      if(ban==1)
        error=abs((MN-MNANT)/MN)*100;
        errorVect(i)=error;
      endif
      if(sig<0)
        MNANT=MN;
        B=MN;
        A=A;
      else if(sig>=0)
        MNANT=MN;
        A=MN;
        B=B;
      endif
    endif
    Avec(i)=A;
    Bvec(i)=B;
    MNvec(i)=MN;
    sigvect(i)=sig;
    x=[x,MN];
    y=[y,Fmn];
    ban=1;
    i=i+1;
   endwhile
    atras=true;
    while (atras)
       %Mostrar datos
      mostrar = menuOpcion();
      grafica = mostrar(1);
      tabla = mostrar (2);
      vraiz = mostrar (3);
      atras = mostrar (4);
      if(grafica == true)
        plot(x,y);
      endif
       if(vraiz == true)
        raiz=MNvec(length(MNvec));
        errorV=errorVect(length(errorVect));
         waitpid(msgbox(sprintf("La raiz aproximada es:%d y el porcentaje de error es:%d \n", raiz, errorV)))
      endif
      if(tabla == true)
        MostrarFalsaPosicion(Avec,Bvec,Favec,Fbvec,MNvec,sigvect,errorVect);
      endif
    endwhile

   catch
      waitfor(msgbox("Error en Punto fijo","Error"))
   end_try_catch

 endfunction

 ## VALIDACION DATOS
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

        waitfor(msgbox(err.identifier, err.message))
        waitfor(msgbox ("Error al ingresar el dato","Error"))
     end_try_catch
   endwhile
 endfunction

  ## SOLICITUD DE DATOS
 function funct=PedirFormula()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion");
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

  ## MOSTRAR DATOS BISECCION
function Mostrar(Avec,Bvec,MNvec,sigvect,errorVect)
    try
      answer=[1,Avec(1),Bvec(1),MNvec(1),sigvect(1),100000];

           for i=2:length(Avec)
            newLine = [i,Avec(i),Bvec(i),MNvec(i),sigvect(i),errorVect(i)];
            before = answer;
            answer = [before; newLine];
           endfor
           answer=num2str(answer);
           newLine=[" i |"," A |"," B |","F(a)","F(b)"," MN |"," Signo |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"));

    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch

endfunction
  ## MOSTRAR DATOS FALSA POSICION
function MostrarFalsaPosicion(Avec,Bvec,Favec,Fbvec,MNvec,sigvect,errorVect)
    try
           answer=[1,Avec(1),Bvec(1),Favec(1),Fbvec(1),MNvec(1),sigvect(1),100000];

           for i=2:length(Avec)
           newLine = [i,Avec(i),Bvec(i),Favec(i),Fbvec(i),MNvec(i),sigvect(i),errorVect(i)];
           before = answer;
           answer = [before; newLine];
         endfor
          answer=num2str(answer);
           newLine=[" i |"," A |"," B |"," F(a) |"," F(b) |"," MN |"," Signo |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"));
    catch err
      waitfor(msgbox(err.identifier, err.message));
      waitfor(msgbox("Error en el menu principal","Error"));
    end_try_catch
endfunction
