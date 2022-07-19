function MetodosMatriciales()
    Men3=0;
    while(Men3!=5)
    try
      Men3=menu("Menu Metodos Matriciales","Metodo de cramer",
      "Metodo Sarrus","Metodo de Gauss-Seidel","Atras")

    switch(Men3)
      case 1
        Cramer()
      case 2
        Sarrus()
      case 3
        Seidel()
      case 4
        Principal()
    endswitch

     catch
      msgbox("Error en el menu de metodos Matriciales","Error")
     end_try_catch
    endwhile
 endfunction


 function Cramer()
   #matrizA = PedirMatriz();
   #matrizB = PedirMatrizB();
   try
    n = ValidarUndatoFila("(n)");
    m = ValidarUndatoCol("(m)");

    MA = crearmatriz(n,m);
    MB = crearmatrizB(n);

    dMA = det(MA)
    k = size(MA, 2);
    for i = 1:k
      d = MA;
      d(:, i) = MB
      Dt = det(d)
      answer = ['X', num2str(i), ' = ', num2str(Dt / dMA)]
    endfor

   catch
    waitfor(msgbox("Error en Cramer","Error"));
   end_try_catch

   #da = det(crearmatriz(n,m))

endfunction

function A=crearmatriz(n,m)

  #n = ValidarUndatoFila("(n)");
  #m = ValidarUndatoCol("(m)");

  for i=1:n
    for j=1:m
      A(i,j) = str2double(inputdlg(sprintf('Ingrese el Elemento de la Matriz A (%d,%d)',i,j)));
    endfor
  endfor
endfunction

function B=crearmatrizB(n)

  #n = ValidarUndatoFila("(n)");
  #m = ValidarUndatoCol("(m)");

  for i=1:n
    for j=1:1
      B(i,j) = str2double(inputdlg(sprintf('Ingrese el Elemento de la Matriz B (%d,%d)',i,j)));
    endfor
  endfor
endfunction

function dato=ValidarUndatoFila(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el numero de Filas de la Matriz %s',msg))
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

function dato=ValidarUndatoCol(msg)
   ban=1;
   while ban!=0
     try
       dato{1,1}="";
       dato=inputdlg(sprintf('Ingrese el numero de Columnas de la Matriz %s',msg))
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

#Metodo Sarrus
 function Sarrus()
   try
     n = ValidarUndatoFila("(n)");
     m = ValidarUndatoCol("(m)");
     if(n == 3)
      if(m == 3)
        MA = crearmatriz(n,m);

        MA;
        #MB = MA([1,2],:)
        MB = MA(:,[1,2]);
        MR = [MA MB]
        #dig = diag(MR);
        #dig1 = diag(MR,1);
        #dig2 = diag(MR,2);
        #b = [dig dig1 dig2];

        x=MR;
        i=1;
        f=length(x);
        a=[];
        while f>=3
          l=f;
          aux=[];
          i=1;
          while(i<=length(x(:,1)))
            m=x(i,:);
            k=m(l);
            aux=[aux k];
            l--;
            i++;
          endwhile
          f--;
          a=[a;aux];
        endwhile
        a

        j=1;
        h=1;
        b=[];
        while(h<=length(x(:,1)))
          u=h;
          auxb=[];
          j=1;
          while(j<=length(x(:,1)))
            z=x(j,:);
            q=z(u);
            auxb=[auxb q];
            u++;
            j++;
          endwhile
          h++;
          b=[b;auxb];
        endwhile
        b

        opb = b([1,],:);
        ob1 = prod(opb);

        opb2 = b([2,],:);
        ob2 = prod(opb2);

        opb3 = b([3,],:);
        ob3 = prod(opb3);

        opa = a([1,],:);
        oa1 = prod(opa);

        opa2 = a([2,],:);
        oa2 = prod(opa2);

        opa3 = a([3,],:);
        oa3 = prod(opa3);

        bsuma = ob1 + ob2 + ob3;
        asuma = oa1 + oa2 + oa3;

        DA = bsuma - asuma;

        waitfor(msgbox(sprintf("La Determinante de la Matriz es %d",DA)))

      endif
     else
        waitfor(msgbox ("Debe de ser una matriz de 3x3","Alerta"))
     endif
   catch
    waitfor(msgbox("Error en Sarrus","Error"));
   end_try_catch
endfunction

#Metodo Gauss-Seidel
function Seidel()
   try

    #Solucion por Gauss-Seidel
    n = ValidarUndatoFila("(n)");
    m = ValidarUndatoCol("(m)");

    MA = crearmatriz(n,m);
    MB = crearmatrizB(n);

    #Sistema Diagonalmente Dominante


    c = size(MA, 2); %Numero de columnas de la Matriz A
    x = zeros (1, c);
    e = ones(1, c);
    answer = [x, e];
    flag = true;
    i = 1;
    while(flag &&  (i < 1000))
      for j = 1:c
        x_j = MB(j, 1);
        for k = 1:c
          if (j != k)
            x_j = x_j - (MA(j, k) * x(k));
          endif
        endfor
        x(j) = x_j / MA(j, j);
        e(j) = abs(100 * (x(j) - answer(i, j)) / x(j));
      endfor

      answer = [answer; x, e];

      ver = 0;
      for t = 1:c
        if e(t) > (1 * 10^(-3))
          ver = ver + 1;
        endif
      endfor
      if (ver == 0)
        flag = false;
      endif

      i++;
    endwhile

    titles = "";
    for MA = 1:c
      titles = strcat(titles, "[X", int2str(MA), "]");
    endfor
    for MA = 1:c
      titles = strcat(titles, "[E", int2str(MA), "]");
    endfor
    titles
    answer

   catch
    waitfor(msgbox("Error en Gauss-Seidel","Error"));
   end_try_catch
endfunction




