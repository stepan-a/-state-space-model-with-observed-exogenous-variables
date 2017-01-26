var y x v u;

varexo epsilon fake_v fake_u;

parameters alpha, beta_y, beta_x;

alpha = .10;

beta_y = .6;
beta_x = .1;

model;
y = x + beta_y*v;
x = alpha*x(-1) + beta_x*u + epsilon;
fake_v - v;
fake_u - u;
end;

varobs y v u;

ts = dseries('../dgp/sample.mat');

range = dates('1950Q1'):dates('2155Q1'); ts = ts(range);

sigma_u = sqrt(var(ts.u.data));
sigma_v = sqrt(var(ts.v.data));

shocks;
var fake_u; stderr sigma_u;
var fake_v; stderr sigma_v;
end;

data(series=ts);

estimated_params;
alpha, uniform_pdf, , , -1, 1;
beta_x, uniform_pdf, , , 0, 1;
beta_y, uniform_pdf, , , 0, 1;
stderr epsilon, uniform_pdf, , , 0, .2;
end;

estimated_params_init;
alpha,  .95;
beta_x, .05;
beta_y, .10;
stderr epsilon, .10;
end;

estimation(order=1, mode_compute=4, presample=20, smoother, mh_replic=20000) x ;
