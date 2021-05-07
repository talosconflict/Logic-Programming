%------------------------------------------------------------------------------------------
member1(X,[X|T]).
member1(X,[_|T]):-
	member1(X,T).

append2([],L,L).
append2([H|T],L,[H|R]) :-
	append2(T,L,R).

delete1(X,[X|T],T).
delete1(X,[H|T],[H|R]) :-
	delete1(X,T,R).
delete1(_,[],[]).

delete_all(X, [X|T], R):-!,
	delete_all(X, T, R).
delete_all(X, [H|T], [H|R]):-
	delete_all(X, T, R).
delete_all(_, [], []).

delet(X, [X|T], T):-!.
delet(X, [H|T], [H|R]):-
	delet(X, T, R).
delet(_, [], []).


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
%------------------------------------------------------------------------------------------

length1([],0).
length1([H|T], Len):-length(T,Len1), Len is Len1+1.

% when reaching the empty list, unify accumulator with the free result variable
length_fwd([], Acc, Res):-
	Res = Acc.
% as the list is decomposed, add 1 to the accumulator; pass Res unchanged
length_fwd([H|T], Acc, Res):-
	Acc1 is Acc+1,
	length_fwd(T, Acc1, Res).

reverse([], []).
reverse([H|T], Res):-
	reverse(T, R1),
	append(R1, [H], Res).

reverse_fwd([], R, R).
reverse_fwd([H|T], Acc, R):-
	reverse_fwd(T, [H|Acc], R).

minimum([], M, M).
minimum([H|T], MP, M):-
	H<MP, !,
	minimum(T, H, M).
minimum([H|T], MP, M):-
	minimum(T, MP, M).

minimum_pretty([H|T], R):-
	minimum([H|T], H, R).

minimum_bwd([H], H).
minimum_bwd([H|T], M):-
	minimum_bwd(T, M),
	H>=M, !.
minimum_bwd([H|T], H).

union([ ],L,L).
union([H|T],L2,R) :- member(H,L2),!,union(T,L2,R).
union([H|T],L,[H|R]):-union(T,L,R).

%------------------------------------------------------------------------------------------

%find minimum in a list and delet it
%findmin(L,Res).
deletemin(In, Out):-
	minimum_pretty(In,Ceva),
	delete_all(Ceva,In,Out).

%------------------------------------------------------------------------------------------

%reverse from kth element onwards
%reversek([H|T],K,Iterator,Res)
%reversek([],_,_,[]).
reversek([H|T],0,Aux,Res):-
	reverse(Aux,Temp1),
	reverse(List,Temp2),
	append2(Temp1,Temp2,Res).
reversek([H|T],K,Aux,Res):-
	NewIt is K-1,
	reversek(T,NewIt,[H|Aux],Res).
reversek([H|T],K,Res):-
	reversek([H|T],K,[],Res).



reverse_k(L,1,Res):-
	reverse_fwd(L,[],Res).
reverse_k([H|T],K,[H|Res]:-
	NextK is K-1,
	reverse_k(T,NextK,Res).


%------------------------------------------------------------------------------------------


maximum([], M, M).
maximum([H|T], MP, M):-
	H>MP, !,
	maximum(T, H, M).
maximum([H|T], MP, M):-
	maximum(T, MP, M).

maximum_pretty([H|T], R):-
	maximum([H|T], H, R).

deletemax(In,Out):-
	maximum_pretty(In,Ceva),
	delete_all(Ceva,In,Out).

%------------------------------------------------------------------------------------------
