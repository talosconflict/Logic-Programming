%----------------------------------------------------------------------------------------------
tree1(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))).
tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))). 




%----------------------------------------------------------------------------------------------
 %tree traversal
 
inorder(t(K,L,R),List):-
	inorder(L,LL),
	inorder(R,LR),
	append(LL,[K|LR],List).
inorder(nil,[]).

preorder(t(K,L,R), List):-
	preorder(L,LL), 
	preorder(R,LR),
	append([K|LL], LR, List).
preorder(nil, []). 

postorder(t(K,L,R), List):-
	postorder(L,LL), 
	postorder(R,LR),
	append(LL,LR,R1), 
	append(R1,[K],List).
postorder(nil,[]).

%----------------------------------------------------------------------------------------------

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

%----------------------------------------------------------------------------------------------

search_key(Key, t(Key,_,_)):- !.
search_key(Key, t(K,L,_)):-
	Key<K, !,
	search_key(Key,L).
search_key(Key, t(_, _, R)):-
	search_key(Key, R). 
	
%----------------------------------------------------------------------------------------------

insert_key(Key, nil, t(Key, nil, nil)):-
	write('Inserted '), 
	write(Key), nl.
insert_key(Key, t(Key, L, R), t(Key, L, R)):-
	!, 
	write('Key already in tree\n').
insert_key(Key, t(K, L, R), t(K, NL, R)):-
	Key<K, !, 
	insert_key(Key, L, NL).
insert_key(Key, t(K, L, R), t(K, L, NR)):- 
	insert_key(Key, R, NR). 
	
%----------------------------------------------------------------------------------------------

delete_key(Key, nil, nil):-
	write(Key), 
	write(' not in tree\n').
delete_key(Key, t(Key, L, nil), L):- !.
delete_key(Key, t(Key, nil, R), R):- !.
delete_key(Key, t(Key, L, R), t(Pred, NL, R)):-
	!, 
	get_pred(L, Pred, NL).
delete_key(Key, t(K, L, R), t(K, NL, R)):-
	Key<K, !, 
	delete_key(Key, L, NL).
delete_key(Key, t(K, L, R), t(K, L, NR)):- 
	delete_key(Key, R, NR).
	
	
get_pred(t(Pred, L, nil), Pred, L):-
	!.
get_pred(t(Key, L, R), Pred, t(Key, L, NR)):-
	get_pred(R, Pred, NR). 

%----------------------------------------------------------------------------------------------





%----------------------------------------------------------------------------------------------
