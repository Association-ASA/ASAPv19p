

//C_LONGINT($Salé; $FT)
//$Endroit:=Select folder("Où mettre les images ??")
//If (OK=1)
//$CouleurOK:=0x00FFFFFF
//$CouleurPos:=0x00DCE6D8
//$CouleurBof:=0x00E6E5C3
//$CouleurSuperBof:=0x00E0D0E6
//$CouleurKO:=0x00E66E72
//$FT:=Size of array(TbChemin)
//For ($Salé; 1; $FT)
//$CC:=TbCouleurFondAdG{$Salé}
//URLCourante:=TbChemin{$Salé}
//$URL:=Replace string(URLCourante; "IMacASA2017HD:Users:asa:"; "MBPASA2015:Users:ASA15:")
//VarRef:=TbRef{$Salé}
//$Largeur:=TbLargeur{$Salé}
//$Hauteur:=TbHaut{$Salé}
//$HV:=(Num($Largeur>=$Hauteur)*"H")+(Num($Largeur<$Hauteur)*"V")
//$TecN:=1+(Num($CC=$CouleurPos))+(Num($CC=$CouleurBof)*2)+(Num($CC=$CouleurSuperBof)*3)+(Num($CC=$CouleurKO)*4)
//$NomFichierCible:=VarRef+" "+$HV+String($TecN)+" "+Uppercase(TbNomLésion{$Salé}[[1]])+Lowercase(Substring(TbNomLésion{$Salé}; 2)+" sur "+TbOrgane{$Salé}+" de "+TbEspèce{$Salé})+".jpg"
//$NouveauCD:=$Endroit+$NomFichierCible
//COPY DOCUMENT($URL; $NouveauCD)
//End for 

//End if 
