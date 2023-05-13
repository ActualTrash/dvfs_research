all: base_experiments experiment1 experiment2 experiment3

base_experiments: exp_zeros exp_ones
experiment1: exp_quarter exp_half exp_three_quarters
experiment2: exp_alternate
experiment3: exp_xmm_zeros exp_xmm_ones

exp_%: exp_%.o reg_fill.o
	gcc $< reg_fill.o -o $@

exp_%.o: %.c
	gcc -Wall -Wextra $< -c -o $@

reg_fill.o: reg_fill.S
	as $< -o $@

.PHONY: clean
clean:
	rm -f exp_* *.o
