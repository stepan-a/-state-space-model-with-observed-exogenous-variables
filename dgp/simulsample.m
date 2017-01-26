dynare_config();

ts = dseries('observed_exogenous_variables.mat');

T = ts.nobs;

x = zeros(T, 1);

calibration;

for t=2:T
    x(t) = alpha*x(t-1) + beta_x*ts.u.data(t) + sigma*randn(1); 
end

y = x + beta_y*ts.v.data;

ts = dseries([y, x, ts.v.data, ts.u.data],dates('1900M1'), {'y'; 'x'; 'v'; 'u'});

ts.save('sample','mat');