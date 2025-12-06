% BASE DE CONOCIMIENTO 
% curso(Nombre, Código, Créditos, Requisitos, Área, Nivel)

curso('Introduccion a la Programacion', 'PROG101', 4, [], 'programacion', 'inicial').
curso('Estructuras de Datos', 'PROG201', 4, ['PROG101'], 'programacion', 'intermedio').
curso('Algoritmos Avanzados', 'PROG301', 3, ['PROG201'], 'programacion', 'avanzado').
curso('Bases de Datos I', 'BDD101', 3, [], 'bases_datos', 'intermedio').
curso('Bases de Datos II', 'BDD201', 4, ['BDD101', 'PROG201'], 'bases_datos', 'avanzado').
curso('Redes de Computadoras', 'RED101', 4, ['PROG101'], 'redes', 'intermedio').
curso('Sistemas Operativos', 'SOF301', 3, ['PROG201'], 'sistemas', 'avanzado').
curso('Calculo Diferencial', 'MAT101', 3, [], 'matematicas', 'inicial').
curso('Probabilidad y Estadistica', 'MAT201', 3, ['MAT101'], 'matematicas', 'intermedio').


% 2. REGLAS LÓGICAS (MOTOR)

% --- Auxiliares de Requisitos ---
verifica_requisitos([], _).
verifica_requisitos([Req|Resto], CursosAprobados) :-
    member(Req, CursosAprobados),
    verifica_requisitos(Resto, CursosAprobados).

% puede_matricular(CodigoCurso, CursosAprobados)
puede_matricular(CodigoCurso, CursosAprobados) :-
    curso(_, CodigoCurso, _, Requisitos, _, _),
    verifica_requisitos(Requisitos, CursosAprobados),
    \+ member(CodigoCurso, CursosAprobados). % Excluye cursos ya en la lista de aprobados

% --- Consultas Generales ---
avanzado_sin_requisitos_pendientes(CodigoCurso, CursosAprobados) :-
    curso(_, CodigoCurso, _, _, _, 'avanzado'),
    puede_matricular(CodigoCurso, CursosAprobados).

creditos_totales([], 0).
creditos_totales([C|Resto], Total) :-
    curso(_, C, Creditos, _, _, _),
    creditos_totales(Resto, SubTotal),
    Total is Creditos + SubTotal.

combinacion_valida(CursosAprobados, Matricular, Creditos) :-
    findall(C, puede_matricular(C, CursosAprobados), CursosElegibles),
    sub_conjunto(Matricular, CursosElegibles),
    Matricular \= [],
    creditos_totales(Matricular, Creditos),
    Creditos =< 12.

sub_conjunto([], _).
sub_conjunto([H|T], Conjunto) :-
    select(H, Conjunto, RestoConjunto),  % Toma un elemento H de Conjunto
    sub_conjunto(T, RestoConjunto).


% Predicado auxiliar para obtener el último elemento de una lista 
last([X], X).
last([_|T], X) :- last(T, X).

% max_creditos_ruta(CursosAprobados, MaxCreditos, MejorRuta):
% Usa keysort/2 y last/2 para encontrar la combinación con mas créditos.
max_creditos_ruta(CursosAprobados, MaxCreditos, MejorRuta) :-
    % 1. Genera una lista de todas las soluciones válidas como pares (Creditos-Ruta).
    findall(Creditos-Ruta, combinacion_valida(CursosAprobados, Ruta, Creditos), RutasConCreditos),
    
    % 2. Si no hay rutas válidas, fallar.
    RutasConCreditos \= [], 
    
    % 3. Ordena la lista (keysort ordena por la 'clave', que son los créditos).
    keysort(RutasConCreditos, RutasOrdenadas), 
    
    % 4. El último elemento de la lista ordenada es el que tiene el MÁXIMO de créditos.
    last(RutasOrdenadas, MaxCreditos-MejorRuta).