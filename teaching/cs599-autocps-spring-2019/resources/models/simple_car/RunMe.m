InitBreach;
x0 = 5;
v0 = 20;
m = 1000;
k = 50; 

mdl = 'simple_car_model';
simuationTimeHorizon = 0:.1:200;

S = BreachSimulinkSystem(mdl);
S.SetTime(simuationTimeHorizon);

inputGen.type = 'UniStep';
inputGen.cp = 1;
S.SetInputGen(inputGen);
S.PrintParams();

S.SetParam({'Force_u0'}, [0]);
S.PrintSignals();

S.Sim;
S.PlotSignals();
figure;
S.PlotSigPortrait();
