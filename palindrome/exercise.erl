%% This exercise is from:
%% https://github.com/exercism/erlang/tree/master/exercises/palindrome-products

-module(exercise).
-compile(export_all).

calculate(S,F) ->
  erase({max}),
  erase({min}), 
  erase({resMin}),
  erase({resMax}),
  I = lists:seq(S,F),
  % search for all palindromes
  [checkMinMax(B1,B2) || B1<-I,B2<-I, isPal(B1*B2)],
  % return min palindrome
  io:format("Max: ~p ~n", [get({resMax})]),
  % return max palindrome
  io:format("Min: ~p ~n", [get({resMin})]).

checkMinMax(A,B) ->
  Min = get({min}),
  Max = get({max}),
  % io:format("~p ~p ~n", [Min,Max]),
  case Min of
    undefined -> put({max}, A*B),
                 put({min}, A*B),
                 % io:format("All ~p ~p ~n", [Min, Max]),
                 put({resMax}, {A*B,A,B}),
                 put({resMin}, {A*B,A,B});
    _ -> 
      case Max > A*B of
        true ->  put({max}, A*B),
                 % io:format("max ~p ~n", [Max]),
                 put({resMax}, {A*B,A,B});
        false -> none
      end,
      case Min < A*B of
        true -> put({min}, A*B),
                % io:format("max ~p ~n", [Min]),
                put({resMin}, {A*B,A,B});
        false -> none
      end
  end.

isPal(N) -> 
  B=erlang:integer_to_list(N),
  C=lists:reverse(B),
  N=:=erlang:list_to_integer(C).
