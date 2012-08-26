-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

inc(N) -> N+1.
dec(N) -> N-1.

map(_,[]) -> [];
map(F,[H|T]) -> [F(H)|map(F,T)].

tail_map(F,L) -> lists:reverse(tail_map(F,L,[])).
tail_map(_,[],Acc) -> Acc;
tail_map(F,[H|T],Acc) -> tail_map(F,T,[F(H)|Acc]).

even(L) -> lists:reverse(even(L,[])).
even([],Acc) -> Acc;
even([H|T],Acc) when H rem 2 == 0 -> even(T,[H|Acc]);
even([_|T],Acc) -> even(T,Acc).

filter(Pred,L) -> lists:reverse(filter(Pred,L,[])).
filter(_,[],Acc) -> Acc;
filter(Pred,[H|T],Acc) ->
    case Pred(H) of
        true -> filter(Pred,T,[H|Acc]);
        false -> filter(Pred,T,Acc)
    end.

fold(_,Start,[]) -> Start;
fold(F,Start,[H|T]) -> fold(F,F(H,Start),T).
