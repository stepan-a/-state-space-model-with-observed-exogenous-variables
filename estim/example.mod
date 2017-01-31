var y x z u;

varexo epsilon upsilon fake_u;

parameters phi_1, phi_2, beta_z;

phi_1  =  .50;
phi_1  = -.70;
beta_z =  .10;

model(linear);
y = x + z ;
z = phi_1*z(-1) + phi_2*z(-2) + upsilon + beta_z*u;
x = x(-1) + epsilon;
fake_u - u;
end;

varobs y u;

ts = dseries('../dgp/sample.mat');

range = dates('1950Q1'):(dates('2155Q1')+220); ts = ts(range);

sigma_u = sqrt(var(ts.u.data));

shocks;
var fake_u; stderr sigma_u;
end;

data(series=ts);

estimated_params;
phi_1, uniform_pdf, , , -1, 1;
phi_2, uniform_pdf, , , -1, 1;
beta_z, uniform_pdf, , , 0, 1;
stderr epsilon, uniform_pdf, , , 0, .2;
stderr upsilon, uniform_pdf, , , 0, .4;
end;

estimated_params_init;
phi_1, .50;
phi_2, -.70;
beta_z, .10;
stderr epsilon, .10;
stderr upsilon, .20;
end;

estimation(order=1, lik_init=2,mode_compute=8, presample=20, mh_replic=0);
estimation(order=1, lik_init=2,mode_compute=4, mode_file=example_mode, presample=20, mh_replic=50000, smoother) x z;

range = 21:220;

close all
plot(oo_.SmoothedVariables.Mean.x(range),'-k','linewidth',2)
hold on
plot(ts.x.data(range),'-r')
hold off
title('Estimattion of the trend')
legend('Estimate','True')
print('x','-depsc2')

close all
plot(oo_.SmoothedVariables.Mean.z(range),'-k','linewidth',2)
hold on
plot(ts.z.data(range),'-r')
hold off
title('Estimation of the cycle')
legend('Estimate','True')
print('z','-depsc2')
