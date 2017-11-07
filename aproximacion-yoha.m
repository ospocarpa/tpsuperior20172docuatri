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
               "string","eje x:","position",[100,350,300,40], ... 
               "fontsize",16);
  ejeX = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "", "position",[120,310,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);              
               
  textoEjeY = uicontrol (entornoAproximar,"style","text", ...
               "string","Eje y :","position",[100,250,300,40], ... 
               "fontsize",16);  
  ejeY = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "", "position",[120,210,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  textoCantDecimales = uicontrol (entornoAproximar,"style","text", ...
               "string","Cantidad decimales:","position",[100,150,300,40], ... 
               "fontsize",16);
               
  cantDecimales = uicontrol (entornoAproximar, "style", "edit", ...
               "string", "6,1,9,3", "position",[120,110,290,40], ...
               "fontsize",14,"backgroundcolor",[.5,.5,.5]);
  
  botonSeleccionarMetodo = uicontrol (entornoAproximar,"string","Continuar", ...
               "position",[150,50,200,40],"callback",...
                {@seleccionMetodos,ejeX,ejeY,cantDecimales}, ...             
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
  
  botonPCG = uicontrol (entornoSeleccionMetodos,"string","Comparar Aproximaciones", ...
                   "position",[150,50,250,60],"callback",{@abrirVentanaComAprox}, ...
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

 helpdlg (strcat("y=",num2str(h(1)),"x +",num2str(h(2))),"Recta mínimo cuadrado");
     
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
 # funcionAproximante = ejeX;
  helpdlg (strcat("y=",num2str(h(1)),"x^2 +",num2str(h(2)),"x +",num2str(h(3))),"Parabola mínimo cuadrado");  
 # helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

function x = parabola(ejeX,ejeY)
  # sea ax+b en el vector se guarda a,b
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
  
  A = [sumX2,sumX,cantidadPuntos;sumx3,sumX2,sumX;sumx4,sumx3,sumX2];
  b = [sumY;sumXY;sumx2y];
  Ai = inv(A);
  x = Ai*b;
   
endfunction
######                                                   
###   FUNCION APROXIMACION EXPONENCIAL   #####                      
##### 

function funcionAproxExponencial(ejeX,ejeY,cantDecimales)
    
  funcionAproximante = ejeX;
    
  helpdlg (evalc ("funcionAproximante"),"Expresion de la funcion aproximante");
end

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
               "title","Detalle cÃ¡lculo","titleposition","centertop");
               
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
       "resolviendo el sistema queda\n\n","a =",num2str(h(1)),"\n","b =",num2str(h(2)),"\n",...
       num2str(h(1)),"X + ",num2str(h(2)),"\n");
       
  helpdlg (evalc ("str"),"detalle del calculo");
endfunction      


######                                                   
###   DETALLE CALCULO PARABOLA   #####                      
##### 

function detalleCalculoParabola(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
endfunction

######                                                   
###   DETALLE CALCULO EXPONENCIAL   #####                      
##### 

function detalleCalculoExponencial(ejeX,ejeY,cantDecimales)
  detalleCalculo = ejeX;
    
  helpdlg (evalc ("detalleCalculo"),"Detalle del cálculo");
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

  hold on 
  plot(x, y, 'o');
  P = polyfit(x, y, 1); 
  a = P(1); 
  b = P(2); 
  plot(x, a*x+b);
   
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

  hold on 
  plot(x, y, 'o'); 
  P = polyfit(x, y, 2)
  a = P(1) 
  b = P(2) 
  c = P(3) 
  plot(x, a*(x.^2)+b*x+c);

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

  p=polyfit(x,log(y),1);
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  z=@(x) exp(p(2))*exp(x*p(1));
  fplot(z,[x(1),x(end)])
  xlabel('x')
  ylabel('y')
  grid on
  title('Regresión exponencial')
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

  p=polyfit(log10(x),log10(y),1);
  fprintf('exponente a= %2.3f\n',p(1));
  fprintf('coeficiente c = %3.3f\n',(10^p(2)));
   
  hold on
  plot(x,y,'ro','markersize',4,'markerfacecolor','r')
  z=@(x) (10^p(2))*x.^p(1);
  fplot(z,[x(1),x(end)])
  xlabel('x')
  ylabel('y')
  grid on
  title('Regresión potencial')
  hold off

endfunction

######                                                   
###   GRAFICO HIPERBOLA   #####                      
##### 

function graficoHiperbola(ejeX,ejeY,cantDecimales)
  
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
  close;  
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

             
