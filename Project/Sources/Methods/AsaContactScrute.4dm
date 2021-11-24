//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 05/12/14, 08:14:06
// ----------------------------------------------------
// Méthode : AsaContactScrute
// Description
// scrute la dropBox 
// les éléments de gestion de téléchargement d'AsaDia
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
$DossierAC:=<>PermCheDropBox+"AsaContact"+Séparateur dossier:K24:12
ARRAY TEXT:C222($TbNomFicPdf; 0)
DOCUMENT LIST:C474($DossierAC; $TbNomFicPdf)
SORT ARRAY:C229($TbNomFicPdf; <)

// récupération des occurrences
QUERY:C277([XData:1]; [XData:1]XNom:2="WebAsaContact@")
SELECTION TO ARRAY:C260([XData:1]XNom:2; $TbOccNomAC; [XData:1]XEntier:6; $TbOccNbAC)

READ WRITE:C146([XData:1])
QUERY:C277([XData:1]; [XData:1]XType:3="FichiersAC")
SELECTION TO ARRAY:C260([XData:1]XNom:2; $TbNumAC)
$FT:=Size of array:C274($TbNomFicPdf)

For ($Salé; 1; $FT)
	$NomFichierCourant:=$TbNomFicPdf{$Salé}
	If ($NomFichierCourant="asac@")
		$NumAC:=Num:C11($NomFichierCourant)
		$Source:=$DossierAC+$NomFichierCourant
		If (Find in array:C230($TbNumAC; $NomFichierCourant)<0)
			GET DOCUMENT PROPERTIES:C477($Source; $verrouillé; $invisible; $crééle; $crééà; $modifiéle; $modifiéà)
			CREATE RECORD:C68([XData:1])
			[XData:1]XNom:2:=$NomFichierCourant
			[XData:1]XType:3:="FichiersAC"
			[XData:1]XEntier:6:=$NumAC
			[XData:1]XDate:4:=$modifiéle
		Else 
			QUERY:C277([XData:1]; [XData:1]XNom:2=$NomFichierCourant)
		End if 
		$Test:="WebAsaContact"+String:C10($NumAC)
		$L:=Find in array:C230($TbOccNomAC; $Test)
		If ($L>0)
			[XData:1]XValeur:7:=$TbOccNbAC{$L}
		End if 
		SAVE RECORD:C53([XData:1])
		
		If (Test path name:C476($Source)=Est un document:K24:1)
			$Cible:=<>PermCheDosPdf+"AsaContact"+Séparateur dossier:K24:12+"Aco"+[XData:1]UUID:1+".pdf"
			If (Test path name:C476($Cible)#Est un document:K24:1)
				COPY DOCUMENT:C541($Source; $Cible)
			End if 
		End if 
	End if 
End for 
ZAmnistiePartielle(->[XData:1])

