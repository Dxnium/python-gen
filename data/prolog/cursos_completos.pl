% BASE DE CONOCIMIENTO 
% curso(Nombre, Código, Créditos, Requisitos, Área, Nivel)

% ----- 1er Cuatrimestre -----
curso('Estructuras Discretas', 'SOF-01', 4, [], 'software', 'inicial').
curso('Ingles para las Tecnologias I', 'SOF-02', 4, [], 'software', 'inicial').
curso('Introduccion a la Computacion', 'SOF-03', 4, [], 'software', 'inicial').
curso('Tecnicas de Comunicacion', 'SOF-04', 4, [], 'software', 'incial').

% ----- 2do Cuatrimestre -----
curso('Calculo I', 'SOF-05', 4, [], 'software', 'intermedio').
curso('Ingles para las Tecnologias II', 'SOF-06', 4, ['SOF-01'], 'software', 'intermedio').
curso('Investigacion Aplicada a las Tecnologias', 'SOF-07', 4, ['SOF-04'], 'software', 'intermedio').
curso('Programacion I', 'SOF-08', 4, ['SOF-03'], 'software', 'intermedio').

% ----- 3er Cuatrimestre -----
curso('Calculo II', 'SOF-09', 4, ['SOF-05'], 'software', 'intermedio').
curso('Estructuras de Datos y Algoritmos', 'SOF-10', 4, ['SOF-02','SOF-08'], 'software', 'intermedio').
curso('Probabilidad y Estadistica', 'SOF-11', 4, ['SOF-05'], 'software', 'intermedio').
curso('Programacion II', 'SOF-12', 4, ['SOF-08'], 'software', 'intermedio').

% ----- 4to Cuatrimestre -----
curso('Arquitectura y Organizacion de Computadores', 'SOF-13', 4, ['SOF-10','SOF-12'], 'software', 'intermedio').
curso('Base de Datos I', 'SOF-14', 4, ['SOF-10','SOF-12'], 'software', 'intermedio').
curso('Programacion III', 'SOF-16', 4, ['SOF-10','SOF-12'], 'software', 'intermedio').
curso('Verificacion y Validacion de Software', 'SOF-15', 4, ['SOF-08','SOF-10'], 'software', 'intermedio').

% ----- 5to Cuatrimestre -----
curso('Analisis y Especificacion de Software', 'SOF-19', 4, ['SOF-14'], 'software', 'avanzado').
curso('Base de Datos II', 'SOF-17', 4, ['SOF-14'], 'software', 'avanzado').
curso('Programacion IV', 'SOF-18', 4, ['SOF-16','SOF-17'], 'software', 'avanzado').
curso('Sistemas Operativos', 'SOF-20', 4, ['SOF-09','SOF-13'], 'software', 'avanzado').

% ----- 6to Cuatrimestre -----
curso('Calidad de Software', 'SOF-25', 4, ['SOF-18','SOF-19'], 'software', 'avanzado').
curso('Diseno de Software', 'SOF-24', 4, ['SOF-19'], 'software', 'avanzado').
curso('Lenguajes y Paradigmas de Programacion', 'SOF-23', 4, ['SOF-19'], 'software', 'avanzado').
curso('Redes de Computadoras', 'SOF-21', 4, ['SOF-16','SOF-17'], 'software', 'avanzado').

% ----- 7mo Cuatrimestre -----
curso('Diseno de la Interaccion Humano-Computadora', 'SOF-26', 4, ['SOF-24'], 'software', 'avanzado').
curso('Investigacion de Operaciones', 'SOF-22', 4, ['SOF-09','SOF-11'], 'software', 'avanzado').
curso('Procesos de Ingenieria de Software', 'SOF-28', 4, ['SOF-25'], 'software', 'avanzado').
curso('Topicos Avanzados de Programacion', 'SOF-27', 4, ['SOF-23'], 'software', 'avanzado').

% ----- 8vo Cuatrimestre (avanzado) -----
curso('Administracion de Proyectos Informaticos', 'SOF-33', 4, ['SOF-29'], 'software', 'avanzado').
curso('Arquitectura de Software', 'SOF-30', 4, ['SOF-29'], 'software', 'avanzado').
curso('Electiva 1', 'SOF-32', 4, ['SOF-27'], 'software', 'avanzado').
curso('Inteligencia Artificial Aplicada', 'SOF-31', 4, ['SOF-29'], 'software', 'avanzado').
curso('Taller Integracion de Graduacion', 'TGINF1-N', 4, [], 'software', 'avanzado').

% ----- 9no Cuatrimestre (avanzado) -----
curso('Computacion y Sociedad', 'SOF-34', 4, ['SOF-33'], 'software', 'avanzado').
curso('Electiva 2', 'SOF-35', 4, ['SOF-30'], 'software', 'avanzado').
curso('Implementacion y Mantenimiento de Software', 'SOF-36', 4, ['SOF-25','SOF-30'], 'software', 'avanzado').
curso('Proyecto de Graduacion', 'PROYSOF01-N', 4, [], 'software', 'avanzado').
curso('Seguridad Informatica', 'SOF-37', 4, ['SOF-29'], 'software', 'avanzado').

% ----- Electiva 1 (avanzado - seleccionar una) -----
curso('Electiva 1: Administracion del Riesgo y Continuidad del Negocio', 'SOF-32-1', 4, ['SOF-27'], 'software', 'avanzado').
curso('Electiva 1: Emprendedurismo e Innovacion Corporativa', 'SOF-32-2', 4, ['SOF-27'], 'software', 'avanzado').
curso('Electiva 1: Recuperacion de la Informacion', 'SOF-32-3', 4, ['SOF-27'], 'software', 'avanzado').

% ----- Electiva 2 (avanzado - seleccionar una) -----
curso('Electiva 2: Auditoria de Sistemas Computacionales', 'SOF-35-1', 4, ['SOF-30'], 'software', 'avanzado').
curso('Electiva 2: Herramientas para el Desarrollo de Sistemas de Informacion', 'SOF-35-2', 4, ['SOF-30'], 'software', 'avanzado').
curso('Electiva 2: Programacion Grafica de Videojuegos', 'SOF-35-3', 4, ['SOF-30'], 'software', 'avanzado').


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