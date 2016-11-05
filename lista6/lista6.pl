%% zad 4

p(X) :-
	gen(X,0),
	X < 10.
	
np(X) :-
	gen(X,1), 
	X < 10.

gen(Acc,Acc).
gen( X, Acc ) :-
	Tmp is Acc + 2,
	Acc < 10,
	gen( X , Tmp ).



%% zad 3

empty(leaf).

insert(leaf, Element, node(leaf,Element,leaf) ).
insert(node(Left, Root, Right), Element, node(Left,Root,Result) ) :-
	Element > Root,!,
	insert(Right,Element, Result).
insert(node(Left, Root, Right), Element, node(Result,Root,Right) ) :-
	insert(Left,Element, Result).

find(Element, node(_,Element,_)) :- !.
find(Element, node(_,Root,Right)) :-
	Element > Root, !,
	find(Element,Right).
find(Element, node(Left,_,_)) :-
	find(Element,Left).

findMax(node(_,Root,leaf),Root ) :- ! .
findMax(node(_,_,Right), Element ) :-
	findMax(Right,Element).

delete(_,leaf,leaf):-!.
delete(Element, node(leaf, Element, leaf), leaf):-!.
delete(Element, node(Left,Element,leaf), Left):-!.
delete(Element , node(leaf,Element,Right), Right):-!.
delete(Element, node(Left, Element, Right), node( Left_Removed , L_Max, Right )) :-
	findMax(Left,L_Max),
	delete(L_Max,Left, Left_Removed), ! .

delete(Element, node(Left, Root, Right), node(Left,Root,Right_Removed) ) :-
	Element > Root, !,
	delete(Element,Right,Right_Removed).
delete(Element, node( Left, Root, Right), node(Left_Removed, Root, Right) ) :-
	delete(Element,Left, Left_Removed).	
	
delMax( Tree, Max, Out_Tree ) :-
 	findMax(Tree,Max),
 	delete(Max,Tree,Out_Tree).













