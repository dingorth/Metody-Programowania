
	


%% zadanie 6

%% podejscie 1 generuje i sprawdza ale jest jeden false po ;
lang --> [].
lang --> "a", lang, "b".

/*lang(A, A).
lang([97|A], C) :-
	lang(A, B),
	B=[98|C].*/

%% podejscie 1 deterministycznie ale nie generuje slow
lang2 --> [].
lang2 --> "a", lang2, "b",!.


%% podejscie 2 generuje i sprawdza ale jest jeden false po ;
s(N) --> a(N), s2(N).
s2(N) --> b(N),!.

a(0) --> [].
a(N) --> "a", a(N2), {N is N2 + 1}.

b(0) --> [].
b(N) --> "b", b(N2), {N is N2 + 1}.


%% zadanie 7
:-arithmetic_function(!/1).
:-op(150,yf,!).

!(0,1):-!.
!(N,Res):-
	N > 0,
	Nm is N - 1,
	!(Nm,Resm),
	Res is Resm * N.


:-arithmetic_function('!!'/1).
:-op(150,yf,'!!').


'!!'(N,Res) :-
	'!!'(N,1,Res).

'!!'(1,Res,Res):-!.
'!!'(2,Res,Res):-!.
'!!'(N, Acc, Res):-
	1 is N mod 2,!,
	Accn is Acc * N,
	Nnew is N - 2,
	'!!'(Nnew,Accn,Res).

'!!'(N, Acc, Res):-
	Accn is Acc * (N - 1),
	Nnew is N - 3,
	'!!'(Nnew,Accn,Res).