dynare_config();

ts = dseries('observed_exogenous_variables.mat');

T = ts.nobs;

x = zeros(T, 1);
z = zeros(T, 1);
u = ts.u.data-mean(ts.u.data);

calibration;

for t=2:T
    x(t) = x(t-1) +  sigma_x*randn(1);
    if t>3
        z(t) = phi_1*z(t-1) + phi_2*z(t-2) + sigma_z*randn(1) + beta_z*u(t) ;
    else
        z(t) = phi_1*z(t-1) + sigma_z*randn(1) + beta_z*u(t) ;
    end
end

y = x + z ;

ts = dseries([y, x, z, u],dates('1900M1'), {'y'; 'x'; 'z'; 'u'});

ts.save('sample','mat');