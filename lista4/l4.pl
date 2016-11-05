edge(wroclaw,warszawa).
edge(warszawa,wroclaw).
edge(wroclaw,krakow).
edge(wroclaw,szczecin).
edge(szczecin,lublin).
edge(szczecin,gniezno).
edge(warszawa,katowice).
edge(gniezno,gliwice).
edge(lublin,gliwice).

trip(Start, End, Way) :-
	trip(Start, End, [End], Way).

trip(Start, End, [A|Rest], Way) :- 
	edge(T,A),
	not(member(T,[A|Rest])),
	trip(Start,End,[T,A|Rest],Way).

trip(Start, _, [Start|Rest], [Start|Rest] ).


%% node( node(node(leaf,2,leaf), 1, leaf), 3, node( leaf, 5 , leaf)).


mirror(leaf,leaf).
mirror( node(A,B,C), node(Mirrored_C,B,Mirrored_A) ) :-
	mirror(A,Mirrored_A),
	mirror(C,Mirrored_C).


flatten(node(L,B,R),List) :-
	flatten(L,L_List),
	flatten(R,R_List),
	append(L_List,[B|R_List],List).
flatten(leaf,[]). 


insert(node(L,E,R), Element, node(L_Out,E,R )) :-
	Element =< E,
	insert(L,Element,L_Out).
insert(node(L,E,R), Element, node(L,E,R_Out)) :-
	Element > E,
	insert(R,Element,R_Out).
insert(leaf,E,node(leaf,E,leaf)).


elements_on_tree([],TreeAcc,TreeAcc).
elements_on_tree([H|T],TreeAcc,Tree) :-
	insert(TreeAcc,H,Output_Tree),
	elements_on_tree(T,Output_Tree,Tree).

treesort(In_List,Out_List) :-
	elements_on_tree(In_List,leaf,Temp_List),
	flatten(Temp_List,Out_List),!.


list([]).
list([_|X]) :-
	list(X). 

fill([]).
fill([0|X]) :-
	fill(X).
fill([1|X]) :-
	fill(X).

bin([0]).
bin([1|X]) :-
	list(X),	
	fill(X).

%% jeszcze rbin poprawic, korzysa z tego samego list/2 
rfill([1]).
rfill([0|X]) :-
	rfill(X).
rfill([1|X]) :-
	rfill(X).

rbin([0]).
rbin(X) :-
	list(X),	
	rfill(X).


revall(X,Y) :-
	revall(X,[],Y).
%% przepisanie akumulatora
revall([],A,A).
%% jest lista
revall([H|T],A,Y) :-
	is_list(H), 
	!,
	revall(H,R),
	revall(T,[R|A],Y).
%% nie jest lista 
revall([H|T],A,Y) :-
	revall(T,[H|A],Y).




%% zagadka([H1|T1],[H2,T2],[H3|T3]) :-
	




