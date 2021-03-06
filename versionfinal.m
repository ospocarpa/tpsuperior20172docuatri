pkg load control;
pkg load signal;

######                                                   
###   VENTANA PRINCIPAL   #####                      
#####
function abrirVentanaPrincipal ()
  ventanaPrincipal = figure;
  set (ventanaPrincipal,"name","AMIC - Aproximacion por Minimos Cuadrados");
  set (ventanaPrincipal,"numbertitle","off");
  set (ventanaPrincipal,"color",[.5,.5,.5]);
  set (ventanaPrincipal,"menubar","none"); #barra de menu principal y herramientas desaparecen

  entornoPrincipal = uibuttongroup (ventanaPrincipal, "position", [ 0 0 1 1], ...
                 "title","Elija una opcion", ...
                 "titleposition","centertop","fontsize",11,"fontname","Arial");
             
  botonCoeficientes = uicontrol (entornoPrincipal,"string","Aproximar", ...
                 "position",[125,250,300,100],"callback",{@abrirVentanaAproximar}, ...
                 "backgroundcolor",[.8,.8,.8]);
                 
  botonFinalizar = uicontrol (entornoPrincipal,"string","Finalizar", ...
                 "position",[125,100,300,100],"callback",{@cerrarVentana}, ...
                 "backgroundcolor",[.8,.8,.8]);
endfunction


###################################################################################
#                                      APROXIMAR                                  #
###################################################################################


######                                                   
###   VENTANA APROXIMAR   #####                      
#####
function abrirVentanaAproximar (handlesource,event)
  ventanaAproximar = figure;
  set (ventanaAproximar,"name","Aproximacion por minimos cuadrados");
  set (ventanaAproximar,"numbertitle","off");
  

  entornoAproximar = uibuttongroup (ventanaAproximar, "position", [ 0 0 1 1], ...
               "title","Establezca los puntos y elija su aproximacion","titleposition","centertop");
               
  textoEjeX = uicontrol (entornoAproximar,"style","text", ...
               "string","Eje x:","position",[100,350,300,40], ... 
               "fontsize",16);
  ejeX = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "1.2,2.1,2.8,3.1,3.5,4.1,4.4,4.9,5.6,5.9,6.2,6.5", "position",[120,310,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  textoEjeY = uicontrol (entornoAproximar,"style","text", ...
               "string","Eje y :","position",[100,250,300,40], ... 
               "fontsize",16);  
  ejeY = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "1.06,2.14,3.23,3.8,4.7,6.3,7.33,9.48,13.98,16.56,20.23,25.45", "position",[120,210,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  textoCantDecimales = uicontrol (entornoAproximar,"style","text", ...
               "string","Cantidad decimales:","position",[100,150,300,40], ... 
               "fontsize",16);
               
  cantDecimales = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "2", "position",[120,110,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
               "position",[330,50,200,40],"callback",...
                {@seleccionMetodos,ejeX,ejeY,cantDecimales}, ...             
               "backgroundcolor",[.8,.8,.8]);
  
  botonFinalizar = uicontrol (entornoAproximar,"string","Inicio", ...
                 "position",[25,50,200,40],"callback",{@inicio}, ...
                 "backgroundcolor",[.8,.8,.8]);  
                 
endfunction


######                                                   
###   SELECCION METODOS   #####                      
#####  
function seleccionMetodos (handlesource,event,ejeX,ejeY,cantDecimales)
  ventanaSeleccionMetodos = figure;
  set (ventanaSeleccionMetodos,"name","Aproximacion por mi�nimos cuadrados");
  set (ventanaSeleccionMetodos,"numbertitle","off");
  
  entornoSeleccionMetodos = uibuttongroup (ventanaSeleccionMetodos, "position", [ 0 0 1 1], ...
               "title","Elija el metodo de aproximacion","titleposition","centertop");
               
               
  botonRecta = uicontrol (entornoSeleccionMetodos,"string"," Recta de mi�nimos cuadrados", ...
               "position",[150,350,250,30],"callback",...
                {@opcionesAproximacion,ejeX,ejeY,cantDecimales,1}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parabola de minimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,2}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximacion Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximacion Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,4}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximacion Hiperbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,5}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonPCG = uicontrol (entornoSeleccionMetodos,"string","Comparar Aproximaciones", ...
               "position",[150,75,250,50],"callback",{@abrirVentanaComAprox,ejeX,ejeY,cantDecimales}, ...
               "backgroundcolor",[.8,.8,.8]);  
                   
  botonFinalizar = uicontrol (entornoSeleccionMetodos,"string","Inicio", ...
                 "position",[25,25,150,30],"callback",{@inicio}, ...
                 "backgroundcolor",[.8,.8,.8]);             
endfunction


######                                                   
###   OPCIONES APROXIMACION   #####                      
##### 
function opcionesAproximacion (handlesource,event,ejeX,ejeY,cantDecimales,metodo)
  ventanaOpcionesAproximacion = figure;
  set (ventanaOpcionesAproximacion,"name","Aproximacion por Minimos cuadrados");
  set (ventanaOpcionesAproximacion,"numbertitle","off");
  
  entornoOpcionesAproximacion = uibuttongroup (ventanaOpcionesAproximacion, "position", [ 0 0 1 1], ...
               "title","Seleccione la opcion que desea realizar","titleposition","centertop");
               

  botonFuncion = uicontrol (entornoOpcionesAproximacion,"string","Mostrar funcion aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproximante,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproximacion,"string","Obtener detalle del calculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculo,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproximacion,"string","Grafico funcion y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@grafico,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
  
  botonFinalizar = uicontrol (entornoOpcionesAproximacion,"string","Inicio", ...
                 "position",[25,25,150,30],"callback",{@inicio}, ...
                 "backgroundcolor",[.8,.8,.8]);             
endfunction


###################################################################################
#                            FUNCION APROXIMANTE                                  #
###################################################################################

function funcionAproximante (handlesource,event,ejeX,ejeY,cantDecimales,metodo)
  #ventanaFuncionAproximante = figure;
  #set (ventanaFuncionAproximante,"name","Aproximacion por minimos cuadrados");
  #set (ventanaFuncionAproximante,"numbertitle","off");
  
  if (metodo == 1) #Recta
    funcionAproximanteVal = funcionAproxRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    funcionAproximanteVal = funcionAproxParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    funcionAproximanteVal = funcionAproxExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    funcionAproximanteVal = funcionAproxPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    funcionAproximanteVal = funcionAproxHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  
  entornoFuncionAproximante = uibuttongroup (ventanaFuncionAproximante, "position", [ 0 0 1 1], ...
               "title","Funcion Aproximante","titleposition","centertop");
               

  funcionAprox = uicontrol (entornoFuncionAproximante,"style","text", ...
               "string",funcionAproximanteVal,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction

######                                                   
###   FUNCION APROXIMACION RECTA   #####
##### 
 
function funcionAproxRecta(ejeX,ejeY,cantDecimales) 
 h=recta(ejeX,ejeY);

 helpdlg (strcat(" y = ",num2str(h(1),str2num(get(cantDecimales,"string"))+1)," x + ",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\t\t\t\t"),"Recta minimo cuadrado");
     
endfunction
   
function x = recta(ejeX,ejeY)
  # sea ax+b en el vector se guarda a,b
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  
  cantidadPuntos = length(vectorX);
  sumX = sum(vectorX);
  sumY = sum(vectorY);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + vectorX(i)*vectorY(i);
   sumX2 = sumX2 + vectorX(i)^2 ;
  endfor
  
  A = [sumX2,sumX;sumX,cantidadPuntos];
  b = [sumXY;sumY];
  Ai = inv(A);
  x = Ai*b;
   
endfunction

######                                                   
###   FUNCION APROXIMACION PARABOLA   #####                      
##### 


function funcionAproxParabola(ejeX,ejeY,cantDecimales)
  h=parabola(ejeX,ejeY);
  helpdlg (strcat("y=",num2str(h(3),str2num(get(cantDecimales,"string"))+1),"x^2 +",num2str(h(2),...
           str2num(get(cantDecimales,"string"))+1),"x  +  ",num2str(h(1),str2num(get(cantDecimales,"string"))+1),...
           "\t\t\t\t"),"Parabola minimo cuadrado");
  
 # helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
endfunction

function x = parabola(ejeX,ejeY)
  # sea ax^2+bx +c en el vector se guarda a,b,c
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  
  cantidadPuntos = length(vectorX);
  sumX    = sum(vectorX);
  sumY    = sum(vectorY);
  sumX2   = 0;  #sumatoria de x^2
  sumx3   = 0;
  sumx4   = 0;
  sumXY   = 0;
  sumx2y  = 0;
  
  for i=1:cantidadPuntos

   sumX2  = sumX2 + vectorX(i)^2 ;
   sumx3  = sumx3 + vectorX(i)^3 ;
   sumx4  = sumx4 + vectorX(i)^4 ;
   sumXY  = sumXY + vectorX(i)*vectorY(i);
   sumx2y = sumx2y + vectorX(i)^2*vectorY(i);
  
  endfor
  
  A = [cantidadPuntos,sumX,sumX2;sumX,sumX2,sumx3;sumX2,sumx3,sumx4];
  b = [sumY;sumXY;sumx2y];
  Ai = inv(A);
  x = Ai*b;
   
endfunction


######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 
function x = exponencial(ejeX,ejeY)
  # sea y=be^ax  --> lny =lnb +ax --> Y=B +AX
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  # Y = ln(ejeY)
  Y=[];
  cantidadPuntos = length(vectorX);
  for i=1:cantidadPuntos 
   Y(i) =log(vectorY(i)); 
  endfor  
  #su aproximacion es similar a la de la recta
  sumX = sum(vectorX);
  sumy =sum(vectorY);
  sumY = sum(Y);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + vectorX(i)*Y(i);
   sumX2 = sumX2 + vectorX(i)^2 ;
  endfor
  
  A = [sumX2,sumX;sumX,cantidadPuntos];
  b = [sumXY;sumY];
  Ai = inv(A);
  x = Ai*b;
  x(2)=exp(x(2)); 
endfunction

function funcionAproxExponencial(ejeX,ejeY,cantDecimales)
    
  h=exponencial(ejeX,ejeY);

 helpdlg (strcat("y=",num2str(h(2),str2num(get(cantDecimales,"string"))),"*e^(",num2str(h(1),str2num(get(cantDecimales,"string"))),"*x)","\t\t\t\t"),"Exponente de minimo cuadrado");
     
endfunction

######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 

function x = potencial(ejeX,ejeY)
  # sea y=bx^a  --> lny =lnb +alnx --> Y=B +aX
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  # Y = ln(ejeY)
  # X = ln(ejeX)
  Y=[];
  X=[];
  cantidadPuntos = length(vectorX);
  for i=1:cantidadPuntos 
   Y(i) =log(vectorY(i)); 
   X(i) =log(vectorX(i));
  endfor  
  #su aproximacion es similar a la de la recta
  sumx = sum(vectorX);
  sumX =sum(X);
  sumy =sum(vectorY);
  sumY = sum(Y);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + X(i)*Y(i);
   sumX2 = sumX2 + X(i)^2 ;
  endfor
  
  A = [sumX2,sumX;sumX,cantidadPuntos];
  b = [sumXY;sumY];
  Ai = inv(A);
  x = Ai*b;  # x(1)=a  x(2)=B  B=ln(b)
  x(2)=exp(x(2)); 
endfunction



function funcionAproxPotencial(ejeX,ejeY,cantDecimales)
    
  h=potencial(ejeX,ejeY);

 helpdlg (strcat("y=",num2str(h(2),str2num(get(cantDecimales,"string"))),"*x^(",num2str(h(1),str2num(get(cantDecimales,"string"))+1),") ","\t\t\t\t\t\t"),"Potencial de minimo cuadrado");
end

######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 
function x= hiperbola(ejeX,ejeY)
  #sea y=(a)/(b+x)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  #X=ejex
  #Y=1/ejey 
  Y=[];
  X=[];
  cantidadPuntos = length(vectorX);
  for i=1:cantidadPuntos 
   Y(i) =1/(vectorY(i)); 
   X(i) =vectorX(i);
  endfor  
    #su aproximacion es similar a la de la recta
  sumX =sum(X);
  sumY = sum(Y);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + X(i)*Y(i);
   sumX2 = sumX2 + X(i)^2 ;
  endfor
  
  A = [cantidadPuntos,sumX;sumX,sumX2];
  b = [sumY;sumXY];
  Ai = inv(A);
  x = Ai*b;  # x(1)=B  x(2)=A 
  b=x(1);
  a=x(2);
  x(1)=(b/a);
  x(2)=(1/a);
 endfunction 
  
function funcionAproxHiperbola(ejeX,ejeY,cantDecimales)
    
  h=hiperbola(ejeX,ejeY);
    
  helpdlg (strcat("y=",(num2str(h(2),str2num(get(cantDecimales,"string"))+1)),"/(",(num2str(h(1),str2num(get(cantDecimales,"string"))+1)),"+ X)\t\t\t\t\t\t"),"Hiperbola de Minimo Cuadrado");
end
###################################################################################
#                              DETALLE CALCULO                                    #
###################################################################################   

function detalleCalculo (handlesource,event,ejeX,ejeY,cantDecimales,metodo) 
 # ventanaDetalleCalculo = figure;
 # set (ventanaDetalleCalculo,"name","Aproximacion por minimos cuadrados");
 # set (ventanaDetalleCalculo,"numbertitle","off");
  
  if (metodo == 1) #Recta
    detalleCalculoVal = detalleCalculoRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    detalleCalculoVal = detalleCalculoParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    detalleCalculoVal = detalleCalculoExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    detalleCalculoVal = detalleCalculoPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    detalleCalculoVal = detalleCalculoHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  entornoDetalleCalculo = uibuttongroup (ventanaDetalleCalculo, "position", [ 0 0 1 1], ...
               "title","Detalle calculo","titleposition","centertop");
               
  detalleCalc = uicontrol (entornoDetalleCalculo,"style","text", ...
               "string",entornoDetalleCalculo,"position",[100,250,300,40], ... 
               "fontsize",16);
               
endfunction
#matri(1,1) es el numero de la 1era fila y 1era columna


######                                                   
###   DETALLE CALCULO RECTA   #####
#####                 
function detalleCalculoRecta(ejeX,ejeY,cantDecimales)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));

  cantidadPuntos = length(vectorX);
  str= "\ni \t\t xi \t\t yi\t\t xi^2\t\t xi.yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t\t",num2str(vectorX(i)),"\t\t",num2str(vectorY(i)),"\t\t",num2str(vectorX(i)^2),"\t\t",num2str(vectorX(i)*vectorY(i))," \n");
  endfor
  sumX = sum(vectorX);
  sumY = sum(vectorY);
  sumXY=0;
  sumX2=0;  #sumatoria de x^2
  for i=1:cantidadPuntos
    sumXY = sumXY + vectorX(i)*vectorY(i);
    sumX2 = sumX2 + vectorX(i)^2 ;
  endfor 
       
  str=strcat(str,"\t\t",num2str(sumX),"\t\t",num2str(sumY),"\t\t",num2str(sumX2),"\t\t",num2str(sumXY),"\n\n");
  
  h=recta(ejeX,ejeY); #S
  
  str=strcat(str,"El sistema planteado es\n\n",...
       "a *",num2str(sumX2),"\t","+","\t","b *",num2str(sumX),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX),"\t","+","\t","b *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n","b =",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n",...
       num2str(h(1),str2num(get(cantDecimales,"string"))+1),"X + ",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo  \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t  \t \t \t \t \t \t \t ");
endfunction      


######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 

function detalleCalculoParabola(ejeX,ejeY,cantDecimales)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));

  cantidadPuntos = length(vectorX);
  str= "\ni \t xi \t yi\t xi^2\t xi^3\t\t xi^4\t\t xi.yi\t  xi^2.yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t",num2str(vectorX(i)),"\t",num2str(vectorY(i)),"\t",num2str(vectorX(i)^2),"\t",num2str(vectorX(i)^3),"\t\t",num2str(vectorX(i)^4),"\t\t",num2str(vectorX(i)*vectorY(i)),"\t",num2str(vectorX(i)^2*vectorY(i))," \n");
  endfor
  sumX = sum(vectorX);
  sumY = sum(vectorY);
  sumXY=0;
  sumX2=0;  #sumatoria de x^2
  sumx3   = 0;
  sumx4   = 0;
  sumXY   = 0;
  sumx2y  = 0;
  for i=1:cantidadPuntos
    sumXY = sumXY + vectorX(i)*vectorY(i);
    sumX2 = sumX2 + vectorX(i)^2 ;
    sumx3  = sumx3 + vectorX(i)^3 ;
    sumx4  = sumx4 + vectorX(i)^4 ;
    sumx2y = sumx2y + vectorX(i)^2*vectorY(i);
  endfor 
       
  str=strcat(str,"\t",num2str(sumX),"\t",num2str(sumY),"\t",num2str(sumX2),"\t",num2str(sumx3),"\t\t",num2str(sumx4),"\t\t",num2str(sumXY),"\t",num2str(sumx2y),"\n\n");
  
  h=parabola(ejeX,ejeY); #S
  
  str=strcat(str,"El sistema planteado es\n\n",...
       "a *",num2str(cantidadPuntos),"\t","+","\t","b *",num2str(sumX),"\t","+","\t","c *",num2str(sumX2),"\t","=","\t",num2str(sumY),"\n\n",...
       "a *",num2str(sumX),"\t","+","\t","b *",num2str(sumX2),"\t","+","\t","c *",num2str(sumx3),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX2),"\t","+","\t","b *",num2str(sumx3),"\t","+","\t","c *",num2str(sumx4),"\t","=","\t",num2str(sumx2y),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(3),str2num(get(cantDecimales,"string"))+1),"\n","b =",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n","c =",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n\n",...
       num2str(h(3),str2num(get(cantDecimales,"string"))+1),"X^2 + ",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"X  + ",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t");
endfunction
######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 

function detalleCalculoExponencial(ejeX,ejeY,cantDecimales)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));

  cantidadPuntos = length(vectorX);
  str= "\ni \t xi \t yi\t Y=lny\t\t xi^2\t\t xi.Yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t",num2str(vectorX(i)),"\t",num2str(vectorY(i)),"\t",num2str(log(vectorY(i))),"\t\t",num2str(vectorX(i)^2),"\t\t",num2str(vectorX(i)*log(vectorY(i)))," \n");
  endfor
  ####
   Y=[];
  for i=1:cantidadPuntos 
   Y(i) =log(vectorY(i)); 
  endfor  
  #su aproximacion es similar a la de la recta
  sumX = sum(vectorX);
  sumy =sum(vectorY);
  sumY = sum(Y);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + vectorX(i)*Y(i);
   sumX2 = sumX2 + vectorX(i)^2 ;
  endfor
  #####
   
       
  str=strcat(str,"\t",num2str(sumX),"\t",num2str(sumy),"\t",num2str(sumY),"\t\t",num2str(sumX2),"\t\t",num2str(sumXY),"\n\n");
  
  h=exponencial(ejeX,ejeY); #S
  
  str=strcat(str,"El sistema planteado es\n\n",...
       "a *",num2str(sumX2),"\t","+","\t","B *",num2str(sumX),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX),"\t","+","\t","B *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n","B =",num2str(log(h(2))),"\n",...
      "b =e^B =",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n",...
      "\nla aproximacion exponencial es\n","y=  ",num2str(h(2),str2num(get(cantDecimales,"string"))),"*e ^( ",num2str(h(1),str2num(get(cantDecimales,"string"))),"*x )","\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo  \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t  \t \t \t \t \t \t \t ");
endfunction

######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 

function detalleCalculoPotencial(ejeX,ejeY,cantDecimales)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));

  cantidadPuntos = length(vectorX);
  str= "\ni \t xi \t yi\t X=lnx\t\tY=lny \t\tXi^2\t\t Xi.Yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t",num2str(vectorX(i)),"\t",num2str(vectorY(i)),"\t",num2str(log(vectorX(i))),"\t\t",num2str(log(vectorY(i))),"\t\t",num2str(log(vectorX(i))^2),"\t\t",num2str(log(vectorX(i))*log(vectorY(i)))," \n");
  endfor
  ####
   Y=[];
   X=[];
  for i=1:cantidadPuntos 
   Y(i) =log(vectorY(i));
   X(i) =log(vectorX(i)); 
  endfor  
  #su aproximacion es similar a la de la recta
  sumx = sum(vectorX);
  sumX =sum(X);
  sumy =sum(vectorY);
  sumY = sum(Y);
  sumXY = 0;
  sumX2 = 0;  #sumatoria de x^2

  for i=1:cantidadPuntos
   sumXY = sumXY + X(i)*Y(i);
   sumX2 = sumX2 + X(i)^2 ;
  endfor
  #####
   
       
  str=strcat(str,"\t",num2str(sumx),"\t",num2str(sumy),"\t",num2str(sumX),"\t\t",num2str(sumY),"\t\t",num2str(sumX2),"\t\t",num2str(sumXY),"\n\n");
  
  h=potencial(ejeX,ejeY); 
  
  str=strcat(str,"El sistema planteado es\n\n",...
       "a *",num2str(sumX2),"\t","+","\t","B *",num2str(sumX),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX),"\t","+","\t","B *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n","B =",num2str(log(h(2))),"\n",...
       "b =e^B =",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n",...
      "\nla aproximacion potencial es\n","Y= " ,num2str(h(2),str2num(get(cantDecimales,"string"))),"* x^( ",num2str(h(1),str2num(get(cantDecimales,"string"))+1),")","\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t  \t \t \t \t \t \t \t  ");
endfunction

######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

function detalleCalculoHiperbola(ejeX,ejeY,cantDecimales)
  vectorX = stringAArray (get (ejeX,"string"));  
  vectorY = stringAArray (get (ejeY,"string"));
  
  cantidadPuntos = length(vectorX); #n
  #Header
  str= "\ni \t\t Xi \t\t Yi=1/y\t\t Xi^2\t\t Xi.Yi\n";
  for i=1 :cantidadPuntos
    str =strcat(str,num2str(i),"\t\t",num2str(vectorX(i)),"\t\t",num2str(1/vectorY(i)),"\t\t",num2str(vectorX(i)^2),"\t\t",num2str(vectorX(i)*(1/vectorY(i)))," \n");
  endfor
  sumX = sum(vectorX);
  sumXY=0;
  sumY=0;
  sumX2=0;  #sumatoria de x^2
  sumXY   = 0;
  for i=1:cantidadPuntos
    sumY  = sumY  + (1/vectorY(i));
    sumXY = sumXY + vectorX(i)*(1/vectorY(i));
    sumX2 = sumX2 + vectorX(i)^2 ;
  endfor 
   str=strcat(str,"\t\t",num2str(sumX),"\t\t",num2str(sumY),"\t\t",num2str(sumX2),"\t\t",num2str(sumXY),"\n\n");
     h=hiperbola(ejeX,ejeY);
       
     str=strcat(str,"El sistema planteado es\n\n",...
     "a *",num2str(cantidadPuntos),"\t","+","\t","b *",num2str(sumX),"\t","+","\t","=","\t",num2str(sumY),"\n\n",...
     "a *",num2str(sumX),"\t","+","\t","b *",num2str(sumX2),"\t","+","\t","=","\t",num2str(sumXY),"\n\n",...
     "Resolviendo el sistema queda\n\n","a =",num2str(h(2),str2num(get(cantDecimales,"string"))+1),"\n","b =",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"\n","\n\n",...
     num2str(h(2),str2num(get(cantDecimales,"string"))+1),"/( ",num2str(h(1),str2num(get(cantDecimales,"string"))+1),"+ X )\n");

  helpdlg (evalc ("str"),"Detalle del calculo \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t  \t \t \t \t \t \t \t ");  
  
endfunction

###################################################################################
#                                  GRAFICO                                        #
################################################################################### 
  
function grafico (handlesource,event,ejeX,ejeY,cantDecimales,metodo)
  #ventanaGrafico = figure;
  #set (ventanaGrafico,"name","Aproximacion por minimos cuadrados");
  #set (ventanaGrafico,"numbertitle","off");
  
  if (metodo == 1) #Recta
    grafico = graficoRecta(ejeX,ejeY,cantDecimales)
  elseif (metodo == 2) #Parabola
    grafico = graficoParabola(ejeX,ejeY,cantDecimales)
  elseif (metodo == 3) #Exponencial
    grafico = graficoExponencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 4) #Potencial
    grafico = graficoPotencial(ejeX,ejeY,cantDecimales)
  elseif (metodo == 5) #Hiperbola
    grafico = graficoHiperbola(ejeX,ejeY,cantDecimales)
  endif
 
  entornoGrafico = uibuttongroup (ventanaGrafico, "position", [ 0 0 1 1], ...
               "title","Grafico","titleposition","centertop");
               
  graficoFinal = uicontrol (entornoGrafico,"style","text", ...
               "string",grafico,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction


######                                                   
###   GRAFICO RECTA   #####
#####

function graficoRecta(ejeX,ejeY,cantDecimales) 

  grafico = figure;
  set (grafico,"name","Grafica de la funcion");
  set (grafico,"numbertitle","off");
  
  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y
  
  P = polyfit(x, y, 1); 
  a = P(1); 
  b = P(2); 
  
  hold on 
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')

  plot(x, a*x+b);
  xlabel('x')
  ylabel('y')
  grid on
  title('Recta de minimos cuadrados')
  hold off
   
endfunction

######                                                   
###   GRAFICO PARABOLA   #####                      
##### 

function graficoParabola(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Gr�fica de la funci�n");
  set (grafico,"numbertitle","off");

  puntosX = stringAArray (get (ejeX,"string")); %eje x
  puntosY = stringAArray (get (ejeY,"string")); %eje y
  
  P = polyfit(puntosX, puntosY, 2);

  
  hold on 
  plot(puntosX,puntosY,'ro','markersize',4,'markerfacecolor','r') 
  h=parabola(ejeX,ejeY);
   x=-7:0.2:7; 
 y1=h(1)*x.^2 +h(2)*x +h(3);
  plot(x,y1);
  xlabel('x')
  ylabel('y')
  
  title('Par�bola de m�nimos cuadrados')
  

endfunction

######                                                   
###   GRAFICO EXPONENCIAL   #####                      
##### 

function graficoExponencial(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Grafica de la funcion");
  set (grafico,"numbertitle","off");
  
  X = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  P = polyfit(X,log(y),1);
  a = P(1); 
  b = P(2);
  hold on
  plot(X,y,'ro','markersize',4,'markerfacecolor','r')
  x=-20:0.1:30;
  z = b*exp(a*x);
  plot(x, z);
  
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximacion Exponencial')
  hold off
  
endfunction

######                                                   
###   GRAFICO POTENCIAL   #####                      
##### 

function graficoPotencial(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Grafica de la funcion");
  set (grafico,"numbertitle","off");
  
  X = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  P = polyfit(log(X),log(y),1);
  a = P(1); 
  b = P(2);
  hold on
  plot(X,y,'ro','markersize',4,'markerfacecolor','r')
  x=-10:0.1:10;
  z = b*x.^a;
  plot(x, z);
  
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximacion Potencial')
  hold off

endfunction

######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 

function graficoHiperbola(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Grafica de la funcion");
  set (grafico,"numbertitle","off");
  
  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  p = hiperbola(ejeX,ejeY);
  h=0:0.1:34;
  h1=34.8:0.1:60;
  z = (p(2)./(p(1) + h));
  z1 = (p(2)./(p(1) + h1));
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  plot(h, z,'b');
  plot(h1, z1,'b');
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximacion Hiperbola')
  hold off
  
endfunction


###################################################################################
#                          COMPARAR APROXIMACIONES                                #
###################################################################################
function abrirVentanaComAprox(handlesource,event,ejeX,ejeY,cantDecimales)
  
  vectorX = stringAArray (get (ejeX,"string"));
  vectorY = stringAArray (get (ejeY,"string"));  
  cantidadPuntos = length(vectorX); #n

  #Calculo recta aX + b
  h = recta(ejeX,ejeY); 
  aRec = str2num(num2str(h(1),str2num(get(cantDecimales,"string"))+1));
  bRec = str2num(num2str(h(2),str2num(get(cantDecimales,"string"))+1));
  
  #Calculo parabola aX^2 + bX+ x
  h = parabola(ejeX,ejeY); 
  aPar = str2num(num2str(h(3),str2num(get(cantDecimales,"string"))+1));
  bPar = str2num(num2str(h(2),str2num(get(cantDecimales,"string"))+1));
  cPar = str2num(num2str(h(1),str2num(get(cantDecimales,"string"))+1));
  
  #Calculo exponencial be^(aX)
  h = exponencial(ejeX,ejeY); 
  aExp = str2num(num2str(h(1),str2num(get(cantDecimales,"string"))+1));
  bExp = str2num(num2str(h(2),str2num(get(cantDecimales,"string"))+1));
  
  #Calculo potencial bX^a
  h = potencial(ejeX,ejeY); 
  aPot = str2num(num2str(h(1),str2num(get(cantDecimales,"string"))+1));
  bPot = str2num(num2str(h(2),str2num(get(cantDecimales,"string"))+1));
  
  #Calculo hiperbola a / (b + X)
  h = hiperbola(ejeX,ejeY);
  aHip = str2num(num2str(h(2),str2num(get(cantDecimales,"string"))+1));
  bHip = str2num(num2str(h(1),str2num(get(cantDecimales,"string"))+1));
  
  #Tabla comparaciones
  str1 ="\n _________________________________________________________________________________________________________________________________________________________________\n";
  str = "\n  Datos    \0  | \t\t   Modelos Aproximantes  \t   \t  | \t\t \t\t    Error  ";
  str = strcat(str1,str,str1,"\n i \0 Xi \0 Yi   \0 \0 \0   Recta \0 Parabola \0 Exponencial \0 Potencial \0 Hiperbola  \0 | \t  Recta \t\t Parabola \t Exponencial \t Potencial \t Hiperbola \0 ",str1);
   totalerrorRecta=0;
  totalerrorParabola=0;
  totalerrorExponencial=0;
  totalerrorPotencial=0;
  totalerrorHiperbola=0;
  
 for i=1 :cantidadPuntos

    recta = aRec*vectorX(i) + bRec; 
    parabola =  (aPar*(vectorX(i)^2)) + (bPar*vectorX(i)) + vectorX(i); 
    exponencial = bExp * exp (aExp * vectorX(i));
    potencial = bPot * (vectorX(i)^aPot);
    hiperbola = aHip / (bHip + vectorX(i));
    
    errorRecta = (vectorY(i)-recta)^2;
    errorParabola = (vectorY(i)-parabola)^2;
    errorExponencial = (vectorY(i)-exponencial)^2;
    errorPotencial = (vectorY(i)-potencial)^2;
    errorHiperbola = (vectorY(i)-hiperbola)^2;
    
    str = strcat(str,num2str(i)," \0 \0 \0 \0 ",num2str(vectorX(i))," \0 \0 \0 \0 ",num2str(vectorY(i)),"\t",num2str(recta),"\t",num2str(parabola),...
              "\t \0 \0 ",num2str(exponencial),"\t \0 \0 \0 \0 \0 \0 ",sprintf("%.5f",potencial),"\t \0 \0 \0  ",sprintf("%.5f",hiperbola),"\t \0 \0 \0  ",num2str(errorRecta),"\t",num2str(errorParabola),...
              "\t\t",num2str(errorExponencial),"\t\t",sprintf("%.5f",errorPotencial),"\t\t",num2str(errorHiperbola),str1);
              
    totalerrorRecta = totalerrorRecta + errorRecta;
    totalerrorParabola = totalerrorParabola + errorParabola;
    totalerrorExponencial = totalerrorExponencial + errorExponencial;
    totalerrorPotencial = totalerrorPotencial + errorPotencial;
    totalerrorHiperbola = totalerrorHiperbola + errorHiperbola; 
 
  endfor

  str=strcat(str,"\n\n Se calculo la suma de los cuadrados de las distancias de cada funcion\n");   
  str=strcat(str," \n\n El metodo que mejor se aproxima es:","\t");
  matriz=[totalerrorRecta,totalerrorParabola,totalerrorExponencial,totalerrorPotencial,totalerrorHiperbola];
  cantidadMetodos = length(matriz);
  metodoMinimoError = min(matriz);
  
  for i=1:cantidadMetodos
    switch(i)
     case 1
       if (matriz(i)==metodoMinimoError)
           str=strcat(str,"  Recta de Minimos Cuadrados\n\n","\n");
       endif
      case 2 
           if (matriz(i)==metodoMinimoError)
           str=strcat(str,"  Parabola de Minimos Cuadrados\n\n","\n");
           endif
      case 3 
           if (matriz(i)==metodoMinimoError)
            str=strcat(str,"  Exponencial de Minimos Cuadrados\n\n","\n");
           endif
      case 4 
           if (matriz(i)==metodoMinimoError)
           str=strcat(str,"  Potencial de Minimos Cuadrados\n\n","\n");
           endif
      case 5 
           if (matriz(i)==metodoMinimoError)
           str=strcat(str,"  Hiperbola de Minimos Cuadrados\n\n","\n");
           endif
   endswitch
  endfor
   
    helpdlg (evalc ("str"),"\t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t  \t \t \t \t \t \t \t  \t \t \t \t \t \t \t Comparacion Aproximaciones"); 
  
endfunction
###################################################################################
#                                   FINALIZAR                                     #
###################################################################################

function cerrarVentana()
  close all;  
  
endfunction

function inicio()
  close all;  
  abrirVentanaPrincipal();
endfunction


###################################################################################
#                         FUNCIONES AUXILIARES                                    #
###################################################################################

function array = stringAArray (str)
    charArray = strsplit(str,",");
    array = [];
    len = length (charArray);
    for i = 1:len
        array(i) = str2double (charArray{i});
    endfor
endfunction 



abrirVentanaPrincipal();