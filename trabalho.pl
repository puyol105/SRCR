%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% RENATO JORGE CRUZINHA DA SILVA - A75310

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistema de Recomendação de Transporte Público

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).
%:- style_check(-singleton).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Carregamento das bibliotecas

%:- use_module( library( 'system' ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- op( 900,xfy,'e'  ).
:- op( 900,xfy,'ou' ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Meta predicados.

:- dynamic paragem/11. % Id, x,y, Estado( Bom/Razoavel/Mau ), Tipo , Publicidade, Operadora, Carreira, Cod_Rua, Nome_Rua, Freguesia
:- dynamic carreira/2. % Id, [Id_Paragens]


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento

:-include(carreira).
:-include(paragem). 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado insere: Termo -> {V,F}

insere(P) :- assert(P).
insere(P) :- retract(P), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado remove: Termo -> {V,F}

remove(P) :- retract(P).
remove(P) :- assert(P), !, fail.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado testa: Lista -> {V,F}

testa([]).
testa([X|R]) :- X, testa(R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado solucoes: Termo, Questão, Resultado -> {V,F}

solucoes(X,Y,Z) :- findall(X,Y,Z).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado solucoesSRep: Termo, Questão, Resultado -> {V,F}

solucoesSRep(X,Y,Z) :- setof(X,Y,Z). 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado evolucao: Termo -> {V,F}

evolucao(T) :-
	solucoes(I, +T :: I, S),
	insere(T),
	testa(S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado involucao: Termo -> {V,F}

involucao(T) :-
	solucoes(I, -T :: I, S),
	remove(T),
	testa(S).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado comprimento: Lista, Resultado -> {V,F}

comprimento(S,N) :- length(S,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :-
    Questao.
demo( Questao,falso ) :-
    -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demoComp: CompQuestao,Resposta -> {V,D,F}

demoComp(Q1 e Q2, R) :-
	demo(Q1,R1),
	demoComp(Q2,R2),
	conjuncao(R1,R2,R).
demoComp(Q1 ou Q2, R) :-
	demo(Q1,R1),
	demoComp(Q2,R2),
	disjuncao(R1,R2,R).
demoComp(Q, R) :-
	demo(Q,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado conjuncao: Resposta1, Resposta2, Resposta -> {V,D,F}

conjuncao(verdadeiro,verdadeiro,verdadeiro).
conjuncao(verdadeiro,falso,falso).
conjuncao(falso,verdadeiro,falso).
conjuncao(falso,falso,falso).
conjuncao(desconhecido,desconhecido,desconhecido).
conjuncao(desconhecido,verdadeiro,desconhecido).
conjuncao(verdadeiro,desconhecido,desconhecido).
conjuncao(desconhecido,falso,falso).
conjuncao(falso,desconhecido,falso).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado disjuncao: Resposta1, Resposta2, Resposta -> {V,D,F}

disjuncao(verdadeiro,verdadeiro,verdadeiro).
disjuncao(verdadeiro,falso,verdadeiro).
disjuncao(falso,verdadeiro,verdadeiro).
disjuncao(falso,falso,falso).
disjuncao(desconhecido,desconhecido,desconhecido).
disjuncao(desconhecido,verdadeiro,verdadeiro).
disjuncao(verdadeiro,desconhecido,verdadeiro).
disjuncao(desconhecido,falso,desconhecido).
disjuncao(falso,desconhecido,desconhecido).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%Extensão do predicado Coordenada: #Id, X, Y -> {V,F,D}

%coordenada(1, -99888.8, -105966.88).

%coordenada([...]).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão da negação forte do predicado coordenada

%-coordenada(Id,X,Y) :- 
%    nao(coordenada(Id,X,Y)), 
%    nao(excecao(coordenada(Id,X,Y)).

%importCSV :- csv_read_file('paragenscsv.csv', Data), 
%             print(Data).

