
$evt:=Form event code:C388
C_LONGINT:C283($C; $L)
C_TEXT:C284($Espece; $Organe)
LISTBOX GET CELL POSITION:C971(*; "ListBoxVisuAC"; $C; $L)



Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		READ WRITE:C146([DiaData:45])
		GOTO SELECTED RECORD:C245([DiaData:45]; $L)
		CDCourant:=[DiaData:45]XTexte:7
		$Pos:=Position:C15(":Dropbox:"; CDCourant)
		CDCourant:=<>PermCheDropBox+Substring:C12(CDCourant; ($Pos+Length:C16(":Dropbox:")))
		If (Test path name:C476(CDCourant)#Est un document:K24:1) & (Macintosh command down:C546)
			$NomCourant:=Select document:C905(<>PermCheDropBox; "*"; "désignez le fichier souhaité"; 0)
			CDCourant:=document
			[DiaData:45]XTexte:7:=CDCourant
			SAVE RECORD:C53([DiaData:45])
		End if 
		VarComImageP2:=[DiaData:45]XTexteSup:8
		READ PICTURE FILE:C678(CDCourant; VarImageP2)
		$Couleur:=Num:C11(([DiaData:45]XBool:9))*0x00FF0000
		OBJECT SET RGB COLORS:C628(VarComImageP2; $Couleur; 0x00FFFFFF)
		$Espece:=[DiaData:45]XObjet:15.Espèce
		<>PUMEspèce:=Find in array:C230(<>PUMEspèce; $Espece)
		$Organe:=[DiaData:45]XObjet:15.Organe
		<>PUMOrgane:=Find in array:C230(<>PUMOrgane; $Organe)
		VarNomLésionP2:=[DiaData:45]XObjet:15.Lésion
		VarDelaiAbattageP2:=[DiaData:45]XObjet:15.Délai
		VarCommemoratifP2:=[DiaData:45]XObjet:15.Commémoratifs
		VarCommentairesP2:=[DiaData:45]XObjet:15.Commentaires
		VarCheminPhoto:=CDCourant
		OBJECT SET VISIBLE:C603(*; "BouSupPhotos"; (Records in set:C195("$ListboxVisuAC")>0))
		
	: ($evt=Sur double clic:K2:5)
		OPEN URL:C673(CDCourant)
End case 
