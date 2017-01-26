include ../configure.inc

all: example_results.mat

clean:
	@rm -rf example  
	@rm -f example_dynamic.m
	@rm -f example.m
	@rm -f *.eps
	@rm -f example_set_auxiliary_variables.m
	@rm -f example_static.m
	@rm -f example_mode.mat
	@rm -f example_pindx.mat
	@rm -f *.dat
	@rm -f g1.mat g2.mat g3.mat
	@rm -f example_params.mat

cleanall: clean
	rm -f example_results.mat
	rm -f example.log

data:
	make -C ../dgp all

example_results.mat: data example.mod
	@echo "Estimation of the state space model..."
	@$(MATLAB) -r "addpath $(DYNARE_PATH); dynare_config; dynare example; quit" > /dev/null 
