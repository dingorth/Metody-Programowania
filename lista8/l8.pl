
:- use_module(library(dcg/basics)).

%% zadanie 1

lexer(Tokens) -->
	whites,
	   (  (    "(",       !, { Token = tokLParen }
	      	;  ")",       !, { Token = tokRParen }
	      	;  "*",       !, { Token = tokLeaf }
	      	;  ",",       !, { Token = tokComma }
	      	;  "a",       !, { Token = tokA }  
	      	;  "b",       !, { Token = tokB }     
	      ), !, { Tokens = [Token | TokList] }, lexer(TokList)
	   ;  [], { Tokens = [] }
	   ).

tree(leaf) -->
	[tokLeaf],!.
tree(Lol) -->
	[tokLParen], tree(Left), [tokComma], tree(Right), [tokRParen], 
		{ Lol =.. [node, Left, Right] }. 

parse(CharCodeList, Absynt) :-
   phrase(lexer(TokList), CharCodeList),
   phrase(tree(Absynt), TokList).

%% zadanie 2

expression(Expr) --> simpe_expression(Simple), expression(Simple,Expr).
expression(Acc,Expr) --> [tokLeaf], !, simpe_expression(Simple), 
	{ Acc1 =.. ['#', Acc, Simple] }, expression(Acc1, Expr).
expression(Acc,Acc) --> [].

simpe_expression(a) --> [tokA],!.
simpe_expression(b) --> [tokB],!.
simpe_expression(Expr) --> [tokLParen], expression(Expr), [tokRParen].


parse2(CharCodeList, Absynt) :-
	phrase(lexer(TokList), CharCodeList),
	phrase(expression(Absynt), TokList).