InitBreach;
x0 = 5;
v0 = 20;
m = 1000;
k = 50; 

mdl = 'simple_car_model';
simulationTimeHorizon = 0:.1:200;
%%
S = BreachSimulinkSystem(mdl);
%%
S.SetTime(simulationTimeHorizon);
inputGen.type = 'UniStep';
inputGen.cp = 1;
S.SetInputGen(inputGen);
S.PrintParams();
%%
S.SetParam({'Force_u0'}, [500]);
S.PrintSignals();
%%
S.Sim;
S.PlotSignals();
figure;
S.PlotSigPortrait();
%%
clear S;
S = BreachSimulinkSystem(mdl);
S.SetTime(simulationTimeHorizon);
inputGen.type = 'UniStep';
inputGen.cp = 20;
S.SetInputGen(inputGen);
S.PrintParams;
paramRange = [0 500];
paramNames = {};
for ii=0:19 
   paramNames{end+1} = sprintf('Force_u%d',ii);     
end
paramRanges = repmat(paramRange, 20, 1);
S.SetParamRanges(paramNames, paramRanges);
%%
numSamples = 100;
S.QuasiRandomSample(numSamples);
S.Sim;
S.PlotSignals();

%%
S.RunGUI;
%%
phi = 'ev_[0,200] (position[t]>800)';
robustnessValues = S.CheckSpec(phi);
fprintf('Robustness values of property phi1 = \n');
disp(reshape(robustnessValues,10,10));
%%
% phitest = 'ev_[0,200](alw_[0,10] (Force[t] < 100))';
% S.CheckSpec(phitest)

%%
phi2 = 'alw_[0,200] ((Force[t] > 100) => ev_[0,10] (velocity[t] > 3))';
robustnessValues = S.CheckSpec(phi2);
fprintf('Robustness values of property phi2 = \n');
disp(reshape(robustnessValues,10,10));
%%












































