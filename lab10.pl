neighbor(a, [b, d]). % an example graph – 1st connected component of the
neighbor(b, [a, c, d]). % example graph
neighbor(c, [b, d]).

neighb_to_edge:-
	neighbor(Node,List),
	process(Node,List),
	fail.
neighb_to_edge.

process(Node, [H|T]):-
	assertz(edge(Node, H)),
	process(Node, T).
process(_, []).

is_edge(X,Y):-
	edge(X,Y);
	edge(Y,X).

%----------------------------------------------------------------------------------------------------------------------------

% path(Source, Target, Path)
path(X,Y,Path):- %wrapper
	path(X,Y,[X],Path).

path(X,Y,PPath, FPath):-
	is_edge(X,Z),
	\+(member(Z, PPath)),
	path(Z, Y, [Z|PPath], FPath).
path(X,X,PPath, PPath).

%----------------------------------------------------------------------------------------------------------------------------

% restricted_path(Source, Target, RestrictionsList, Path)
% check_restrictions(RestrictionsList, Path)
restricted_path(X,Y,LR,P):-
	path(X,Y,P),
	check_restrictions(LR, P).
check_restrictions([],_):- !.
check_restrictions([H|T], [H|R]):-
	!,
	check_restrictions(T,R).
check_restrictions(T, [H|L]):-
	check_restrictions(T,L).

%----------------------------------------------------------------------------------------------------------------------------

optimal_path(X,Y,_):-
	asserta(sol_part([],100)),
	path(X,Y,[X],1).
optimal_path(_,_,Path):-
	retract(sol_part(Path,_)).

path(X,X,Path,LPath):-
	retract(sol_part(_,_)),!,
	asserta(sol_part(Path,LPath)),
	fail.
path(X,Y,PPath,LPath):-
	is_edge(X,Z),
	\+(member(Z,PPath)),
	LPath1 is LPath+1,
	sol_part(_,Lopt),
	LPath1<Lopt,
	path(Z,Y,[Z|PPath],LPath1).

%----------------------------------------------------------------------------------------------------------------------------

hamilton(NN, X, Path):-
	NN1 is NN-1,
	hamilton_path(NN1,X, X, [X],Path).
