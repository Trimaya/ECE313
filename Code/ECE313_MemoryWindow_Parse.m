
% Parse the data using the function we created previously
filename = '/Users/alvaraac/Desktop/Spring 2024/ECE 313 - Memory Device Technology and Application/Final Project - ECE313/Data logs - varying BO, TL, TO for PGM ERS/Tests/test1spgm.log';
    data = parseSilvacoLog(filename);

    
    % Assuming column indices based on 'd' line structure, which needs validation
    % You need to manually adjust these indices based on actual data layout
    gateVoltageIndex = 3;  % Update this according to your file specifics
    drainCurrentIndex = 16;  % Update this according to your file specifics
    
    % Extract the relevant columns
    gateVoltages = data(:, gateVoltageIndex);
    drainCurrents = data(:, drainCurrentIndex);
    
    % Plotting the data
    figure;
    semilogy(gateVoltages, abs(drainCurrents), 'o-'); % Log scale for current, using absolute value
    xlabel('Gate Internal Voltage (V)');
    ylabel('Drain Current (A)');
    title('Gate Internal Voltage vs. Drain Current');
    grid on;


    function data = parseSilvacoLog(filename)
    % Open the file
    fid = fopen(filename, 'rt');
    if fid == -1
        error('File cannot be opened');
    end
    
    % Initialize the data array
    data = [];
    
    % Read the file line by line
    while ~feof(fid)
        line = fgetl(fid);
        if startsWith(line, 'd ')  % Check if the line starts with 'd'
            % Parse the numeric data from the line
            numData = sscanf(line(3:end), '%f');
            data = [data; numData'];  % Append to the data array
        end
    end
    
    % Close the file
    fclose(fid);
end
