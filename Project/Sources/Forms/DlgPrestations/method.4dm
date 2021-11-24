  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 20/07/19, 17:51:06
  // ----------------------------------------------------
  // Méthode : DlgPrestations
  // Description
  // Méthode qui affiche les tarifs pour le RAEMA Gel actuel
  // dans le formulaire projet DlgPrestations
  // ----------------------------------------------------
$evt:=Form event code:C388

Case of 
	: ($evt=Sur chargement:K2:1)
		  //VarNomAnnee:=Année de(Date du jour)+Num(Mois de(Date du jour)=12)
		VarNomAnnee:=Num:C11(Year of:C25(Current date:C33)+1)
		PrestationAfficheTarif 
		  //PrestationAfficheTarif ("Poudre")
		  //RadioPoudre:=1
End case 

