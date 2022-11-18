%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- dynamic utente/4.
:- dynamic ato/7.
:- dynamic maracdor/6.
:- dynamic '-'/1.
:- op( 900,xfy,'::').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado utente: Idutente, Nome, Data, Sexo -> {V,F,D}

utente(u00,franciscapereira,'11/01/2001',fem).
utente(u01,rubenganaca,'06/11/2002',masc).
utente(u02,sarafernandes,'13/03/2002',fem).
utente(u03,sofiaribas,'05/08/2002',fem).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado ato: Idato, RegData, Idutente, Idade, Colesterol, Pulsacao, Pressao -> {V,F,D}

ato(a00,'13/11/2022',u00,21,140,90,'70/130').
ato(a01,'15/11/2022',u01,20,170,87,'65/115').
ato(a02,'13/11/2022',u02,20,210,80,'62/120').
ato(a03,'06/04/2021',u03,20,150,110,'78/146').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado marcador: Idmarcador, Analise, Idade, Sexo, Minimo, Maximo -> {V,F,D}

marcador(ctm01,colesterol,'18/30',masc,0,170).
marcador(ctf02,colesterol,'18/30',fem,0,160).
marcador(ctm03,colesterol,'31/45',masc,0,190).
marcador(ctf04,colesterol,'31/45',fem,0,180).
marcador(psm05,pulsacao,'18/25',masc,60,80).
marcador(psf06,pulsacao,'18/25',fem,61,65).
marcador(psm07,pulsacao,'26/35',masc,55,61).
marcador(psf08,pulsacao,'26/35',fem,60,64).
marcador(prm09,pressao,'18/25',masc,79,120).
marcador(prf10,pressao,'18/25',fem,79,120).
marcador(prm11,pressao,'26/30',masc,80,121).
marcador(prf12,pressao,'26/30',fem,80,120).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predeicado -utente: Idutente, Nome, Data, Sexo -> {V,F,D}

-utente(U,N,D,S):-
    nao(utente(U,N,D,S)),
    excecao(utente(U,N,D,S)).
utente:-excecao(utente(U,N,D,S)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado -ato: Idato, RegData, Idutente, Idade, Colesterol, Pulsacao, Pressao -> {V,F,D}

-ato(A,D,U,I,C,PS,PR):-
    nao(ato(A,D,U,I,C,PS,PR)),
    excecao(ato(A,D,U,I,C,PS,PR)).
ato:-excecao(ato(A,D,U,I,C,PS,PR)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado -marcador: Idmarcador, Analise, Idade, Sexo, Minimo, Maximo -> {V,F,D}

-marcador(M,A,I,S,Mi,Ma):-
    nao(marcador(M,A,I,S,Mi,Ma)),
    excecao(marcador(M,A,I,S,Mi,Ma)).

marcador:-excecao(marcador(M,A,I,S,Mi,Ma)).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicados Auxiliares
%--------------------------------- - - - - - - - - - -  -  -  -  -   -


% Extensão do predicado que permite a evolucao do conhecimento

evolucao(Termo) :-
        findall(Invariante, +Termo::Invariante,Lista),
        insercao(Termo),
        teste(Lista).

insercao(Termo) :- assert(Termo).
insercao(Termo) :- retract(Termo), !,fail.

teste([]).
teste([Invariante|Lista]) :- Invariante, teste(Lista).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a involucao do conhecimento

involucao(Termo):- 
        findall(Invariante, -Termo::Invariante, Lista),
        remocao(Termo),
        teste(Lista).

remocao(Termo) :- retract(Termo).
remocao(Termo) :- assert(Termo), !, fail.

teste([]).
teste([Invariante|Lista]):- Invariante, teste(Lista).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Sistema de Inferencia
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao(Questao) :-
    Questao, !, fail.
nao(Questao).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado si: Questao,Resposta -> {V,F}

si(Questao,verdadeiro) :-
    Questao.
si(Questao,falso) :-
    -Questao.
si(Questao,desconhecido) :-
    nao(Questao),
    nao(-Questao).