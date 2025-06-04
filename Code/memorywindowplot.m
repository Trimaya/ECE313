
% Array of voltages and thickness values used
voltages = 5:10;  % 5V to 10V
BOthick = [0.004, 0.008, 0.012, 0.008, 0.008, 0.008, 0.008];
TLthick = [0.006, 0.006, 0.006, 0.003, 0.009, 0.006, 0.006];
TOthick = [0.002, 0.002, 0.002, 0.002, 0.002, 0.001, 0.003];

% Prepare figure for plotting
figure;
hold on;
colors = lines(numel(voltages));  % Generate distinct colors for each voltage

% Define directories and file specifics
baseDir = '/Users/alvaraac/Desktop/Spring 2024/ECE 313 - Memory Device Technology and Application/Final Project - ECE313/Data logs - varying BO, TL, TO for PGM ERS/deck2memorywindow';
PGM_suffix = '_extracted_data_PGM_1s.dat';
ERS_suffix = '_extracted_data_ERS_100ms.dat';  % Only for 100us ERS data

% Loop through each set of thickness and voltage parameters
for i = 1:numel(BOthick)
    for v = 1:numel(voltages)
        % Generate filenames for both PGM and ERS data
        PGM_filename = sprintf('BO%.3fTO%.3fTL%.3f_%dV%s', BOthick(i), TOthick(i), TLthick(i), voltages(v), PGM_suffix);
        ERS_filename = sprintf('BO%.3fTO%.3fTL%.3f_%dV%s', BOthick(i), TOthick(i), TLthick(i), voltages(v), ERS_suffix);
        
        PGM_fullPath = fullfile(baseDir, PGM_filename);
        ERS_fullPath = fullfile(baseDir, ERS_filename);
        
        % Check and plot PGM data
        if isfile(PGM_fullPath)
            dataPGM = readmatrix(PGM_fullPath);
            semilogy(dataPGM(:,1), dataPGM(:,2), 'Color', colors(v,:), 'LineStyle', '-', 'DisplayName', sprintf('PGM: BO=%.3f, TO=%.3f, TL=%.3f at %dV', BOthick(i), TOthick(i), TLthick(i), voltages(v)));
        else
            fprintf('File %s not found.\n', PGM_fullPath);
        end
        
        % Check and plot ERS data
        if isfile(ERS_fullPath)
            dataERS = readmatrix(ERS_fullPath);
            semilogy(dataERS(:,1), dataERS(:,2), 'Color', colors(v,:), 'LineStyle', '--', 'DisplayName', sprintf('ERS: BO=%.3f, TO=%.3f, TL=%.3f at %dV', BOthick(i), TOthick(i), TLthick(i), voltages(v)));
        else
            fprintf('File %s not found.\n', ERS_fullPath);
        end
    end
end

% Customize the plot
xlabel('Gate Voltage (V)');
ylabel('Drain Current (A)');
title('Memory Window Characteristics: PGM vs. ERS');
legend('show', 'Location', 'northeastoutside');
grid on;
hold off;
