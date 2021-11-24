C_LONGINT:C283($L; $LT)
C_POINTER:C301($Pt)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		$Pt:=OBJECT Get pointer:C1124
		$Pt->:=""
		
	: ($evt=Sur après frappe clavier:K2:26)
		$TE:=Get edited text:C655
		$Test:="@"+$TE+"@"
		$LT:=Length:C16(Get edited text:C655)
		$OnATrouvé:=False:C215
		CREATE EMPTY SET:C140([Factures:15]; "Res")
		//Si (Chaîne(Num($TE))=$TE)  // on a saisi un nombre
		////$L:=Chercher dans tableau(<>TbPerNumLaboRAEMA;Num($TE))
		//CHERCHER([Factures];[Factures]NumFacture=Num($TE))
		//  //Si ($L>0)
		//Si (Enregistrements trouvés([Factures])>0)
		//ALLER À ENREGISTREMENT([Factures];<>TbPerNumEnr{$L})
		//$OnATrouvé:=Vrai
		//ADJOINDRE ÉLÉMENT([Factures];"Res")
		//Fin de si 
		//Fin de si 
		
		If ($LT>1)  // deux caractères tapés
			QUERY:C277([Factures:15]; [Factures:15]ChampRecherche:11=$Test)
			$OnATrouvé:=(Records in selection:C76([Factures:15])>0)
			CREATE SET:C116([Factures:15]; "Res2")
			UNION:C120("Res"; "Res2"; "Res")
		End if 
		If ($OnATrouvé)
			USE SET:C118("Res")
			CLEAR SET:C117("Res")
			CLEAR SET:C117("Res2")
			ASAPFabriqueTbFactures
			//ZFenetreActualiseTitre
			ZLBMFListes
			ZNbEnr:=Size of array:C274(TbNumEnr)
			VarPiedTotal:="TOTAL"
			ZFenetreActualiseTitre(True:C214)
			//OBJET FIXER VISIBLE(PUMNumCampagneSuivi;(ZAvantProc#"@Adh"))
			OBJECT SET VISIBLE:C603(PUMNumCampagneSuivi; False:C215)
			
		End if 
End case 

