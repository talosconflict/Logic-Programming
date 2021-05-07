gcd(X,X,X).
gcd(X,Y,Z):-X>Y, R is X-Y, gcd(R,Y,Z).
gcd(X,Y,Z):-X<Y, R is Y-X, gcd(X,R,Z).

fact(0,1).	%define 0!=1
fact(N,F):-N>0, N1 is N-1, fact(N1,F1), F is F1*N.

fact1(0,FF,FF). %factorial cu accumulation parameter?
fact1(N,FP,FF):-N>0,N1 is N-1,FP1 is FP*N, fact1(N1,FP1,FF).

factp(N,F):-fact1(N,1,F).

for(In,In,0):-!.
for(In,Out,I):- NewI is I-1, NewIn is In+I, for(NewIn,Out,NewI).

%----------------------------------------------------------------------------

%	Problem 2.4.1
lcm(X,X,X).
%Temp(X,Y):-gcd(X,Y,Z).
lcm(X,Y,Z):- P is X*Y, gcd(X,Y,Temp), Z is P/Temp.


%	Problem 2.4.2
fib(1,1):-!. %primul nr e 1
fib(2,2):-!. %al doilea e 2
fib(N,Out):- Temp1 is N-1, Temp2 is N-2, 
				fib(Temp1,F1), fib(Temp2,F2),
				Out is F1+F2.	%why infinite ciclu?
				

	
%	Problem 2.4.3
rep(High,High):-!.
rep(Low,High):- print(Low), Temp is Low+1, rep(Temp,High).