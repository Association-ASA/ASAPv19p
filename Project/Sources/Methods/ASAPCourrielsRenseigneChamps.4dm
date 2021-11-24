//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 15/01/19, 14:58:14
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : ASAPCourrielsRenseigneChamps
// Description
// Méthode qui remplit les variables de courriel

If (Count parameters:C259=0)
	$L:=Find in array:C230(<>TbPerUUID; [Personnes:12]UUID:1)
Else 
	$L:=Find in array:C230(<>TbPerUUID; $1)
End if 
VarNomLong:=<>TbPerNomLong{$L}
VarAdressePerso:=<>TbPerAdrPerAd1{$L}\
+(Num:C11(<>TbPerAdrPerAd2{$L}#"")*(<>ZCR+<>TbPerAdrPerAd2{$L}))\
+(Num:C11(<>TbPerAdrPerAd3{$L}#"")*(<>ZCR+<>TbPerAdrPerAd3{$L}))\
+(Num:C11(Length:C16(<>TbPerAdrPerCP{$L}+<>TbPerAdrPerVille{$L})>0)*(<>ZCR+<>TbPerAdrPerCP{$L}+"-"+<>TbPerAdrPerVille{$L}))\
+(Num:C11(<>TbPerAdrPerPays{$L}#"")*(<>ZCR+<>TbPerAdrPerPays{$L}))

VarAdressePro:=<>TbPerAdrProAd1{$L}\
+(Num:C11(<>TbPerAdrProAd2{$L}#"")*(<>ZCR+<>TbPerAdrProAd2{$L}))\
+(Num:C11(<>TbPerAdrProAd3{$L}#"")*(<>ZCR+<>TbPerAdrProAd3{$L}))\
+(Num:C11(Length:C16(<>TbPerAdrProCP{$L}+<>TbPerAdrProVille{$L})>0)*(<>ZCR+<>TbPerAdrProCP{$L}+"-"+<>TbPerAdrProVille{$L}))\
+(Num:C11(<>TbPerAdrProPays{$L}#"")*(<>ZCR+<>TbPerAdrProPays{$L}))

VarAdresseLivraison:=<>TbPerAdrLivAd1{$L}\
+(Num:C11(<>TbPerAdrLivAd2{$L}#"")*(<>ZCR+<>TbPerAdrLivAd2{$L}))\
+(Num:C11(<>TbPerAdrLivAd3{$L}#"")*(<>ZCR+<>TbPerAdrLivAd3{$L}))\
+(Num:C11(Length:C16(<>TbPerAdrLivCP{$L}+<>TbPerAdrLivVille{$L})>0)*(<>ZCR+<>TbPerAdrLivCP{$L}+"-"+<>TbPerAdrLivVille{$L}))\
+(Num:C11(<>TbPerAdrLivPays{$L}#"")*(<>ZCR+<>TbPerAdrLivPays{$L}))
If (<>TbPerTypePersonne{$L}="laboratoire")
	VarAdresse:=VarAdresseLivraison
Else 
	VarAdresse:=VarAdressePerso
End if 
VarNumAdhérent:=<>TbPerNumPersonne{$L}
VarMdPAdhérent:=<>TbPAMotDePasse{$L}
VarNumRAEMA:=String:C10(<>TbPerNumLaboRAEMA{$L})
VarMdpRAEMA:=<>TbPerIdentificateur{$L}
VarDateJour:=String:C10(Current date:C33; 3)
VarCivilités:=<>TbPACivilités{$L}
VarPrénom:=<>TbPAPrénom{$L}
VarNomContact:=<>TbPANomContact{$L}
VarNumTelContact:=<>TbPATelephoneContact{$L}
VarNumFaxContact:=<>TbPAFaxPro{$L}
VarMailPerso:=<>TbPAEMail{$L}
VarMailInfo:=<>TbPAEMail{$L}
VarMailRapport:=<>TbPAEmailRAEMA{$L}
VarMailCompta:=""
VarCPLivraison:=<>TbPerAdrLivCP{$L}
VarVilleLivraison:=<>TbPerAdrLivVille{$L}
VarPaysLivraison:=<>TbPerAdrLivPays{$L}
VarPaysFacturation:=<>TbPerAdrFacPays{$L}
VarProforma:=<>TbPAProforma{$L}

If (VarProforma#"")
	VarNumURLProforma:=<>TbPAURLProforma{$L}
End if 
If (MailAdherent=False:C215)
	$L2:=Find in array:C230(TbUUIDFacMail; <>TbPerUUID{$L})
	If ($L2>0)
		VarNumFacture:=TbNumFacMail{$L2}
		VarMontantFacture:=String:C10(TbTTCFacMail{$L2}; "### ### ##0.00€")
		VarAdresseFacture:=TbAdrFacMail{$L2}
		VarDateFacturation:=String:C10(TbDateFacMail{$L2}; 3)
		$NumFacture_:=Replace string:C233(VarNumFacture; "/"; "_")
		VarURLFacture:="https://association.asa-spv.fr/PDF/Factures/"+String:C10(VarNumAdhérent)+"/"+$NumFacture_+".pdf"
	Else 
		VarNumFacture:=""
		VarMontantFacture:=""
		VarAdresseFacture:=""
		VarDateFacturation:=""
	End if 
End if 
//VarNumFacture:=[Factures]NumFacture
//VarMontantFacture:=Chaîne([Factures]TotalTTC;"### ### ##0.00€")
//VarAdresseFacture:=[Factures]AdresseFacturation
//VarDateFacturation:=Chaîne([Factures]DateFacture;3)
