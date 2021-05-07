member1(X,[X|T]).
member1(X,[_|T]):-
	member1(X,T).

append2([],L,R):-
	R=L.
append2([H|T],L,[H|R]) :- 
	append2(T,L,R).

	
	1,2,3|[]
	4,5,6
	
	(1-2) T= 2,3|[]
	(2-2) T= 3|[]
	(3-2) T= []
	(4-1) R=4,5,6
	
	3: 
	
delete1(X,[X|T],T).
delete1(X,[H|T],[H|R]) :- 
	delete1(X,T,R).
delete1(_,[],[]).



%append3(L1,L2,L3,R).
append3([],[],[],[]).
append3(L1,L2,L3,R):-
	append2(L1,L2,L12), 
	append2(L12,L3,R).


	
%add @ beginning of list
%add1(X,[H|T],R).
add1([X],[],[X]).
add1(X,L,R):-
	append2([X],L,R).


%sumints([H|T],S).
sumints([],0).
sumints([H|T],S):-
	sumints(T,Sum1),
	S is H+Sum1.

%-------------------------------------------------------------------------------

modd(X,Y,R):- R is mod(X,Y).

%separate_parity([H|T],E,O).
separate_parity([H|T],[H|E],O):- %vezi notite cahier
	0 is H mod 2,
	separate_parity(T,E,O).
separate_parity([H|T],E,[H|O]):- 
	not(0 is H mod 2),
	separate_parity(T,E,O).
separate_parity([],[],[]).



%remove_duplicates([H|T],R)
remove_duplicates([H|T],R):- %daca e duplicat, nu il bagam la rezultat
	member1(H,T),!, %daca H e in T atunci oprim backtracking,
	remove_duplicates(T,R). %trecem la urmatorul element/urmatoarea lista fara H
remove_duplicates([H|T],[H|R]):- %aici daca nu e H in T atunci il adaugam pe H la R (rezultat)
	not(member1(H,T)),
	remove_duplicates(T,R). %oricum trecem la urmatorul pas
remove_duplicates([],[]).

	
	















