//%attributes = {"publishedWeb":true}
  // DiaSurChargementDiapo
JAiGrandit:=False:C215
If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	VarComLa:="Photo commentée"
Else 
	VarComLa:="Photo non commentée"
End if 
If (Is new record:C668([Diapositives:40]))
	NouvelleDiapo:=True:C214
	Repeat 
		$NumD:=60000+DiafChercheNuméro ("Dernière diapo à moi-même")
	Until (Find in array:C230(TbNumDiapoExistantes;$NumD)<0)
	[Diapositives:40]NumOrdreDiapos:1:=$NumD
Else 
	NouvelleDiapo:=False:C215
End if 
QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
ARRAY TEXT:C222(PUMSDGAL;0)
$MSDGAL:=[DiaLesions:44]MotifSaisieDGAL:15
$Pos:=Position:C15(<>ZCR;$MSDGAL)
While ($Pos>0)
	APPEND TO ARRAY:C911(PUMSDGAL;Substring:C12($MSDGAL;1;($pos-1)))
	$MSDGAL:=Substring:C12($MSDGAL;($Pos+1))
	$Pos:=Position:C15(<>ZCR;$MSDGAL)
End while 
APPEND TO ARRAY:C911(PUMSDGAL;$MSDGAL)
If ([Diapositives:40]MotifSaisieDGAL:23="")
	[Diapositives:40]MotifSaisieDGAL:23:=$MSDGAL
End if 
If ([Diapositives:40]ReferenceReglementaireUE:27="")
	QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=[Diapositives:40]MotifSaisieDGAL:23)
	[Diapositives:40]ReferenceReglementaireUE:27:=[DiaMotifSaisieDGAL:42]RefRegEuropeenne:5
End if 
$CDNomImage:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
READ PICTURE FILE:C678($CDNomImage;VarImage)

PICTURE PROPERTIES:C457(VarImage;$largeur;$hauteur)
$DP:=([Diapositives:40]NumOrdreDiapos:1>60000) & (Zsupprime)
OBJECT SET VISIBLE:C603(*;"del@";$DP)
VarTailleImageN:=Picture size:C356(VarImage)
PUMRotation:=2
Flip:=False:C215
Tourner:=True:C214
Rotation:=180
  // OBJET FIXER VISIBLE(*;"tourne@";<>QPx)
LIST TO ARRAY:C288("Auteurs";PUMAuteur)
PICTURE PROPERTIES:C457(VarImage;$L;$H)
If ($L>$H)
	PageImage:=2
Else 
	PageImage:=3
End if 

LTL:=Load list:C383("TypeLésion")
If ([Diapositives:40]GrandTypeLesionnel:5="")
	SELECT LIST ITEMS BY POSITION:C381(LTL;0)
Else 
	  // plaçons le PUM Hiérarchique sur la valeur choisie
	NumSElément:=0
	For ($salé;1;6)
		GET LIST ITEM:C378(LTL;$Salé;NumElément;TextElément;RefSousListe)
		If (TextElément="") | ([Diapositives:40]GrandTypeLesionnel:5=TextElément)
			For ($fumé;1;1000)
				GET LIST ITEM:C378(RefSousListe;$fumé;NumSElément;TextSElément)
				If ([Diapositives:40]TypeLesionnelPrecis:6=TextSElément)
					$fumé:=1000
				End if 
			End for 
			$salé:=6
		End if 
	End for 
	SELECT LIST ITEMS BY REFERENCE:C630(LTL;NumSElément)
End if 
ARRAY TEXT:C222(ZdDNL;0)
ARRAY TEXT:C222(ZdDNLR;0)
$NPC:=[Diapositives:40]NPC:14
$Rang:=Position:C15(<>ZCR;$NPC)
While ($Rang>0)
	APPEND TO ARRAY:C911(ZdDNLR;Substring:C12($NPC;1;$Rang-1))
	$NPC:=Substring:C12($NPC;($Rang+1))
	$Rang:=Position:C15(<>ZCR;$NPC)
End while 
If ($NPC#"")
	APPEND TO ARRAY:C911(ZdDNLR;$NPC)
End if 
VarSaisieNomLésion:=""
QUERY:C277([DiaData:45];[DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1);*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="NPC")
VarNumGibier:=OB Get:C1224([Diapositives:40]ObjetDiapo:32;"RefPhotoPrincipaleGibier";Est un texte:K8:3)
