////////////////////////////////////
// Specific to homothetic projection
////////////////////////////////////

// Actualise Emission factors embodied in imported goods
if CO2_footprint == "True" & Scenario <>"" then
	if time_step == 1
		ini.CoefCO2_reg = CoefCO2_reg;
	end
	execstr("Deriv_Exogenous.CoefCO2_reg = CoefCO2_reg_" + time_step + "_" + Macro_nb);
end

/////////////////////////////////////////////////////////////////////////////////
// Get with which scenario we are working
/////////////////////////////////////////////////////////////////////////////////
Scenario_temp = strsplit(Scenario);
Scenario_temp = strcat(Scenario_temp(1:3,:));



/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// GLT: TO DELETE ?  Manual correction of macroframework 
/////////////////////////////////////////////////////////////////////////////////
// select time_step 
// case 1 then
	// parameters.Mu = 0.0135;
	// parameters.u_param = 0.165;
// case 2 then
	// parameters.Mu = 0.016;
	// parameters.u_param = 0.165;
// end
// parameters.phi_L = ones(parameters.phi_L) * parameters.Mu;
/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// GLT: TO UPDATE ? Penetration rate of biofuels (1) and biogaz (2) regarding conventional sectors
/////////////////////////////////////////////////////////////////////////////////
select Scenario_temp
case "AME"
	penetration_rate = zeros(1, 2);
case "AMS"
	select time_step 
	case 1 then
		penetration_rate = [0.18, 0.054];
		// fuels : 7% en 2010 et on passe à 12% : 0.054 de réduction du contenu carbone
		// to check again  
	case 2 then
		penetration_rate = ones(1, 2);
	end
end
/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// Gaz cost structure correction 
/////////////////////////////////////////////////////////////////////////////////
// NB: 	AME --> issue regarding production vs. distribution 
		// AMS --> biogaz cost structure of production (which target ?) + price target of DGEC + penetration rate
select Scenario_temp
case "AME"
	select time_step 
	case 1 then 
		parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz) = -0.1550108 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz));
		parameters.phi_K(Indice_Gaz)  = -0.1550108;
		parameters.phi_L(Indice_Gaz)  = -0.1436035;
		parameters.phi_IC(Indice_Agri,Indice_Gaz) = 0.0; 
	case 2 then 
		parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz) = -0.0796872 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz));
		parameters.phi_K(Indice_Gaz)  = -0.0796872;
		parameters.phi_L(Indice_Gaz)  = -0.0649622;
		parameters.phi_IC(Indice_Agri,Indice_Gaz) = 0.0;		 
	end
case "AMS"
	select time_step 
	case 1 then
		parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz) = 0.1161498 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz));
		parameters.phi_K(Indice_Gaz)  = 0.0662911;
		parameters.phi_L(Indice_Gaz)  = 0.10112;	
		parameters.phi_IC(Indice_Agri,Indice_Gaz) = -0.1860797;
		Deriv_Exogenous.markup_rate = markup_rate;
		Deriv_Exogenous.markup_rate(Indice_Gaz) = mean(markup_rate(Indice_Carb));
		Deriv_Exogenous.Production_Tax_rate = Production_Tax_rate;
		Deriv_Exogenous.Production_Tax_rate(Indice_Gaz) = mean(Production_Tax_rate(Indice_Carb));

	case 2 then
		parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz) =  0.102501 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Gaz));
		parameters.phi_K(Indice_Gaz)  =  0.0690707;
		parameters.phi_L(Indice_Gaz)  =  0.0922118;
		parameters.phi_IC(Indice_Agri,Indice_Gaz) = -0.0673676; 
	end
end
/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// Fuel cost structure correction 
/////////////////////////////////////////////////////////////////////////////////
// NB: 	AME --> nothing
		// AMS --> same as gaz for biofuel expansion
select Scenario_temp
case "AMS"
	select time_step
	case 1 then
		parameters.phi_IC(Indice_NonEnerSect,Indice_Carb) = -0.04 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Carb));
		parameters.phi_IC(Indice_Agri,Indice_Carb) = -0.1771781;
		parameters.phi_L(Indice_Carb) = -0.0004573;
		parameters.phi_K(Indice_Carb) = -0.0855834;
	case 2 then 
		parameters.phi_IC(Indice_NonEnerSect,Indice_Carb) = -0.006 * ones(parameters.phi_IC(Indice_NonEnerSect,Indice_Carb));
		parameters.phi_IC(Indice_Agri,Indice_Carb) = -0.1350461;
		parameters.phi_L(Indice_Carb) = -0.015186;
		parameters.phi_K(Indice_Carb) = -0.0868102;
	end
end

/////////////////////////////////////////////////////////////////////////////////
// Automobile cost struction correction 
/////////////////////////////////////////////////////////////////////////////////
// NB: aim to depict electric car penetration and production price targets of DGEC
Deriv_Exogenous.SpeMarg_rates_C = BY.SpeMarg_rates_C;
Deriv_Exogenous.SpeMarg_rates_I = BY.SpeMarg_rates_I;
select Scenario_temp
case "AME"
	select time_step 
	case 1 then
		Deriv_Exogenous.SpeMarg_rates_C(Indice_Auto) = - 0.20;
		Deriv_Exogenous.SpeMarg_rates_I(Indice_Auto) = 0.2746654649;
		parameters.phi_IC(nb_Sectors,Indice_Auto) = 0.0045;
	case 2 then
		Deriv_Exogenous.SpeMarg_rates_C(Indice_Auto) = -0.29002239958983045;
		Deriv_Exogenous.SpeMarg_rates_I(Indice_Auto) = 0.20554114463394632;
		parameters.phi_IC(nb_Sectors,Indice_Auto) = -0.0025;
	end
case "AMS"
	select time_step 
	case 1 then
		Deriv_Exogenous.SpeMarg_rates_C(Indice_Auto) = - 0.26;
		Deriv_Exogenous.SpeMarg_rates_I(Indice_Auto) = 0.27;
		parameters.phi_IC(nb_Sectors,Indice_Auto) = -0.0025;
	case 2 then
		Deriv_Exogenous.SpeMarg_rates_C(Indice_Auto) = -0.28;
		Deriv_Exogenous.SpeMarg_rates_I(Indice_Auto) = 0.265;
		parameters.phi_IC(nb_Sectors,Indice_Auto) = 0.0;
	end
end

/////////////////////////////////////////////////////////////////////////////////
// Carbon and energy taxes + Emission coefficients
/////////////////////////////////////////////////////////////////////////////////
select Scenario_temp 
case "AME"
	parameters.Carbon_Tax_rate = 100*1e3;
	// UE-ETS evolution 
	select time_step 
	case 1 then
		parameters.CarbonTax_Diff_IC = parameters.CarbonTax_Diff_IC;		// do nothing: already in csv param file
	case 2 then
		parameters.CarbonTax_Diff_IC = (parameters.CarbonTax_Diff_IC==0.335)*0.88 + (parameters.CarbonTax_Diff_IC<>0.335).*parameters.CarbonTax_Diff_IC;
	end
case "AMS"
	// assumption: catching-up of EU-ETS and domestic carbon tax
	parameters.CarbonTax_Diff_IC = ones(CarbonTax_Diff_IC);
	// update of emission coefficients due to bio penetration 
	Deriv_Exogenous.Emission_Coef_C = Emission_Coef_C;
	Deriv_Exogenous.Emission_Coef_IC = Emission_Coef_IC;
	Deriv_Exogenous.Emission_Coef_C(Indice_Gaz,:) = (1-penetration_rate(1))*Emission_Coef_C(Indice_Gaz,:);
	Deriv_Exogenous.Emission_Coef_IC(Indice_Gaz,:) = (1-penetration_rate(1))*Emission_Coef_IC(Indice_Gaz,:);
	Deriv_Exogenous.Emission_Coef_C(Indice_Carb,:) = (1-penetration_rate(2))*Emission_Coef_C(Indice_Carb,:);
	Deriv_Exogenous.Emission_Coef_IC(Indice_Carb,:) = (1-penetration_rate(2))*Emission_Coef_IC(Indice_Carb,:);
	select time_step
	case 1 then
		parameters.Carbon_Tax_rate = 225*1e3;
	case 2 then
		parameters.Carbon_Tax_rate = 600*1e3;
		// additional energy tax: price signal for biomass scarcity
		Energy_Tax_rate_sup = 232.6;
		Energy_Tax_rate_sup_IC = zeros(BY.Energy_Tax_rate_IC);
		Energy_Tax_rate_sup_IC(Indice_EnerSect) = Energy_Tax_rate_sup;
		Deriv_Exogenous.Energy_Tax_rate_IC = BY.Energy_Tax_rate_IC + Energy_Tax_rate_sup_IC;
		Energy_Tax_rate_sup_FC = zeros(BY.Energy_Tax_rate_FC);
		Energy_Tax_rate_sup_FC(Indice_EnerSect) = Energy_Tax_rate_sup;
		Deriv_Exogenous.Energy_Tax_rate_FC = BY.Energy_Tax_rate_FC + Energy_Tax_rate_sup_FC;
	end
end
/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
// capital and labour intensities of production
/////////////////////////////////////////////////////////////////////////////////
// NB: from BU expertise or outside calculation using sigma_KL-E on K (Construction + Industries) or L (Agriculture)
select Scenario_temp
case "AME"
	select time_step 
	case 1 then
		parameters.phi_K(Indice_Elec) = -0.0124576;	
		parameters.phi_K(Indice_Heat) = 0.0066989;
		parameters.phi_K(7:10) = [-0.0088444	-0.0062498	-0.0057102	-0.0034528];
		parameters.phi_K(Indice_TerTransp) = [-0.0080829	-0.0168043];
		parameters.phi_L(Indice_Agri) =  0.0143043; 
		parameters.phi_K(Indice_Immo) = -0.0208056;
		parameters.phi_K(nb_Sectors) = -0.0159105;

	case 2 then
		parameters.phi_K(Indice_Elec) = -0.0173205;	
		parameters.phi_K(Indice_Heat) = 0.0248238;
		parameters.phi_K(7:10) = [-0.0064919	-0.0029835	-0.0026108	-0.0006726];
		parameters.phi_K(Indice_TerTransp) = [-0.0097622	-0.0174599];
		parameters.phi_L(Indice_Agri) = 	0.0172445;
		parameters.phi_K(Indice_Immo) = -0.014198;
		parameters.phi_K(nb_Sectors) = -0.0106965;
	end

case "AMS"
	select time_step 
	case 1 then
		parameters.phi_K(Indice_Elec) = -0.0186164;	
		parameters.phi_K(Indice_Heat) = -0.0587296;
		parameters.phi_K(7:10) = [-0.0120686	-0.0072547	-0.0066602	-0.0030313];
		parameters.phi_K(Indice_TerTransp) = [-0.0116768	-0.0296089];
		parameters.phi_L(Indice_Agri) = 	0.0128728;
		parameters.phi_K(Indice_Immo) = -0.0215932;
		parameters.phi_K(nb_Sectors) = -0.0177525;

	case 2 then
		parameters.phi_K(Indice_Elec) = -0.0229234;	
		parameters.phi_K(Indice_Heat) = -0.0411437;
		parameters.phi_K(7:10) = [-0.0125368	-0.0045674	-0.0041246	-0.0019489];
		parameters.phi_K(Indice_TerTransp) = [-0.0145488	-0.0296514];
		parameters.phi_L(Indice_Agri) = 	0.0121447;//
		parameters.phi_K(Indice_Immo) = -0.0165052;
		parameters.phi_K(nb_Sectors) = -0.0135263;
	end
end

// put back some phi_K to zero if CCF forcing is applied 
if Scenario == 'AME_desag' | Scenario == 'AMS_desag' then
	if Proj_Vol.Capital_consumption.apply_proj | Proj_Vol.kappa.apply_proj then 
		for elt=1:size(Proj_Vol.Capital_consumption.ind_of_proj)
			parameters.phi_K(Proj_Vol.Capital_consumption.ind_of_proj(elt)(2)) = 0;
		end
	end
end
/////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////
// Additionnal transfers to support HH 
/////////////////////////////////////////////////////////////////////////////////
// InstitAgents							Corporations  		Government  		Households  	RestOfWorld			   
select Scenario_temp
case "AME"
	select time_step 
	case 1 then 
		parameters.LowCarb_Transfers = [21696.000 			-936028.230 		914332.230 		0];
	case 2 then
		parameters.LowCarb_Transfers = [9480.000 			-549380.740 		539900.740 		0];
	end
case "AMS"
	select time_step 
	case 1 then
		parameters.LowCarb_Transfers = [16823.485531064 	-5696089.70453106 	5679266.219 	0];
	case 2 then
		parameters.LowCarb_Transfers = [-6564572.236067200 	-8124784.748932800 	14689356.985 	0];
	end
end

