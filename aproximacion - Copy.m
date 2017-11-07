
pkg load control;
pkg load signal;

######                                                   
###   VENTANA PRINCIPAL   #####                      
#####
function abrirVentanaPrincipal ()
  ventanaPrincipal = figure;
  set (ventanaPrincipal,"name","AMIC - Aproximación por Mí­nimos Cuadrados");
  set (ventanaPrincipal,"numbertitle","off");
  set (ventanaPrincipal,"color",[.5,.5,.5]);
  set (ventanaPrincipal,"menubar","none"); #barra de menu principal y herramientas desaparecen

  entornoPrincipal = uibuttongroup (ventanaPrincipal, "position", [ 0 0 1 1], ...
                 "title","Elija una opción", ...
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
               "string", "1,6,8,9", "position",[120,310,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  textoEjeY = uicontrol (entornoAproximar,"style","text", ...
               "string","Eje y :","position",[100,250,300,40], ... 
               "fontsize",16);  
  ejeY = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "6,8,9,7", "position",[120,210,290,40], ...
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
  
  botonFinalizar = uicontrol (entornoAproximar,"string","Finalizar", ...
                 "position",[25,50,200,40],"callback",{@cerrarVentana}, ...
                 "backgroundcolor",[.8,.8,.8]);  
endfunction


######                                                   
###   SELECCION METODOS   #####                      
#####  
function seleccionMetodos (handlesource,event,ejeX,ejeY,cantDecimales)
  ventanaSeleccionMetodos = figure;
  set (ventanaSeleccionMetodos,"name","Aproximación por mínimos cuadrados");
  set (ventanaSeleccionMetodos,"numbertitle","off");
  
  entornoSeleccionMetodos = uibuttongroup (ventanaSeleccionMetodos, "position", [ 0 0 1 1], ...
               "title","Elija el método de aproximación","titleposition","centertop");
               
               
  botonRecta = uicontrol (entornoSeleccionMetodos,"string"," Recta de mí­nimos cuadrados", ...
               "position",[150,350,250,30],"callback",...
                {@opcionesAproximacion,ejeX,ejeY,cantDecimales,1}, ...             
               "backgroundcolor",[.8,.8,.8]);
           
  botonParabola = uicontrol (entornoSeleccionMetodos,"string","Parábola de mínimos cuadrados", ...
               "position",[150,300,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,2}, ...
               "backgroundcolor",[.8,.8,.8]);

  botonExponencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Exponencial", ...
               "position",[150,250,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,3}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonPotencial = uicontrol (entornoSeleccionMetodos,"string","Aproximación Potencial", ...
               "position",[150,200,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,4}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonHiperbola = uicontrol (entornoSeleccionMetodos,"string","Aproximación Hipérbola", ...
               "position",[150,150,250,30],"callback",...
               {@opcionesAproximacion,ejeX,ejeY,cantDecimales,5}, ...
               "backgroundcolor",[.8,.8,.8]);
  
                   
  botonFinalizar = uicontrol (entornoSeleccionMetodos,"string","Finalizar", ...
                 "position",[25,25,150,30],"callback",{@cerrarVentana}, ...
                 "backgroundcolor",[.8,.8,.8]);             
endfunction


######                                                   
###   OPCIONES APROXIMACION   #####                      
##### 
function opcionesAproximacion (handlesource,event,ejeX,ejeY,cantDecimales,metodo)
  ventanaOpcionesAproximacion = figure;
  set (ventanaOpcionesAproximacion,"name","Aproximación por mínimos cuadrados");
  set (ventanaOpcionesAproximacion,"numbertitle","off");
  
  entornoOpcionesAproximacion = uibuttongroup (ventanaOpcionesAproximacion, "position", [ 0 0 1 1], ...
               "title","Seleccione la opción que desea realizar","titleposition","centertop");
               

  botonFuncion = uicontrol (entornoOpcionesAproximacion,"string","Mostrar función aproximante", ...
               "position",[150,250,250,30],"callback",...
               {@funcionAproximante,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonCalculo = uicontrol (entornoOpcionesAproximacion,"string","Obtener detalle del cálculo", ...
               "position",[150,200,250,30],"callback",...
               {@detalleCalculo,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
               
  botonGrafico = uicontrol (entornoOpcionesAproximacion,"string","Gráfico función y puntos", ...
               "position",[150,150,250,30],"callback",...
               {@grafico,ejeX,ejeY,cantDecimales,metodo}, ...
               "backgroundcolor",[.8,.8,.8]);
  
  botonFinalizar = uicontrol (entornoOpcionesAproximacion,"string","Finalizar", ...
                 "position",[25,25,150,30],"callback",{@cerrarVentana}, ...
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
               "title","Función Aproximante","titleposition","centertop");
               

  funcionAprox = uicontrol (entornoFuncionAproximante,"style","text", ...
               "string",funcionAproximanteVal,"position",[100,250,300,40], ... 
               "fontsize",16);
  
endfunction

######                                                   
###   FUNCION APROXIMACION RECTA   #####
##### 
 
function funcionAproxRecta(ejeX,ejeY,cantDecimales) 
 h=recta(ejeX,ejeY);

 helpdlg (strcat("y=",num2str(h(1),str2num(get(cantDecimales,"string"))),"x +",num2str(h(2),str2num(get(cantDecimales,"string")))),"Recta mínimo cuadrado");
     
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
  helpdlg (strcat("y=",num2str(h(1),str2num(get(cantDecimales,"string"))),"x^2 +",num2str(h(2),...
           str2num(get(cantDecimales,"string"))),"x  +  ",num2str(h(3),str2num(get(cantDecimales,"string")))),...
           "Parabola minimo cuadrado");
  
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

 helpdlg (strcat("y=",num2str(h(2),str2num(get(cantDecimales,"string"))),"e^",num2str(h(1),str2num(get(cantDecimales,"string"))),"x"),"Exponte de minimo cuadrado");
     
endfunction

######                                                   
###   FUNCION APROXIMACION POTENCIAL   #####                      
##### 

function funcionAproxPotencial(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

######                                                   
###   FUNCION APROXIMACION HIPERBOLA   #####                      
##### 

function funcionAproxHiperbola(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
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
               "title","Detalle cálculo","titleposition","centertop");
               
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
       "a *",num2str(sumX),"\t\t","+","\t","b *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))),"\n","b =",num2str(h(2),str2num(get(cantDecimales,"string"))),"\n",...
       num2str(h(1),str2num(get(cantDecimales,"string"))),"X + ",num2str(h(2),str2num(get(cantDecimales,"string"))),"\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo");
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
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))),"\n","b =",num2str(h(2),str2num(get(cantDecimales,"string"))),"\n","c =",num2str(h(3),str2num(get(cantDecimales,"string"))),"\n\n",...
       num2str(h(1),str2num(get(cantDecimales,"string"))),"X^2 + ",num2str(h(2),str2num(get(cantDecimales,"string"))),"X  + ",num2str(h(3),str2num(get(cantDecimales,"string"))),"\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo");
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
       "a *",num2str(sumX2),"\t","+","\t","b *",num2str(sumX),"\t","=","\t",num2str(sumXY),"\n\n",...
       "a *",num2str(sumX),"\t","+","\t","b *",num2str(cantidadPuntos),"\t","=","\t",num2str(sumY),"\n\n",...
       "Resolviendo el sistema queda\n\n","a =",num2str(h(1),str2num(get(cantDecimales,"string"))),"\n","b =",num2str(h(2),str2num(get(cantDecimales,"string"))),"\n",...
      "\nla aproximacion exponencial es\n", num2str(h(2),str2num(get(cantDecimales,"string"))),"e ^( ",num2str(h(1),str2num(get(cantDecimales,"string"))),"x )","\n");
       
  helpdlg (evalc ("str"),"Detalle del calculo");
endfunction

######                                                   
###   DETALLE CALCULO POTENCIAL   #####                      
##### 

function detalleCalculoPotencial(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
endfunction

######                                                   
###   DETALLE CALCULO HIPERBOLA   #####                      
##### 

function detalleCalculoHiperbola(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");  
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
  set (grafico,"name","Gráfica de la función");
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
  title('Recta de mínimos cuadrados')
  hold off
   
endfunction

######                                                   
###   GRAFICO PARABOLA   #####                      
##### 

function graficoParabola(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");

  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y
  
  P = polyfit(x, y, 2)
  a = P(1) 
  b = P(2) 
  c = P(3) 
  
  hold on 
  plot(x,y,'ro','markersize',4,'markerfacecolor','r') 
  
  plot(x, a*(x.^2)+b*x+c);
  xlabel('x')
  ylabel('y')
  grid on
  title('Parábola de mínimos cuadrados')
  hold off

endfunction

######                                                   
###   GRAFICO EXPONENCIAL   #####                      
##### 

function graficoExponencial(ejeX,ejeY,cantDecimales)
  
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  p = polyfit(x,log(y),1);
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  
  z = exp(p(2))*exp(x*p(1));
  plot(x, z);
  
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximación Exponencial')
  hold off
  
endfunction

######                                                   
###   GRAFICO POTENCIAL   #####                      
##### 

function graficoPotencial(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  p = polyfit(log10(x),log10(y),1);
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  
  z = (10^p(2))*x.^p(1);
  plot(x, z);
  
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximación Potencial')
  hold off

endfunction

######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 

function graficoHiperbola(ejeX,ejeY,cantDecimales)
  grafico = figure;
  set (grafico,"name","Gráfica de la función");
  set (grafico,"numbertitle","off");
  
  x = stringAArray (get (ejeX,"string")); %eje x
  y = stringAArray (get (ejeY,"string")); %eje y

  p = polyfit(1./x,1./y,1);
   
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')

  z = (1./p(1))./((p(2)*(1./p(1))) + x);
  plot(x, z);
  xlabel('x')
  ylabel('y')
  grid on
  title('Aproximación Hipérbola')
  hold off
  
endfunction


###################################################################################
#                          COMPARAR APROXIMACIONES                                #
###################################################################################
function abrirVentanaComAprox()
  
endfunction
###################################################################################
#                                   FINALIZAR                                     #
###################################################################################

function cerrarVentana()
  close all;  
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
