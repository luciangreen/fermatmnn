:- begin_tests(choice).

:- use_module('../src/mnn_choice').

test(valid_choice_packet) :-
    mnn_choice:valid_packet(cp([a, b])).

test(empty_choice_packet_invalid, [fail]) :-
    mnn_choice:valid_packet(cp([])).

test(cartesian_splice_order) :-
    mnn_choice:splice([cp([a, b]), cp([1, 2])], Results),
    assertion(Results == [[a,1],[a,2],[b,1],[b,2]]).

test(mixed_fixed_and_cp) :-
    mnn_choice:splice([x, cp([1, 2])], Results),
    assertion(Results == [[x,1],[x,2]]).

test(product_size) :-
    mnn_choice:product_size([cp([a,b,c]), cp([1,2]), z], Size),
    assertion(Size == 6).

:- end_tests(choice).
