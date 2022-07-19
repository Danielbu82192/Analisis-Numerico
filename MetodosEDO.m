function MetodosEDO()
    fprintf ("***Metodos EDO***\n");
    Men=0;
    while(Men!=3)
    try
      Men=menu("Menu Metodos EDO","Metodo de euler",
      "Runge-Kutta 4to orden", "Atras", "Salir");
       switch(Men)
          case 1
            EULER();
           case 2
            RK4();
           case 3
            Principal();
          case 4
            printf ("Sistema finalizado\n");
        endswitch
    catch
      waitfor(msgbox("Error en el menu de metodos EDO","Error"))
    end_try_catch
   endwhile
endfunction

function EULER()
  fprintf ("***Metodos EULER***\n");
    Men=0;
    while(Men!=3)
    try
      Men=menu("Menu Metodos EDO","Primer orden",
      "Segundo orden", "Atras", "Salir");
       switch(Men)
          case 1
            EULEROR1();
           case 2
            EULEROR2();
           case 3
            MetodosEDO();
          case 4
            printf ("Sistema finalizado\n");
        endswitch
    catch
      waitfor(msgbox("Error en el menu de EULER","Error"))
    end_try_catch
   endwhile
endfunction

function EULEROR1()
  try 
    func=PedirFormula();
    x0=ValidarUndato("x");
    y0=ValidarUndato("y");    
    h=ValidarUndato("h");  
    a=ValidarUndato("Inicio");
    f=ValidarUndato("Finalizacion");      
    #func=@(x,y)(-1.5*y);
    #x0=0;
    #y0=0.5;    
    #h=0.5;  
    #a=0;
    #f=2;     
    x=x0;
    y=y0; 
    i=0;
    Matriz=[];
    Vx=[];
    Vy=[]
    while(x<=f)
      Matriz=[Matriz; i x y];
      Vx=[Vx x];
      Vy=[Vy y];
      y=y+(feval(func,x, y)*h);
      x=x+h;
      i++;
    endwhile   
    Matriz
    Vx
    Vy
  catch err
        waitfor(msgbox(err.identifier, err.message))
      waitfor(msgbox("Error en el menu de EULER","Error"))
  end_try_catch
  
 endfunction
 
function EULEROR2()
  try
    func1=PedirFormula2("dy/dx");
    func2=PedirFormula2("dz/dx");
    x0=ValidarUndato("x");
    y0=ValidarUndato("y"); 
    z0=ValidarUndato("z");    
    h=ValidarUndato("h");  
    a=ValidarUndato("Inicio");    
    f=ValidarUndato("Finalizacion");   
    #func1=@(x,y,z)((1999*y)+(2999*z));
    #func2=@(x,y,z)((-2000*y)+(-3000*z));
    #x0=0;
    #y0=1;  
    #z0=1;      
    #h=0.05;  
    #a=0;
    #f=0.2;     
    x=x0;
    y=y0; 
    z=z0; 
    i=0;
    Matriz=[];
    Vx=[];
    Vy=[]
    Vz=[];
    while(x<=f)
      Matriz=[Matriz; i x y z];
      Vx=[Vx x];
      Vy=[Vy y];
      Vz=[Vz z];
      yi=y+(feval(func1,x, y,z)*h);
      zi=z+(feval(func2,x, y,z)*h);
      x=x+h;
      z=zi;
      y=yi;
      i++;
    endwhile   
    Matriz
    Vx
    Vy
    Vz
  catch
      waitfor(msgbox("Error en el menu de EULER","Error"))
  end_try_catch
  endfunction
  
function RK4()
  fprintf ("***Metodos RK4***\n");
    Men=0;
    while(Men!=3)
    try
      Men=menu("Menu Metodos RK4","Primer orden",
      "Segundo orden", "Atras", "Salir");
       switch(Men)
          case 1
            RK4Orden1();
           case 2
            RK4Orden2();
           case 3
            MetodosEDO();
          case 4
            printf ("Sistema finalizado\n");
        endswitch
    catch
      waitfor(msgbox("Error en el menu de RK4","Error"))
    end_try_catch
   endwhile
endfunction
  
function RK4Orden1()
  try 
    func=PedirFormula();
    x0=ValidarUndato("x");
    y0=ValidarUndato("y");    
    h=ValidarUndato("h");  
    a=ValidarUndato("Inicio");
    f=ValidarUndato("Finalizacion");  
    #func=@(x,y)(-1.5*y);
    #x0=0;
    #y0=0.5;    
    #h=0.5;  
    #a=0;
    #f=2;    
    x=x0;
    y=y0; 
    i=0;
    Matriz=[];
    Vx=[];
    Vy=[]
    while(x<=f)
      Matriz=[Matriz; i x y];
      Vx=[Vx x];
      Vy=[Vy y];
      k1=feval(func,x, y);
      k2=feval(func,x+(h/2), y+(k1*(h/2)));
      k3=feval(func,x+(h/2), y+(k2*(h/2)));
      k4=feval(func,x+(h), y+(k3*(h)));
      q=1/4*(k1+k2+k3+k4);
      yi=y+(q*h);      
      x=x+h;
      y=yi;
      i++;
    endwhile
    Matriz
  catch
      waitfor(msgbox("Error en RK4","Error"))
  end_try_catch  
 endfunction
 
 
function RK4Orden2()
  try
    func1=PedirFormula2("dy/dx");
    func2=PedirFormula2("dz/dx");
    x0=ValidarUndato("x");
    y0=ValidarUndato("y"); 
    z0=ValidarUndato("z");    
    h=ValidarUndato("h");  
    a=ValidarUndato("Inicio");    
    f=ValidarUndato("Finalizacion");     
    #func1=@(x,y,z)((-0.6*z)-(8*y));
    #func2=@(x,y,z)(z);
    #x0=0;
    #y0=4; 
    #z0=0;    
    #h=0.5;  
    #a=0;
    #f=2;    
    x=x0;
    y=y0; 
    z=z0;
    i=0;
    Matriz=[];
    Vx=[];
    Vy=[];
    Vz=[];
    while(x<=f)
      Matriz=[Matriz; i x y z];
      Vx=[Vx x];
      Vy=[Vy y];
      Vz=[Vz z];
      k1y=feval(func1,x, y,z);
      k1z=feval(func2,x, y,z);
      k2y=feval(func1,x+(h/2), y+(k1y*(h/2)),z+(k1z*(h/2)));
      k2z=feval(func2,x+(h/2), y+(k1y*(h/2)),z+(k1z*(h/2)));
      k3y=feval(func1,x+(h/2), y+(k2y*(h/2)),z+(k2z*(h/2)));
      k3z=feval(func2,x+(h/2), y+(k2y*(h/2)),z+(k2z*(h/2)));
      k4y=feval(func1,x+(h), y+(k3y*(h)),z+(k3z*(h)));
      k4z=feval(func2,x+(h), y+(k3y*(h)),z+(k3z*(h)));
      qy=1/4*(k1y+k2y+k3y+k4y);
      qz=1/4*(k1z+k2z+k3z+k4z);
      yi=y+(qy*h);      
      zi=z+(qz*h);      
      x=x+h;
      y=yi;
      z=zi;
      i++;
    endwhile
    Matriz
  catch
      waitfor(msgbox("Error en RK4","Error"))
  end_try_catch  
 endfunction
 
 
 function K=SolucionKorden2()
   try
    K1=feval(func,x, y,z);
      K2=[K,feval(func,x+(h/2), y+(k1*(h/2))),];
      k3y=feval(func,x+(h/2), y+(k2*(h/2)));
      k4y=feval(func,x+(h), y+(k3*(h)));
   catch
      waitfor(msgbox("Error en RK4","Error"))
   end_try_catch
 endfunction
 
 function dato=ValidarUndato(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el valor de %s',msg));
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
 
 function funct=PedirFormula()
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg ("Ingrese funcion");
      eval(['funct = @(x,y) (' funcInput{1,1} ');']);
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
 
 function funct=PedirFormula2(msg)
   ban=1;
   while ban!=0
     try
      funcInput=inputdlg (sprintf('Ingrese funcion de %s',msg));
      eval(['funct = @(x,y,z) (' funcInput{1,1} ');']);
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