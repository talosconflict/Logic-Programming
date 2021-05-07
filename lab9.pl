

toDiff([],[],_).
toDiff([H],[H],H):-
    var(H),!.
toDiff([H|T],[H|LS],LE):-
    toDiff(T,LS,LE),!.