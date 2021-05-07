%----------------------------------------------------------------------------

tree1(t(7, t(4, t(3, _, _), t(6, t(5, _, _), _)), t(11, _, _))).
%tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))). 
list1([1,2,3|_]).
list2([4,5,6|_]).


pretty_print(nil, _).
pretty_print(t(K,L,R), D):-
	D1 is D+1, 
	pretty_print(L, D1), 
	print_key(K, D),
	pretty_print(R, D1). 

print_key(K, D):-
	D>0, !, 
	D1 is D-1, 
	write('\t'), 
	print_key(K, D1).
print_key(K, _):-
	write(K), nl.

%----------------------------------------------------------------------------

%la astea incomplete trebuie sa vedem daca am ajuns la
%sfarsit... avem chestia aia cu pointerul la sfarsitul
%listei

member_il(_,L):- %daca am ajuns la ultimul element
	var(L),!,	%si nu am gasit ce am cautat, 
	fail.		%trebuie neaparat sa dam fail
member_il(X,[X|_]):-!. %ca la member1 oprim daca am gasit
member_il(X,[_|T]):-
	member_il(X,T). 

%----------------------------------------------------------------------------

insert_il(X,L):- %am ajuns la finalul listei, deci add element
	var(L),!,
	L=[X|_].	%putem sterge prima clauza pt ca merge si asa?
insert_il(X,[X|T]):-!.
insert_il(X,[_|T]):-
	insert_il(X,T).
	
%----------------------------------------------------------------------------

delete_il(_, L, L):-
	var(L), !. %reached end, stop
delete_il(X, [X|T], T):-!. %found element, remove it and stop
delete_il(X, [H|T], [H|R]):-
	delete_il(X, T, R). %search for the element
	
%----------------------------------------------------------------------------

search_it(_,T):- %fail if end of tree
	var(T),!,
	fail.
search_it(Key,t(Key,_,_)):-!. %found it so stop and return 1
search_it(Key,t(K,L,R)):-
	Key<K,!,
	search_it(Key,L).
search_it(Key,t(_,_,R)):-
	search_it(Key,R).

%----------------------------------------------------------------------------

insert_it(Key,t(Key,_,_)):-!.
insert_it(Key,t(K,L,R)):-
	Key<K,!,
	insert_it(Key,L).
insert_it(Key,t(K,L,R)):-
	insert_it(Key,R).

%----------------------------------------------------------------------------
	
delete_it(Key, T, T):-
	var(T), !, 
	write(Key), 
	write(' not in tree\n').
delete_it(Key, t(Key, L, R), L):-
	var(R), !.
delete_it(Key, t(Key, L, R), R):-
	var(L), !.
delete_it(Key, t(Key, L, R), t(Pred, NL, R)):-
	!, get_pred(L, Pred, NL).
delete_it(Key, t(K, L, R), t(K, NL, R)):-
	Key<K, !, 
	delete_it(Key, L, NL).
delete_it(Key, t(K, L, R), t(K, L, NR)):- 
	delete_it(Key, R, NR).

	
	
get_pred(t(Pred, L, R), Pred, L):-
	var(R), !.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-
	get_pred(R, Pred, NR).
	
%----------------------------------------------------------------------------

%append_il(L1,L2,Res)

append_il(L1,L2,R) :-
	var(L1),!,
	R=L2.
append_il([H|T],L2,[H|R]):-
	append_il(T,L2,R).
	
%----------------------------------------------------------------------------

reverse_il(L,_):-
	var(L),!.
reverse_il([H|T],Res):-
	reverse_il(T,R1),!,
	append_il(R1,[H|_],Res).

%----------------------------------------------------------------------------

transform_il(L1,R) :-
	var(L1),!,
	R=[].
transform_il([H|T],[H|R]):-
	transform_il(T,R).

%----------------------------------------------------------------------------

preorder_it(L, []):-
    var(L),!.
preorder_it(t(K,L,R), List):-
	preorder(L,LL), 
	preorder(R,LR),
	append([K|LL], LR, List).

%----------------------------------------------------------------------------

max(A, B, A):-
    A>B, !.
	max(_, B, B).

height(L, 0):-
    var(L),!.
height(t(_, L, R), H):-
    height(L, H1), 
    height(R, H2), 
    max(H1, H2, H3),
	H is H3+1. 

%----------------------------------------------------------------------------

toComplete(L):-
    var(L),!,
    L=nil.
toComplete(t(_,L,R)):-
	toComplete(L), 
	toComplete(R).

%----------------------------------------------------------------------------












%----------------------------------------------------------------------------
