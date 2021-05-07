d_search(X,_):-
	df_search(X,_).
d_search(_,L):-
	collect_v([],L).

df_search(X,L):-
	asserta(vert(X)),
	edge(X,Y),
	\+(vert(Y)),
	df_search(Y,L).

collect_v(L,P):-
	retract(vert(X)),
	!,
	collect_v([X|L],P).
collect_v(L,L).




do_bfs(X, Path):-
	assertz(q(X)),
	asserta(vert(X)),
	bfs(Path).
bfs(Path):-
	q(X),
	!,
	expand(X),
	bfs(Path).
bfs(Path):-
	collect_v([],Path).

expand(X):-
	edge(X,Y),
	\+(vert(Y)),
	asserta(vert(Y)),
	assertz(q(Y)),
	fail.
expand(X):-
	retract(q(X)),
	!.


dist(Nod1,Nod2,Dist):-
	pos_vec(Nod1,X1,Y1,_),
	pos_vec(Nod2,X2,Y2,_),
	Dist is (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2).
order([Nod1|_],[Nod2|_]):-
	is_target(Target),
	dist(Nod1,Target,Dist1),
	dist(Nod2,Target,Dist2),
	Dist1<Dist2.

best([],[]):-!.
best([[Target|Rest]|_],[Target|Rest]):-
	is_target (Target),
	!.
best([[H|T]|Rest],Best):-
	pos_vec(H,_,_,Vec),
	expand(Vec,[H|T],Rest,Exp),
	q(Exp,SortExp,[]),
	best(SortExp,Best).

expand([],_,Exp,Exp):-!.
expand([E|R],Cale,Rest,Exp):-
	\+(member(E,Cale)),
	!,
	expand(R,Cale,[[E|Cale]|Rest],Exp).
expand([_|R],Cale,Rest,Exp):-
	expand(R,Cale,Rest,Exp).

partition(H,[A|X],[A|Y],Z):-
	order(A,H),
	!,
	partition(H,X,Y,Z).
partition(H,[A|X],Y,[A|Z]):-
	partition(H,X,Y,Z).
partition(_,[],[],[]).

q([H|T],S,R):-
	partition(H,T,A,B),
	q(A,S,[H|Y]),
	q(B,Y,R).
q([],S,S).











%--------------------------------------------------------------
