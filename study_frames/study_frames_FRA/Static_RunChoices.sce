// Shocking some parameters default values

Carbon_Tax_rate0 = 8e4;
Carbon_Tax_rate1 = 1e5;
Carbon_Tax_rate2 = 3e5;
Carbon_Tax_rate3 = 5e5;

parameters.Carbon_Tax_rate = Carbon_Tax_rate2;

//////// Basic Need  in ktep/UC
BasicNeed = zeros(nb_Sectors,1);
// Put in sectoral parameters 
if AGG_type=="AGG_3Sec"
BasicNeed(Indice_PrimEnerSect) = 1.98232460003744E-04;
BasicNeed(Indice_FinEnerSect) = 3.7891394E-04 ; 
BasicNeed_HH = (BasicNeed .*.ones(1,nb_Households));
end
// Data for Households are in thousand of people
Coef_HH_unitpeople = 10^3;


 if Recycling_Option=="LSBasicNeed_Exo" 
// Only certain classes of HH are exempted 
	if nb_Households==10
	///No exemption for the 20% richer income classes
		parameters.Exo_HH(1,8:10)=0;
	end 
	
	if unique(Exo_HH) == 1
	warning("Exo_HH == 1 for each HH class ; the model is then running in a equivalent config to the LSBasicNeed options: no exemption for the unique HH")
	end
 end
 
	
// Deriv_Exogenous.ConstrainedShare_C(Indice_EnerSect, :) = 0;
// Deriv_Exogenous.ConstrainedShare_C(Indice_EnerSect, :) = parameters.ConstrainedShare_C(Indice_EnerSect, :)./2;
// Deriv_Exogenous.sigma_pC = parameters.sigma_pC.*3;
// Deriv_Exogenous.sigma_ConsoBudget = 0;
// Deriv_Exogenous.pC = pC *1.2;
// Deriv_Exogenous.sigma_X = parameters.sigma_X/4;
// Deriv_Exogenous.sigma_M = parameters.sigma_M/4;


/// Wage indexation
// Deriv_Exogenous.Coef_real_wage_sect = parameters.Coef_real_wage_sect ;
// Deriv_Exogenous.Coef_real_wage_sect = zeros(1,nb_Sectors);
// Deriv_Exogenous.Coef_real_wage_sect(Indice_NonEnerSect) = 1;

 // Deriv_Exogenous.Coef_real_wage_sect =[0,0,0,0,0,0,0.4,0,0.8,0.4,0,0,0.8];
// Deriv_Exogenous.Coef_real_wage_sect =[1,1,1,1,1,0,1,1,1,1,1,1,1];
// Deriv_Exogenous.Coef_real_wage_sect =[0,0,0,0,0,0,1,1,1,1,1,1,1];
// Deriv_Exogenous.Coef_real_wage_sect = Deriv_Exogenous.Coef_real_wage_sect.*1;

//// Parametres import/export
/// pour 3 sexteurs
// NewInd_AllComp = find(Index_Sectors=="AllComp");
// Deriv_Exogenous.sigma_M = parameters.sigma_M;
// Deriv_Exogenous.sigma_X = parameters.sigma_X;

// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) = parameters.sigma_M (NewInd_AllComp)*2;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = parameters.sigma_X (NewInd_AllComp)*2;

// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) =  parameters.sigma_M (NewInd_AllComp) + parameters.sigma_M (NewInd_AllComp)/2;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = parameters.sigma_X (NewInd_AllComp) + parameters.sigma_X (NewInd_AllComp)/2;

// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) = 1.5;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = 2;

// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) = parameters.sigma_M (NewInd_AllComp).*0.5;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = parameters.sigma_X (NewInd_AllComp).*0.5;

// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) = 0.2;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = 0.2;
// Deriv_Exogenous.sigma_M (1,NewInd_AllComp) = parameters.sigma_M (NewInd_AllComp)/1.2;
// Deriv_Exogenous.sigma_X (1,NewInd_AllComp) = parameters.sigma_X (NewInd_AllComp)/1.2;

// Pour le niveau d'AGG_IndEner - Propres calculs et peche au info

// Deriv_Exogenous.sigma_M = [0.00,0.00,0.00,0.50,1.58,1.58,1.58,1.58,1.58,1.58,1.58,1.58,1.58];
// Deriv_Exogenous.sigma_X = [0.00,0.00,0.00,0.00,1.09,0.99,1.09,1.73,1.09,1.79,1.33,1.23,1.15];



// Deriv_Exogenous.sigma_M = [0.00,0.00,0.00,2.00,0.10,0.00,0.10,0.95,0.10,0.89,0.75,1.01,0.77];
// Deriv_Exogenous.sigma_X = [0.00,0.00,0.00,2.00,0.10,0.00,0.10,0.75,0.10,0.81,0.35,0.24,1];


// Deriv_Exogenous.sigma_M = [0.00,0.00,0.00,2.00,0.10,0.00,0.10,0.95,0.10,0.89,0.75,1.01,0.77];
// Deriv_Exogenous.sigma_X = [0.00,0.00,0.00,2.00,0.10,0.00,0.10,0.75,0.10,0.81,0.35,0.24,1];
 // Deriv_Exogenous.sigma_X = [0.00,0.00,0.00,2.00,0.10,0.00,0.10,0.75,0.10,0.81,0.35,0.24,0.16];
// Deriv_Exogenous.sigma_X(Indice_NonEnerSect) = 5*Deriv_Exogenous.sigma_X(Indice_NonEnerSect) ;
// Deriv_Exogenous.sigma_X = 5*Deriv_Exogenous.sigma_X ;

// Paramètre temporelle
// Deriv_Exogenous.time_period = 50 ;

// Elasticité chomage/salaire
// Elasticité du chomage forte ( -0.1 en reférence)
 // Deriv_Exogenous.sigma_omegaU = -0.8 ;
// Elasticité du chomage faible ( -0.1 en reférence)
// Deriv_Exogenous.sigma_omegaU =parameters.sigma_omegaU/8;


// Potentiel de décarbonisation des entreprises fort : les valeurs doivent directement changer dans les dossiers parametres car ils servent au moment du calibrage
// parameters.ConstrainedShare_IC(Indice_EnerSect, :) = 0.4;
// parameters.sigma = parameters.sigma.*2 ;


// Potentiel de décarbonisation des entreprises faible : les valeurs doivent directement changer dans les dossiers parametres car ils servent au moment du calibrage
// parameters.ConstrainedShare_IC(Indice_EnerSect, :) = 0.9;
// parameters.sigma = parameters.sigma./2 ;

// Potentiel de décarbonisation des menages fort : 
// Deriv_Exogenous.ConstrainedShare_C = parameters.ConstrainedShare_C./2
// Deriv_Exogenous.sigma_pC = parameters.sigma_pC.*2 ;

// Potentiel de décarbonisation des menages faible : 
// Deriv_Exogenous.ConstrainedShare_C = parameters.ConstrainedShare_C.*2
// Deriv_Exogenous.sigma_pC = parameters.sigma_pC./2 ;
