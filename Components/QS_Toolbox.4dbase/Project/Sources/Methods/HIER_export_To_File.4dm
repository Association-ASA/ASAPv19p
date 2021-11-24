//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  //HIER_Export_to_File ( Liste ) -> Vrai si export réalisé
  //Exporte le contenu d'une liste hiérarchique au format texte tab tab return

C_LONGINT:C283($1;$List)
C_TEXT:C284($lignee)
C_LONGINT:C283($n;$i;$position;$reference)
C_TEXT:C284($libelle)
C_TIME:C306($RefFile)
C_BOOLEAN:C305($0)

$0:=False:C215
$List:=$1

If (Is a list:C621($List))
	LH_openCollapse ($List;True:C214)  // On déploie la liste hiérarchique
	ARRAY TEXT:C222($TabElements;0)
	$n:=Count list items:C380($List)
	For ($i;$n;1;-1)
		SELECT LIST ITEMS BY POSITION:C381($List;$i)
		GET LIST ITEM:C378($List;*;$reference;$libelle)  // * élément courant
		$lignee:=$libelle
		
		Repeat 
			$referenceParent:=List item parent:C633($List;$reference)
			
			If ($referenceParent#0)
				$position:=List item position:C629($List;$referenceParent)
				GET LIST ITEM:C378($List;$position;$reference;$libelle)
				$lignee:=$libelle+Char:C90(Tab:K15:37)+$lignee  //On fait précéder des ancêtres
			End if 
		Until ($referenceParent=0)
		
		APPEND TO ARRAY:C911($TabElements;$lignee)
	End for 
	
	$RefFile:=Create document:C266("")  //fichier texte par défaut
	
	If (OK=1)
		For ($i;Size of array:C274($TabElements);1;-1)
			SEND PACKET:C103($RefFile;$TabElements{$i}+Char:C90(Carriage return:K15:38))
		End for 
		
		CLOSE DOCUMENT:C267($RefFile)
		$0:=True:C214
	End if 
End if 