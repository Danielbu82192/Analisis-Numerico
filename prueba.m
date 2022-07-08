function prueba()
   funcInput=inputdlg ("Ingrese funcion")
   eval(['func = @(x) (' funcInput{1,1} ');']);   
   #funct=@(x,y)(x+y)
   #funct
   Y=[1 2 3 4 5]
   z=[1 1 1 1 1]
   try
    k=func(Y)
   catch err
    err.identifier
    err.message
    end_try_catch
  endfunction