

%-------------------------------------------------------------------------

depth([],1).
depth([H|T],R):-
	atomic(H),!,
	depth(T,R).
depth([H|T],R):- 
	depth(H,R1), 
	depth(T,R2), 
	R3 is R1+1,
	R is max(R3,R2).
	
%-------------------------------------------------------------------------

flatten([],[]).
flatten([H|T], [H|R]) :- 
	atomic(H),!, 
	flatten(T,R).
flatten([H|T], R) :- 
	flatten(H,R1), 
	flatten(T,R2),
	append(R1,R2,R).

%-------------------------------------------------------------------------

heads3([],[],_).
heads3([H|T],[H|R],1):-
	atomic(H),!,
	heads3(T,R,0).
heads3([H|T],R,0):-
	atomic(H),!,
	heads3(T,R,0).
heads3([H|T],R,_):-
	heads3(H,R1,1),
	heads3(T,R2,0),
	append(R1,R2,R).
	
headsp(L,R) :- heads3(L, R,1).

%-------------------------------------------------------------------------

member1(H,[H|_]).
member1(X,[H|_]):-
	member1(X,H).
member1(X,[_|T]):-
	member1(X,T).

%-------------------------------------------------------------------------
 %nr of atomic elements in list

nrAtomic([],0).
nrAtomic([H|T],L):-
	atomic(H),!,
	nrAtomic(T,L1),
	L is L1+1.
nrAtomic([H|T],L):-
	nrAtomic(H,L1),
	nrAtomic(T,L2),
	L is L1+L2.

%-------------------------------------------------------------------------

sumAtomic([],0).
sumAtomic([H|T],L):-
	atomic(H),!,
	sumAtomic(T,L1),
	L is L1+H.
sumAtomic([H|T],L):-
	sumAtomic(H,L1),
	sumAtomic(T,L2),
	L is L1+L2.

%-------------------------------------------------------------------------

getLastAtomic([],0).
getLastAtomic([H],[H]):-
	atomic(H),!.
getLastAtomic([H|T],R):-
	atomic(H),!,
	getLastAtomic(T,R).
getLastAtomic([H|T],R):-
	getLastAtomic(H,R1),
	getLastAtomic(T,R2),
	append(R1,R2,R).
	
%-------------------------------------------------------------------------

formList([],[],[]).
formList(L,[],L).
formList([],L,L).
formList(L1,L2,[L1,L2]).

replaceDeepList(_,_,[],[]).
replaceDeepList(Old,New,[Old|T],[New|R]):-
	replaceDeepList(Old,New,T,R).
replaceDeepList(Old,New,[H|T],[H|R]):-
	atomic(H),!,
	replaceDeepList(Old,New,T,R).
replaceDeepList(Old,New,[H|T],[R1|R2]:-
	replaceDeepList(Old,New,H,R1),
	replaceDeepList(Old,New,T,R2),!.












%-------------------------------------------------------------------------
