var u, v;

varexo eu, ev;

parameters rho_u sig_u rho_v const_v sig_v ;

@#include "calibration.inc"

model;
u = rho_u*u(-1) + (v-v(-1))*eu*sig_u ;
v = rho_v*v(-1) + const_v + sig_v*ev ;
end;

histval;
v(0) = 0.0;
u(0) = 0.1;
end;

shocks;
var eu = 1.0;
var ev = 1.0;
end;

oo_ = simul_backward_nonlinear_model([], 10000, options_, M_, oo_);

ts = dseries(transpose(oo_.endo_simul), dates('1900M1'), {'u'; 'v'});

ts.save('observed_exogenous_variables','mat');
