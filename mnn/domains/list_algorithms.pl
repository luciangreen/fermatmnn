domain(list_algorithms).

concept(list_processing).

example(lookup, color_of, io(red, warm)).
example(lookup, color_of, io(blue, cool)).

example(decision, parity_label, io(1, odd)).
example(decision, parity_label, io(2, even)).

example(recursive, double_list, io([1,2], [1,1,2,2])).

question(double_list([1,2], X)).
