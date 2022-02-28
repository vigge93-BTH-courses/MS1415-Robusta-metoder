clear
close all
clc

load('image.mat');

%Region sea marking
y(50:69, 49) = 1;
y(50:69, 70) = 1;
y(49, 50:69) = 1;
y(70, 50:69) = 1;

%Region forest marking
y(130:149, 104) = 1;
y(130:149, 125) = 1;
y(129, 105:124) = 1;
y(150, 105:124) = 1;

% y(140:159, 184) = 1;
% y(140:159, 205) = 1;
% y(139, 184:205) = 1;
% y(160, 184:205) = 1;


%Region urban marking
y(130:149, 264) = 1;
y(130:149, 285) = 1;
y(129, 265:284) = 1;
y(150, 265:284) = 1;

imshow(y);

sea = y(50:69, 50:69);
forest = y(130:149, 105:124);
% forest = y(140:159, 185:204);
urban = y(130:149, 265:284);

figure();
imshow(sea);
figure();
imshow(forest);
figure();
imshow(urban);

win_size = 20;
win_sq = win_size^2;
samples = 3;

sea = reshape(sea, [1, win_sq]);
forest = reshape(forest, [1, win_sq]);
urban = reshape(urban, [1, win_sq]);

obs_signal = [ sea forest urban ];

figure();
plot(obs_signal);

x2 = zeros(win_sq*samples, 1);
x2(win_sq+1:2*win_sq) = 1;

x3 = zeros(win_sq*samples, 1);
x3(2*win_sq+1:3*win_sq) = 1;

variates = [x2 x3];

gam_mdl = fitglm(variates,obs_signal,'linear','Distribution','gamma')
norm_mdl = fitglm(variates,obs_signal,'linear','Distribution','normal')

figure();
plotResiduals(gam_mdl,'caseorder');
figure();
hold on;
plotResiduals(gam_mdl);
histfit(gam_mdl.Residuals.raw);
hold off;
figure();
plotResiduals(norm_mdl,'caseorder');
figure();
hold on;
plotResiduals(norm_mdl);
histfit(norm_mdl.Residuals.raw);
hold off;

figure();
plotDiagnostics(gam_mdl,'cookd');
figure();
plotDiagnostics(norm_mdl,'cookd');

extreme_values_gam = find((gam_mdl.Diagnostics.CooksDistance) > 7*mean(gam_mdl.Diagnostics.CooksDistance))
extreme_values_norm = find((norm_mdl.Diagnostics.CooksDistance) > 7*mean(norm_mdl.Diagnostics.CooksDistance))

obs_signal_gam = obs_signal;
obs_signal_norm = obs_signal;
x2_gam = x2;
x2_norm = x2;
x3_gam = x3;
x3_norm = x3;

obs_signal_gam(flip(extreme_values_gam)) = [];
x2_gam(flip(extreme_values_gam)) = [];
x3_gam(flip(extreme_values_gam)) = [];
variates_gam = [x2_gam x3_gam];

obs_signal_norm(flip(extreme_values_norm)) = [];
x2_norm(flip(extreme_values_norm)) = [];
x3_norm(flip(extreme_values_norm)) = [];
variates_norm = [x2_norm x3_norm];

gam_mdl = fitglm(variates_gam, obs_signal_gam, 'linear','Distribution','gamma')
norm_mdl = fitglm(variates_norm, obs_signal_norm, 'linear','Distribution','normal')

figure();
plotResiduals(gam_mdl,'caseorder');
figure();
hold on;
plotResiduals(gam_mdl);
histfit(gam_mdl.Residuals.raw);
hold off;
figure();
plotResiduals(norm_mdl,'caseorder');
figure();
hold on;
plotResiduals(norm_mdl);
histfit(norm_mdl.Residuals.raw);
hold off;

