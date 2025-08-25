InitBreach;
clc;
clear S;
close all;

%%
x0_host = 0;
v0_host = 10;
x0_lead = 50;
v0_lead = 20;
vref_host = 20;
KpD = 1;
KpV = -0.1;
Ts = 0.5;
endTime = 50;
dSafe = 5;
%%
S = BreachSimulinkSystem('ACC');
tspan = 0:Ts:endTime;
S.SetTime(tspan);
inputGen.type = 'UniStep';
inputGen.cp = 20;
S.SetInputGen(inputGen);
params = cell(1,20);
for jj=1:20
   params{1,jj} = sprintf('LeadAcc_u%d',jj-1);
end
%%
S.PrintParams;
leadAccMax = 2;
leadAccMin = -1;
S.SetParamRanges(params,repmat([leadAccMin leadAccMax],20,1));
S.PrintParams;
%%
S.QuasiRandomSample(20);
S.Sim;
positions = S.GetSignalValues({'HostPosition','LeadPosition',...
                               'HostVelocity','LeadAcc',...
                               'HostAcceleration','LeadVelocity'});
close all;
for jj=1:20
    figure;
    trace = positions{jj};
    subplot(3,1,1);
    plot(tspan,trace(1,:),'-r.', tspan, trace(2,:), '-bx');
    % title, legend code courtesy Ryan Blackwell
    title('Position');
    legend('Host','Lead');
    
    subplot(3,1,2);    
    plot(tspan,trace(3,:),'-r.', ...
         tspan, vref_host*ones(1,length(tspan)),'-ko', ... 
         tspan,trace(6,:),'-bx');   
    title('Velocity');
    legend('Host','Desired Host','Lead');
    
    subplot(3,1,3);
    plot(tspan,trace(5,:),'-r.',tspan,trace(4,:),'-bx');
    title('Acceleration');
    legend('Host','Lead');
end