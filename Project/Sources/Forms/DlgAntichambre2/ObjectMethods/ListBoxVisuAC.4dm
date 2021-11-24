$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_LONGINT:C283($C;$L)
		C_TEXT:C284($VarValeur)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxVisuAC";$C;$L)
		If ($L>0)
			READ WRITE:C146([DiaData:45])
			GOTO RECORD:C242([DiaData:45];TbNumEnrDia{$L})
			READ PICTURE FILE:C678(<>CDPhotosATraiter+TbFichierDiapo{$L};VarImageP2)
			PICTURE PROPERTIES:C457(VarImageP2;$La;$Ha)
			$TailleA:=String:C10(Round:C94(Picture size:C356(VarImageP2)/1000;0))+"Ko"
			$Com:="Définition réelle : "+String:C10($La)+"x"+String:C10($Ha)
			$DefOpt:=(Num:C11($La>$Ha)*"1871x2835")+(Num:C11($Ha>=$La)*"2835x1871")
			$Com:=$Com+<>ZCR+"Définition optimale : "+$DefOpt
			$RapR:=(Num:C11($La>$Ha)*String:C10(Round:C94($La/$Ha;2)))+(Num:C11($Ha>=$La)*String:C10(Round:C94($Ha/$La;2)))
			$Com:=$Com+<>ZCR+"Rapport réel : "+$RapR
			$Com:=$Com+<>ZCR+"Rapport idéal : 1,5"
			$Com:=$Com+<>ZCR+"Poids : "+$TailleA
			VarComImageAC2:=$Com
			$Couleur:=Num:C11(([DiaData:45]XBool:9))*0x00FF0000
			OBJECT SET RGB COLORS:C628(VarComImageP2;$Couleur;0x00FFFFFF)
			VarDelaiAbattageP2:=OB Get:C1224([DiaData:45]XObjet:15;"Délai";Est un texte:K8:3)
			VarCommemoratifP2:=OB Get:C1224([DiaData:45]XObjet:15;"Commémoratifs";Est un texte:K8:3)
			VarCommentairesP2:=OB Get:C1224([DiaData:45]XObjet:15;"Commentaires";Est un texte:K8:3)
			$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Auteur";Est un texte:K8:3)
			PUMAuteurAC:=Find in array:C230(PUMAuteurAC;$VarValeur)
			$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Espèce";Est un texte:K8:3)
			<>PUMEspèce:=Find in array:C230(<>PUMEspèce;$VarValeur)
			$VarValeur:=OB Get:C1224([DiaData:45]XObjet:15;"Organe";Est un texte:K8:3)
			<>PUMOrgane:=Find in array:C230(<>PUMOrgane;$VarValeur)
			VarNomLésion:=OB Get:C1224([DiaData:45]XObjet:15;"Lésion";Est un texte:K8:3)
			VarCas:=String:C10([DiaData:45]XValeur:4)
		Else 
			DiaAC2Init 
		End if 
End case 
