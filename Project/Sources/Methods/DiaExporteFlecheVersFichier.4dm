//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 29/05/19, 20:27:43
// ----------------------------------------------------
// Méthode : Ad3ExporteFlecheVersFichier
// Description
//   Méthode d'exportation des commentaires des flèches
//   vers un fichier texte de traduction
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
C_BLOB:C604($Blob)
$FT:=Size of array:C274(<>TbDiaposAuteur)
$Rapport:="N°"+<>ZTab+"Rang"+<>ZTab+"Français"+<>ZTab+"Anglais"+<>ZTab+""+<>ZCR
For ($Salé; 1; $FT)
	$Blob:=<>TbDiaposBlobFleches{$Salé}
	If (BLOB size:C605($Blob)>0)
		ARRAY TEXT:C222($TbTb; 0)
		ARRAY TEXT:C222($TbLHT; 0)
		ARRAY INTEGER:C220($TbTCa; 0)
		ZBlobVersVariable(->$Blob; ->$TbTb; ->$TbLHT; ->$TbTCa)
		// Seul le premier blob ($TbTb) contient les flèches qui sont dans 4 premières lignes
		//    type 21 0,895625 0,5909090909091 Dégénérescence graisseuse des reins£fatty degeneration of kidneys
		//    où    21 = type de flèche + espace
		//            0,895625 = % horizontal + espace
		//            0,5909090909091= % vertical + espace
		//            Dégénérescence graisseuse des reins£fatty degeneration of kidneys  = commentaire en Fr (£)+ commentaire en An
		For ($Fumé; 1; 4)
			$Ligne:=$TbTb{$Fumé}
			If ($Ligne#"")
				$Pos:=Position:C15(" "; $Ligne)
				$Ligne:=Substring:C12($Ligne; ($Pos+1))
				$Pos:=Position:C15(" "; $Ligne)
				$Ligne:=Substring:C12($Ligne; ($Pos+1))
				$Pos:=Position:C15(" "; $Ligne)
				$Ligne:=Substring:C12($Ligne; ($Pos+1))
				$Pos:=Position:C15("£"; $Ligne)
				If ($Pos>0)
					$Fr:=Substring:C12($Ligne; 1; ($Pos-1))
					$En:=Substring:C12($Ligne; ($Pos+1))
				Else 
					$Fr:=$Ligne
					$En:=""
				End if 
				$Rapport:=$Rapport+String:C10(<>TbDiaposNumOrdreDiapos{$Salé})+<>ZTab+String:C10($Fumé)+<>ZTab
				$Rapport:=$Rapport+Replace string:C233($Fr; <>ZCR; "")+<>ZTab+Replace string:C233($En; <>ZCR; "")+<>ZTab+<>ZCR
			End if 
		End for 
	End if 
End for 
// FIXER TEXTE DANS CONTENEUR($Rapport)