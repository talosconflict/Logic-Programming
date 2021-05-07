dummy.

:-dynamic memo_fib/2.
fib(N,F):-
	memo_fib(N,F),!.
fib(N,F):-
	N>1,
	N1 is N-1,
	N2 is N-2,
	fib(N1,F1),
	fib(N2,F2),
	F is F1+F2,
	assertz(memo_fib(N,F)).
fib(0,1).
fib(1,1).

print_all:- 
	memo_fib(N,F),
	write(N),
	write('-'),
	write(F),
	nl,
	fail.
print_all.


perm(L, [H|R]):-
	append(A, [H|T], L), 
	append(A, T, L1), 
	perm(L1, R).
perm([], []).

all_perm(L,_):-
	perm(L,L1),
	assertz(p(L1)),
	fail.
all_perm(_,R):-
	collect_perms(R).
	
collect_perms([L1|R]):-
	retract(p(L1)),
	!,
	collect_perms(R).
collect_perms([]).



%-------------------------------------

% all_decompositions(List, Result).
all_decompositions(L,R):-
	findall([X,Y],append(X,Y,L),R).
	
%-------------------------------------
	
edge(a,b).
edge(b,c).
edge(c,d).
edge(e,f).
edge(e,g).
is_edge(A,B):-
	edge(A,B);
	edge(B,A).

%neighbor(a,[b,d]).
%neighbor(b,[a,c,d]).
%neighbor(c,[b,d]).

neighb_to_edge:-
	neighbor(Node,List),
	process(Node,List),
	fail.
neighb_to_edge.

process(Node,[H|T]):-
	assertz(edge(Node,H)),
	process(Node,T).
process(_,[]).

%simple path
path(X,Y,Path):-
	path(X,Y,[X],Path).
	
path(X,Y,PPath,FPath):-
	is_edge(X,Z),
	\+(member(Z,PPath)),
	path(Z,Y,[Z|PPath],FPath).
path(X,X,PPath,PPath).

%restricted path(Source,Target,RestrictionsList,Path)
restricted_path(X,Y,LR,P):-
	path(X,Y,P),
	check_restrictions(LR,P).

check_restrictions([],_):-!.
check_restrictions([H|T],[H|R]):-
	!,
	check_restrictions(T,R).
check_restrictions(T,[H|L]):-
	check_restrictions(T,L).


	
%optimal path (Source,Target,Path)

:-dynamic sol_part/2.

optimal_path(X,Y,_):-
	asserta(sol_part([],100)),
	path1(X,Y,[X],1).
optimal_path(_,_,Path):-
	retract(sol_part(Path,_)).

path1(X,X,Path,LPath):-
	retract(sol_part(_,_)),
	!,
	asserta(sol_part(Path,LPath)),
	fail.
path1(X,Y,PPath,LPath):-
	is_edge(X,Z),
	\+(member(Z,PPath)),
	LPath1 is LPath+1,
	sol_part(_,Lopt),
	LPath<Lopt,
	path1(Z,Y,[Z|PPath],LPath1).

	
	
hamilton(NN,X,Path):-
	NN1 is NN-1,
	hamilton_path(NN1,X,X,[X],Path).

hamilton_path(NN1,X,X,[X],Path)

%-------------------------------------

%build_neighbors(Node,NeighborList)
add_neighbor(Node,Res):-
	is_edge(Node,H),
	Res1 is Res,
	append([H],Res1,Res).
	
	
	
	
	
	
%--------------------------------------------------------------------------






























