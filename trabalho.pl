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

:- dynamic paragem/11. % Id, X, Y, Estado, Tipo, Publicidade, Operadora, [Carreira], Cod_Rua, Nome_Rua, [Freguesia]
:- dynamic carreira/2. % Id, [Id_Paragens]

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de conhecimento

:-include(carreira).
:-include(paragem). 

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Responder a Querys

% Auxiliares
hacarreira(X) :- carreiras(L), member(X,L).



% 1 - Calcular um trajeto entre dois pontos;

hatrajeto(A,B) :- carreiras(L),
				  foreach(L).


hatrajetoaux(A,B,X) :- hacarreira(X),
					   existe(A,X),
					   existe(B,X).




existe(A,X) :- carreira(X,L), member(A,L).



% 2 - Selecionar apenas algumas das operadoras de transporte para um determinado percurso;

% 3 - Excluir um ou mais operadores de transporte para o percurso;

% 4 - Identificar quais as paragens com o maior número de carreiras num determinado percurso.

% 5 - Escolher o menor percurso (usando critério menor número de paragens);

% 6 - Escolher o percurso mais rápido (usando critério da distância);

% 7 - Escolher o percurso que passe apenas por abrigos com publicidade;

% 8 - Escolher o percurso que passe apenas por paragens abrigadas;

% 9 - Escolher um ou mais pontos intermédios por onde o percurso deverá passar;
