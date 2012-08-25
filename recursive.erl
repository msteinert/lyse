-module(recursive).
-export([fac/1, tail_fac/1]).
-export([len/1, tail_len/1]).
-export([duplicate/2, tail_duplicate/2]).
-export([reverse/1, tail_reverse/1]).
-export([sublist/2, tail_sublist/2]).
-export([zip/2, tail_zip/2]).
-export([lenient_zip/2, tail_lenient_zip/2]).
-export([quicksort/1, lc_quicksort/1]).

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N-1).

tail_fac(N) -> tail_fac(N,1).
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

len([]) -> 0;
len([_]) -> 1;
len([_|List]) -> 1 + len(List).

tail_len(List) -> tail_len(List,0).
tail_len([],Acc) -> Acc;
tail_len([_|List],Acc) -> tail_len(List,Acc+1).

duplicate(0,_) -> [];
duplicate(1,T) -> [T];
duplicate(N,T) when N > 0 -> [T|duplicate(N-1,T)].

tail_duplicate(N,T) -> tail_duplicate(N,T,[]).
tail_duplicate(0,_,Acc) -> Acc;
tail_duplicate(N,T,Acc) when N > 0 -> tail_duplicate(N-1,T,[T|Acc]).

reverse([]) -> [];
reverse([H|T]) -> reverse(T)++[H].

tail_reverse(List) -> tail_reverse(List,[]).
tail_reverse([],Acc) -> Acc;
tail_reverse([H|T],Acc) -> tail_reverse(T,[H|Acc]).

sublist(_,0) -> [];
sublist([],_) -> [];
sublist([H|T],N) when N > 0 -> [H|sublist(T,N-1)].

tail_sublist(L,N) -> tail_reverse(tail_sublist(L,N,[])).
tail_sublist(_,0,Acc) -> Acc;
tail_sublist([],0,Acc) -> Acc;
tail_sublist([H|T],N,Acc) when N > 0 -> tail_sublist(T,N-1,[H|Acc]).

zip([],[]) -> [];
zip([A|An],[B|Bn]) -> [{A,B}|zip(An,Bn)].

tail_zip(A,B) -> tail_reverse(tail_zip(A,B,[])).
tail_zip([],[],Acc) -> Acc;
tail_zip([A|An],[B|Bn],Acc) -> tail_zip(An,Bn,[{A,B}|Acc]).

lenient_zip([],_) -> [];
lenient_zip(_,[]) -> [];
lenient_zip([A|An],[B|Bn]) -> [{A,B}|lenient_zip(An,Bn)].

tail_lenient_zip(A,B) -> tail_reverse(tail_lenient_zip(A,B,[])).
tail_lenient_zip([],_,Acc) -> Acc;
tail_lenient_zip(_,[],Acc) -> Acc;
tail_lenient_zip([A|An],[B|Bn],Acc) -> tail_lenient_zip(An,Bn,[{A,B}|Acc]).

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
    {Smaller, Larger} = partition(Pivot,Rest,[],[]),
    quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_,[],Smaller,Larger) -> {Smaller,Larger};
partition(Pivot,[H|T],Smaller,Larger) ->
    if  H =< Pivot -> partition(Pivot,T,[H|Smaller],Larger);
        H > Pivot -> partition(Pivot,T,Smaller,[H|Larger])
    end.

lc_quicksort([]) -> [];
lc_quicksort([Pivot|Rest]) ->
    lc_quicksort([Smaller || Smaller <- Rest,Smaller =< Pivot])
    ++ [Pivot] ++
    lc_quicksort([Larger || Larger <- Rest,Larger > Pivot]).
