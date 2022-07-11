function MetodosCerrados()      
    Men=0; 
    while(Men!=3)
    try
      Men=menu("Menu Metodos Cerrados","Metodo de Bisección",
      "Metodo de falsa posición", "Atras")
       switch(Men)
          case 1
            Biseccion()
        endswitch
    catch
      waitfor(msgbox("Error en el menu de metodos cerrados","Error"))
    end_try_catch
   endwhile
 endfunction
 
 
 function Biseccion()
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
    ban=1;
    i=i+1;
  endwhile
  
  Mostrar(Avec,Bvec,MNvec,sigvect,errorVect);
  
    catch
      waitfor(msgbox("Error en Biseccion","Error"))
    end_try_catch
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
 
 function funct=PedirFormula()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion")
      eval(['funct = @(x) (' funcInput{1,1} ');']);   
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
 
 
function Mostrar(Avec,Bvec,MNvec,sigvect,errorVect)
Men1=0;
  while(Men1!=4)
    try
      Men1=menu("Menu Mostrar",
      "Tabla", "Valor de la raíz con error menor 0.001","Todo",  "Atras")
      switch(Men1)
        case 1 
           answer=[1,Avec(1),Bvec(1),MNvec(1),sigvect(1),100000];
            
           for i=2:length(Avec)              
           newLine = [i,Avec(i),Bvec(i),MNvec(i),sigvect(i),errorVect(i)];
           before = answer;
           answer = [before; newLine];
         endfor
          answer=num2str(answer)
           newLine=[" i |"," A |"," B |"," MN |"," Signo |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla"))  
        case 2                       
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
        case 3
           answer=[1,Avec(1),Bvec(1),MNvec(1),sigvect(1),100000];            
           for i=2:length(Avec)              
           newLine = [i,Avec(i),Bvec(i),MNvec(i),sigvect(i),errorVect(i)];
           before = answer;
           answer = [before; newLine];
         endfor
          answer=num2str(answer);
           newLine=[" i |"," A |"," B |"," MN |"," Signo |"," Error "];
           before = answer;
           answer = [newLine; before];
           waitfor(msgbox(num2str(answer),"Tabla")) 
           raiz=MNvec(length(MNvec)); 
           waitfor(msgbox(sprintf("La raiz mas proxima es %d",raiz),"Raiz"))
           #opt=questdlg("¿Seguro desea salir?", "Salir", "Si", "No") 
           #if(opt=="No")
          #    Men1=0
          # endif
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