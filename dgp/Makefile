include ../configure.inc

all: sample.mat clean

clean:
	@echo "Removing useless generated files."
	@rm -f observed_exogenous_variables.mat
	@rm -rf simulexogenousvariables
	@rm -f simulexogenousvariables_dynamic.m
	@rm -f simulexogenousvariables_static.m
	@rm -f simulexogenousvariables.m
	@rm -f simulexogenousvariables_results.mat
	@rm -f simulexogenousvariables_set_auxiliary_variables.m
	@rm -f simulexogenousvariables.log

sample.mat: simulsample.m observed_exogenous_variables.mat 
	@echo "Simulating observed exogenous variables..."
	@$(MATLAB) -r "addpath $(DYNARE_PATH); dynare_config; simulsample; quit" > /dev/null 

observed_exogenous_variables.mat: simulexogenousvariables.mod
	@echo "Simulating state space model..."
	@$(MATLAB) -r "addpath $(DYNARE_PATH); dynare simulexogenousvariables; quit" > /dev/null
