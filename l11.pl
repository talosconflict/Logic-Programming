woman(ana).
woman(sara).
woman(ema).
woman(maria).
woman(carmen).
woman(dorina).
woman(irina).

man(andrei).
man(alex).
man(george).
man(mihai).
man(marius).
man(sergiu).

parent(maria,ana).
parent(george,ana).
parent(maria,andrei).
parent(george,andrei).
parent(carmen,sara).
parent(alex,sara).
parent(carmen,ema).
parent(alex,ema).
parent(marius,maria).
parent(dorina,maria).
parent(mihai,george).
parent(irina,george).
parent(mihai,carmen).
parent(irina,carmen).
parent(sergiu,emanuel).
parent(emanuel,mihai).


father(X, Y):- parent(X,Y), man(X).
mother(X,Y):- parent(X,Y),woman(X).
sibling(X,Y):- parent(Z,X), parent(Z,Y), X\=Y.



%X e fratele lui Y
brother(X,Y):- sibling(X,Y), man(X).
sister(X,Y):- sibling(X,Y), woman(X). %X e sora lui Y?



%X e unchiul lui Y
uncle(X,Y):- brother(X, Z), parent(Z,Y).
aunt(X,Y):- sister(X,Z),parent(Z,Y).



%X e bunicul lui Y
grandfather(X,Y):- parent(Z,Y), father(X,Z).
grandmother(X,Y):- parent(Z,Y), mother(X,Z).



%X is ancestor of Y
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z), ancestor(Z,Y).



/*
Y=andrei
X=george
Z=mihai
/*

oldestKnownAncestor(X,Y):- ancestor(X,Y), not(parent(_,X)).