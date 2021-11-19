%==================================================================
% García Tello Axel
%
% Tarea 5. Solución de Laberinto...
% Construya un programa en Prolog para resolver el pequeño laberinto
% en la lámina #33 de la presentación #17
% De forma mínima, debe poder calcula las rutas para navegar desde
% la región exterior, hasta la region donde se encuentra el rombo
% rojo...
% En el mismo archivo fuente, construya predicados para resolver, a
% lo profundo, a lo ancho y estilo A*...
%
% Predicados relevantes:
%   bus_pro(<Estado>,<Ruta solución>)
%   dls(<Ruta recorrida>,<Estado>,<Profundidad>,<Ruta solución>)
%   bus_din(<Estado>,<Ruta solución>)
%   bus_anc(<Estado>,<Ruta solución>)
%   bus_a(<Estado>,<Ruta solución>)
%==================================================================

%==================================================================
% Base de conocimiento
%
% puerta/2.
% Identifica la conexión entre los cuartos.
%==================================================================

puerta(a,g).
puerta(a,j).
puerta(a,r).
puerta(a,s).
puerta(b,h).
puerta(b,u).
puerta(c,d).
puerta(c,k).
puerta(e,f).
puerta(e,k).
puerta(f,i).
puerta(h,j).
puerta(i,l).
puerta(i,t).
puerta(l,m).
puerta(m,q).
puerta(n,o).
puerta(o,p).
puerta(p,s).
puerta(q,r).
puerta(t,u).

%==================================================================
% localizacion/3.
% Ubica la ubicación del cuarto en un plano cartesiano emṕezando por
% la parte supeior izquierda del mapa.
% El primer parámetro es la etiqueta el cuarto.
% El segundo parámetro es la coordenada X.
% El tercer parámetro es la coordenada Y.
%==================================================================

localizacion(a,2,2).
localizacion(a,2,3).
localizacion(a,2,4).
localizacion(a,2,5).
localizacion(a,2,6).
localizacion(a,2,7).
localizacion(a,2,8).
localizacion(a,2,9).

localizacion(b,3,2).
localizacion(b,4,2).

localizacion(c,5,2).
localizacion(c,5,3).

localizacion(d,6,2).
localizacion(d,6,3).

localizacion(e,7,2).
localizacion(e,7,3).

localizacion(f,8,2).
localizacion(f,8,3).
localizacion(f,9,2).

localizacion(g,3,3).

localizacion(h,4,3).
localizacion(h,4,4).
localizacion(h,4,5).

localizacion(i,9,3).
localizacion(i,9,4).
localizacion(i,9,5).
localizacion(i,9,6).
localizacion(i,9,7).
localizacion(i,9,8).

localizacion(j,3,4).
localizacion(j,3,5).

localizacion(k,5,4).
localizacion(k,6,4).
localizacion(k,7,4).
localizacion(k,8,4).

localizacion(l,5,5).
localizacion(l,6,5).
localizacion(l,7,5).
localizacion(l,8,5).

localizacion(m,3,6).
localizacion(m,4,6).
localizacion(m,5,6).

localizacion(n,6,6).

localizacion(o,7,6).
localizacion(o,6,7).
localizacion(o,7,7).

localizacion(p,8,6).
localizacion(p,8,7).
localizacion(p,8,8).
localizacion(p,7,8).

localizacion(q,3,7).
localizacion(q,4,7).
localizacion(q,5,7).

localizacion(r,3,8).
localizacion(r,4,8).
localizacion(r,5,8).
localizacion(r,6,8).

localizacion(s,3,9).
localizacion(s,4,9).
localizacion(s,5,9).
localizacion(s,6,9).
localizacion(s,7,9).

localizacion(t,8,9).
localizacion(t,9,9).

localizacion(u,1,1).
localizacion(u,2,1).
localizacion(u,3,1).
localizacion(u,4,1).
localizacion(u,5,1).
localizacion(u,6,1).
localizacion(u,7,1).
localizacion(u,8,1).
localizacion(u,9,1).
localizacion(u,10,1).

localizacion(u,1,2).
localizacion(u,1,3).
localizacion(u,1,4).
localizacion(u,1,5).
localizacion(u,1,6).
localizacion(u,1,7).
localizacion(u,1,8).
localizacion(u,1,9).

localizacion(u,10,2).
localizacion(u,10,3).
localizacion(u,10,4).
localizacion(u,10,5).
localizacion(u,10,6).
localizacion(u,10,7).
localizacion(u,10,8).
localizacion(u,10,9).

localizacion(u,1,10).
localizacion(u,2,10).
localizacion(u,3,10).
localizacion(u,4,10).
localizacion(u,5,10).
localizacion(u,6,10).
localizacion(u,7,10).
localizacion(u,8,10).
localizacion(u,9,10).
localizacion(u,10,10).

%==================================================================
% edo_inicial/1.
% Identifica el estado inicial.
%
% edo_meta/1.
% Identifica el estado al que se quiere llegar.
%
% dynamic/1.
% Permite que una función o sentencia pueda ser editada dentro de
% la terminal de Prolog.
%==================================================================

edo_inicial(u).
edo_meta(n).

:- dynamic(edo_inicial/1).
:- dynamic(edo_meta/1).

%==================================================================
% acceso/2.
% Permite identificar la conexión entre las habitaciones en ambas
% direcciones.
%==================================================================

acceso(A1,A2):- puerta(A1,A2) ; puerta(A2,A1).

%==================================================================
% dfs/3.
% Búsqueda a lo profundo.
% Permite realizar la búsqueda en el grafo siguiendo una sola
% ramificación hasta llega a su ultimo nodo, que puede ser el
% resultado o no. Continua con la siguiente ramificación hasta
% terminar con las ramificaciones.
% El primer parámetro es la ruta analizada, el segundo el estado
% actual y el tercero es la ruta solución.
%==================================================================

dfs([A|Ruta],E,[E,A|Ruta]):- edo_meta(E).
dfs(Ruta,Edo,Sol):- acceso(Edo,E),
                    \+ member(E,Ruta),
                    dfs([Edo|Ruta],E,Sol).

%==================================================================
% bus_pro/2.
% Manda a llamar a la función dfs/3 para ejecutar la búsqueda a lo
% profundo.
% El primer parámetro es el estado inicial y el segundo es la
% solución.
%==================================================================

bus_pro(Edo,Sol):- dfs([],Edo,S),
                   reverse(S,Sol).

%==================================================================
% dls/4.
% Búsqueda a lo profundo con limite de profundidad.
% Nos permite implementar una búsqueda a lo profundo pero con un
% limite en la profundidad de la ramificación.
% El primer parámetro es la ruta recorrida, el segundo el estado
% analizado, el tercero el limite de profundidad y el cuarto el
% resultado.
%==================================================================

dls([A|Ruta],E,_,[E,A|Ruta]):- edo_meta(E).
dls(Ruta,Edo,Max,Sol):- Max > 0,
                        acceso(Edo,E),
                        \+ member(E,Ruta),
                        Max2 is Max-1,
                        dls([Edo|Ruta],E,Max2,Sol).

%==================================================================
% ruta/3.
% Nos permite trazar la ruta entre un nodo a otro.
% El primer parámetro es el nodo de partida, el segundo el nodo de
% llegada y el tercero es la ruta usada.
% las rutas encontradas estan ordenadas por tamaño.
%==================================================================

ruta(E,E,[E]).
ruta(E1,E2,[E2|Ruta]):- ruta(E1,E,Ruta),
                        acceso(E,E2),
                        \+ member(E2,Ruta).

%==================================================================
% bus_din/2.
% Búsqueda a lo profundo con limite de profundidad dinámico.
% Con la ayuda de la función ruta/3. nos realiza una búsqueda a
% lo profundo. Como los resultados son ordenados, el usuario puede
% decidir la profundidad del resultado al que desea llegar.
%==================================================================

bus_din(Edo,Sol):- edo_meta(Meta),
                   ruta(Edo,Meta,S),
                   reverse(S,Sol).

%==================================================================
% extend/2.
% Dada una lista con la ruta, nos permite extender las posibles
% rutas a seguir desde el último estado en que se encuentra.
% El primer parámetro es la ruta trazada y el segundo las nuevas
% posibles rutas.
%==================================================================

extend([Edo|Trayecto],NuevasRutas):- findall(
                                        [E,Edo|Trayecto],
                                        (
                                            acceso(Edo,E),
                                            \+ member(E,[Edo|Trayecto])
                                        ),
                                        NuevasRutas
                                     ).

%==================================================================
% bfs/2.
% Búsqueda a lo ancho.
% Permite realizar la búsqueda de un grafo analizando nos nodos
% por nivel de profundidad.
% El primer parámetro es una lista de rutas seguidas y el segundo
% es la ruta solución.
%==================================================================

bfs([[Edo|Resto]|_],[Edo|Resto]):- edo_meta(Edo).
bfs([Ruta|Rutas],Sol):- extend(Ruta,Nuevas),
                        append(Rutas,Nuevas,Rutas2),
                        bfs(Rutas2,Sol).

%==================================================================
% bus_anc/2.
% Manda a llamar a la función bfs/2 para ejecutar la búsqueda a lo
% ancho.
% El primer parámetro es el estado inicial y el segundo la ruta
% trazada hasta el estado meta.
%==================================================================

bus_anc(Edo,Sol):- bfs([[Edo]],S),
                   reverse(S,Sol).

%==================================================================
% subh/2.
% Determina la distancia Manhattan entre un punto (estado) en el
% laberinto y el estado meta.
% El primer parámetro es el estado y el segundo es la distancia
% Manhattan calculada.
%==================================================================

subh(Edo,H):- localizacion(Edo,X1,Y1),
              edo_meta(M),
              localizacion(M,X2,Y2),
              H is abs(X1-X2) + abs(Y1-Y2).

%==================================================================
% min/2.
% Dada una lista, nos devuelve el menor valor de esta.
%==================================================================

min([X],X).
min([X,Y|Resto],Z):- X =< Y, min([X|Resto],Z);
                     Y < X, min([Y|Resto],Z).

%==================================================================
% h/2.
% Con la ayuda de h, determina todas las distancias Manhattan
% desde un estado a el estado Meta y nos devuelve la menor
% distancia.
% Recordemos que un estado puede abarcar varios puntos de
% localización.
% El primer parámetro es el estado y el segundo es la menor
% distancia Manhattan.
%==================================================================

h(Edo,H):- findall(Valor,subh(Edo,Valor),Lista),
           min(Lista,H).

%==================================================================
% aptitud/3.
% La aptitud tomada es la distancia recorrida hasta llega a nuestro
% estado señalado más su distancia Manhattan hasta el estado meta.
% El primer parámetro es el estado actual, el segundo es el costo
% o distancia recorrida y el tercero es el resultado de aptitud.
%==================================================================

aptitud(Edo,Costo,Aptitud):- h(Edo,H),
                             Aptitud is H + Costo.

%==================================================================
% size/2.
% Dada una lista, nos devuelve su tamaño.
%==================================================================

size([],0).
size([_|Y],N):- size(Y,N1),
                N is N1+1.

%==================================================================
% col_apt/2.
% Estamos trabajando con una estructura de tipo [Ruta]-Aptitud
% por lo que dada una lista de rutas colocamos su aptitud a cada
% una de ellas.
% El primer parámetro es la lista de rutas y el segundo la lista
% de rutas con aptitudes.
%==================================================================

col_apt([],[]).
col_apt([[E|Resto]],[[E|Resto]-Apt]):- size([E|Resto],Costo),
                                       aptitud(E,Costo,Apt).
col_apt([[E|Resto]|Lista],[[E|Resto]-Apt|Sol]):- size([E|Resto],Costo),
                                                 aptitud(E,Costo,Apt),
                                                 col_apt(Lista,Sol).

%==================================================================
% insert/3.
% Dada una nueva ruta y nuestra agenda, esta función agrega nuestra
% ruta en la agenda de forma ordenada dependiendo de su aptitud.
% El primer parámetro es la ruta con la estructura [Ruta]-Aptitud,
% el segundo es la agenda y el tercero es la agenda con la nueva
% ruta incluida.
%==================================================================

insert(N-A1,[],[N-A1]).
insert(N-A1,[X-A2|Rest],[N-A1,X-A2|Rest]):- A1 =< A2,!.
insert(N-A1,[X-A2|Rest1],[X-A2|Rest2]):- insert(N-A1,Rest1,Rest2).

%==================================================================
% sort_agenda/3.
% Si lo que queremos agregar a nuestra agenda es toda una lista de
% rutas, esta función con la ayuda de la función insert/3 lo hace.
% El primer parámetro son las nuevas rutas, el segundo la agenda
% y el tercero es la agenda con las nuevas rutas.
%==================================================================

sort_agenda([],NuevaAgenda,NuevaAgenda).
sort_agenda([Edo|Resto],Agenda,Ord):- insert(Edo,Agenda,NAgenda),
                                      sort_agenda(Resto,NAgenda,Ord).

%==================================================================
% a_star/2.
% Búsqueda A*.
% Implementa una busqueda A* dirigiendose hacia el nodo con mejor
% aptitud.
% El primer parámetro es la lista de rutas con sus aptitudes y el
% segundo es la ruta que llega al estado meta.
%==================================================================

a_star([[Edo|Lista]-_|_],[Edo|Lista]):- edo_meta(Edo).
a_star([[Edo|Lista]-_|Resto],Sol):- extend([Edo|Lista],Suc),
                                    col_apt(Suc,Nsuc),
                                    sort_agenda(Nsuc,Resto,Agenda),!,
                                    a_star(Agenda,Sol).

%==================================================================
% bus_a/2.
% Manda a llamar a la función a_star/2 para ejecutar la búsqueda
% A*.
% El primer parametro es el estdo inicial y el segundo la ruta
% solución al estado meta.
%==================================================================

bus_a(Edo,Sol):- aptitud(Edo,1,A),
                 a_star([[Edo]-A],S),
                 reverse(S,Sol).
