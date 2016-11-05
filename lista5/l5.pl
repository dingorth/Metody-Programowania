appn([X],X) :-!.
appn([A,B|T],X) :-
	append(A,B,H),
	appn([H|T],X).

flatten(In,Out) :-
	flatten(In,[],Tmp), reverse(Tmp,Out). 
flatten([],X,X).
flatten([H|T],Acc,W) :-
	integer(H),!,
	flatten(T,[H|Acc],W).
flatten([H|T],Acc,W) :-
	flatten(H,[],Tmp),
	append(Tmp,Acc,Lol),
	flatten(T,Lol,W).

flatten2_aux([],Z,Z):- !.
flatten2_aux([[]|ListTail],X,Z) :-
      !, flatten2_aux(ListTail,X,Z).
flatten2_aux([Atom|ListTail],[Atom|X],Z) :-
      atomic(Atom), !, flatten2_aux(ListTail,X,Z).
flatten2_aux([List|ListTail],X,Z) :-
      flatten2_aux(List,X,Y),flatten2_aux(ListTail,Y,Z).


halve(List,L,R) :-
	halve(List,List,L,R).

halve(R,[],[],R) :- !.
halve(R,[_],[],R):- !.
halve([H|T],[_,_|T2],[H|L],R) :-
	halve(T,T2,L,R).


merge([],X,X) :- !.
merge(X,[],X) :- !.
merge([H1|T1],[H2|T2],[H1|T]) :-
	H1 < H2 ,!,
	merge(T1,[H2|T2],T).
merge([H1|T1],[H2|T2],[H2|T]) :-
	%% H1 >= H2,
	merge([H1|T1],T2,T).


merge_sort([X],[X]) :- !.
merge_sort(In,Out) :-
	halve(In,L,R),
	merge_sort(L,L_Sorted),
	merge_sort(R,R_Sorted),
	merge(L_Sorted,R_Sorted,Out).



split(List,Med,Small,Big) :-
	split(List,Med,Small,[],Big,[]). 
split([],_,X,X,Y,Y) :- !.
split([H|T],Med,Small,SmallAcc,Big,BigAcc) :-
	H < Med, !,
	split(T,Med,Small,[H|SmallAcc],Big,BigAcc).
split([H|T],Med,Small,SmallAcc,Big,BigAcc) :-
	split(T,Med,Small,SmallAcc,Big,[H|BigAcc]). 

qsort(In, Out) :-
	qsort(In, [], Out).
qsort([],X,X).
qsort([H|T],Acc,R) :-
	split(T,H,Small,Big),
	qsort(Big,Acc,Tmp),
	qsort(Small,[H|Tmp],R).


/*merge_sort2(In,Out) :-
	length(In,Length),
	merge_sort2(In,Length,Out).

merge_sort2([],0,[]).
merge_sort2(X,N,R,Y) :-
	Nl is N div 2,
	Nr is N - Nl,
	merge_sort2(X,Nl,B,Tmp),
	merge_sort2(B,Nr,R,).*/

%% napisane na ćwiczeniach

prime(X) :-
	prime(X,[2|End],End,1).
prime(2).
prime(X,_,[],Chk) :-
	\+var(X),
	X =< Chk,!,fail.

prime(X,List,End,Chk) :-
	Chk1 is Chk + 1,
	(div(Chk1,List) ->
		prime(X,List,End,Chk1)
	;X = Chk1
	;End = [Chk1|NewEnd]
	,prime(X,List,NewEnd,Chk1)
	).

div(X,[H|_]) :-
	0 is X mod H, !.
div(X,[H|T]) :-
	H2 is H*H,
	H2 < X,
	div(X,T).

appnd([],[]).
appnd([],T,S):-
	!,appnd(T,S).
appnd([h|T1],T2,[H|T]) :-
	appnd(T1,T2,T).
appnd([H|T],X) :-
	appnd(H,T,X).