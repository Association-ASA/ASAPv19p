//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 12/12/15, 10:17:20
  // ----------------------------------------------------
  // Méthode : WebAfficheFleche
  // Description
  // Envoi au Web le type de fleche :
  // flecheadroite.PNG (11) flecheenbas.PNG (21)
  // flecheagauche.PNG (31) flecheenhaut.PNG (41)
  // le % en largeur le % en hauteur et le commentaire de la fleche
  // Paramètre le numéro de la diapo
  // ----------------------------------------------------
$Mess:=$1
$Anglais:=($Mess="@a")

$NumImage:=Num:C11(Substring:C12($Mess;14))  // élimination de "metlesfleches"
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=$NumImage)
ARRAY TEXT:C222(TbTb;0)
ARRAY TEXT:C222(TbTb;4)
$envoi:=""
If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	  // cherche dans le blob la présence d'éléments d'information
	C_LONGINT:C283($Salé;$FT)
	ARRAY TEXT:C222($TbTb;0)
	ARRAY TEXT:C222($TbLHT;0)
	ARRAY TEXT:C222($TbTCa;0)
	ZBlobVersVariable (->[Diapositives:40]BlobFleches:21;->$TbTb;->$TbLHT;->$TbTCa)
	$Rep:=""
	  // Caractéristiques des flèches
	For ($Salé;1;4)
		$Ligne:=$TbTb{$Salé}  // Ligne avec renseignements pour la fleche courante
		  // type de flèche
		$TF:=String:C10($Salé)
		$NomFleche:=(Num:C11($TF="1")*"flecheadroite.PNG")+(Num:C11($TF="2")*"flecheenbas.PNG")
		$NomFleche:=$NomFleche+(Num:C11($TF="3")*"flecheagauche.PNG")+(Num:C11($TF="4")*"flecheenhaut.PNG")
		
		$envoi:=$envoi+$NomFleche  // Début d'envoi
		$Pos:=Position:C15(" ";$Ligne)
		$Extrait:=Substring:C12($Ligne;($Pos+1))  // On enlève les 11 , 21 , 31
		
		$Pos:=Position:C15(" ";$Extrait)
		$X:=Replace string:C233(Substring:C12($Extrait;1;($Pos-1));",";".")  // Pour que JavaScript interprète l'abcisse X comme un nombre
		
		$envoi:=$envoi+";"+$X  // poursuite de l'envoi
		$Extrait:=Substring:C12($Extrait;($Pos+1))  // Raccourcissement
		$Pos:=Position:C15(" ";$Extrait)
		$Y:=Replace string:C233(Substring:C12($Extrait;1;($Pos-1));",";".")  // Pour que JavaScript interprète l'ordonnée Y comme un nombre
		$TexteBulle:=Substring:C12($Extrait;($Pos+1))
		If (Length:C16($TexteBulle)>0)
			If ($TexteBulle[[1]]=<>ZCR)  // Suppression des retour charriot initiaux
				$TexteBulle:=Substring:C12($TexteBulle;2)
			End if 
			  // On tient compte de la langue si # fr ($Anglais=faux)`
			$Pos:=Position:C15("£";$TexteBulle)
			If ($Pos>0)  // permet la conservation du fonctionnement sans traduction
				If ($Anglais)
					$TexteBulle:=Substring:C12($TexteBulle;($Pos+1))
				Else 
					$TexteBulle:=Substring:C12($TexteBulle;1;($Pos-1))
				End if 
			End if 
		End if 
		$envoi:=$envoi+";"+$Y+";"+$TexteBulle+"£"  // Le texte
		
	End for 
	
End if 
  //FIXER TEXTE DANS CONTENEUR($envoi)
WEB SEND TEXT:C677($envoi)
  // flecheadroite.PNG;0.79875;0.4375;Aspect \rbosselé \rdu foie£flecheenbas.PNG;0.435625;0.4640151515151514916;Pus épais, homogène, blanc£flecheagauche.PNG;;;£flecheenhaut.PNG;0.444375;0.4962121212121212155;Abcès sphérique, à coque épaisse£
ZAmnistieInternationale 