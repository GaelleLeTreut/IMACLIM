////	Investment desegregation into a square matrix
disp("Substep 2: DISAGGREGATION of Investment into a square matrix...")

// load file
I_ratio_str = read_csv(DATA_Country+"Invest_Desag.csv",";");
I_ratio_str = I_ratio_str(2:$,2:$);

// record file
I_ratio = evstr(I_ratio_str);

// check data
if size(I_ratio)<>[nb_Sectors nb_Sectors] then
    error("Investment ratios matrix is not of size nb_Sectors x nb_Sectors : "
    + DATA_Country + "Invest_Desag.csv");
end

sensib = 1D-4;

for line = 1:nb_Sectors
    if ( abs( sum(I_ratio(line,:)) - 1 ) > sensib ) then
        error("Line " + (line+1) + " of Investment ratios matrix is not balanced to 1 : "
        + DATA_Country + "Invest_Desag.csv");
    end 
end

// replace I_value by its disaggregation
I_value_agg = initial_value.I_value;
for line = 1:nb_Sectors
    for col = 1:nb_Sectors
        initial_value.I_value(line,col) = I_value_agg(line) * I_ratio(line,col);
    end
end

// replace I by its disaggregation
initial_value.I = initial_value.I_value ./ (initial_value.pI*ones(1,nb_Sectors));

// clear the intermediate variables
clear("I_ratio_str", "I_ratio", "sensib", "line", "I_value_agg");
