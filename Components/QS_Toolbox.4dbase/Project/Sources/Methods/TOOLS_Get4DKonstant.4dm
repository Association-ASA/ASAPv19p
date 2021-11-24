//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 04/02/17, 15:33:34
// ----------------------------------------------------
// méthode : TOOLS_Get4DKonstant
// description
// récupère toutes les constantes dans 1 collection
//
// paramètres
// ----------------------------------------------------

var $Lon_constanteValue; $Txt_SourceconstantName; $Txt_TargetconstantName : Text
var $1 : Text
var $index : Integer
var $QS_TBX_4D_Konstants : Collection
ARRAY TEXT:C222($tDom_units; 0x0000)

$QS_TBX_4D_Konstants:=New shared collection:C1527

If (Count parameters:C259=1)
	$Langue:=$1
Else 
	$langue:=Config_getLanguage
End if 

$Txt_path:=FILE_GetRessourceApplication
FOLDER LIST:C473($Txt_path; $tTxt_folders)
$Lon_x:=Find in array:C230($tTxt_folders; "@.lproj")
$Txt_errorMethod:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")

If ($Lon_x>0)
	
	$Txt_path:=$Txt_path+$Langue+".lproj"+Folder separator:K24:12+"4D_Constants"+$Langue+".xlf"
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		$Dom_root:=DOM Parse XML source:C719($Txt_path)
		
		If (OK=1)
			
			// 1 : Liste des thèmes
			// 2 : date
			// 3 : liste des évènements
			// 4 : triggers
			// 5 : type document
			// 6 :  type application (desktop, merged,...)
			// 7 : alignement image
			// 8 : format des heures
			// 9 : is longint, is picture ?
			// 10 : Obsolete : système mac
			// 11 : Liste des mois et des jours de semaine
			// 12 : liste de 12 couleurs de base
			// 13 : liste des touches
			// 14 : statut des process
			// 15 : statut des styles de caractères et feuilles de styles
			// 16 : caractères ASCII
			// 17 : Bit touche commande
			// 18 : évènement souris
			// 19 : Bit ressource heap système
			// 20 : vers {ensemble}, {variablew) ...
			// 21 : données texte ou image
			// 22 : TCP
			// 23 : format de données (BLOB, GZIP, ...)
			// 24 : Choix couleur avant plan, arrière plan, ...
			// 25 : type de chemin, ouverture, ...
			// 26 : plateforme
			// 27 : Dans zone contenu
			// 28 : information fenetre
			// 29 : À la Windows / Texte supplémentaire
			// 30 : Aucun enregistrement courant
			// ...
			
			$n:=200
			$index:=-1
			
			For ($a; 1; $n)
				
				$tDom_units{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit"; $tDom_units)
				
				If (OK=1)
					
					For ($Lon_i; 1; Size of array:C274($tDom_units); 1)
						
						//DOM GET XML ATTRIBUTE BY NAME($tDom_units{$Lon_i};"id";$Lon_constanteValue)
						//$temp:=Substring($Lon_constanteValue;1;Position("_";$Lon_constanteValue)-1)
						//DOM GET XML ATTRIBUTE BY NAME($tDom_units{$Lon_i};"d4:value";$Lon_constanteValue)
						//$Lon_constanteValue:=":K"+$temp+":"+$Lon_constanteValue
						
						DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "id"; $Lon_constanteValue)
						$Lon_constanteValue:=":K"+Replace string:C233($Lon_constanteValue; "_"; ":")
						$last:=Substring:C12($Lon_constanteValue; Length:C16($Lon_constanteValue))
						If (String:C10(Num:C11($last))#$last)
							$Lon_constanteValue:=Substring:C12($Lon_constanteValue; 1; Length:C16($Lon_constanteValue)-1)
						End if 
						
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source"); $Txt_SourceconstantName)
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target"); $Txt_TargetconstantName)
						
						Use ($QS_TBX_4D_Konstants)
							$QS_TBX_4D_Konstants.push(New shared object:C1526(\
								"EN"; $Txt_SourceconstantName; \
								"FR"; $Txt_TargetconstantName; \
								"token"; String:C10($Lon_constanteValue)))
						End use 
					End for 
				End if 
			End for 
			
			DOM CLOSE XML:C722($Dom_root)
			
			Use (Storage:C1525)
				Storage:C1525.constants:=$QS_TBX_4D_Konstants
			End use 
		End if 
	End if 
End if 
ON ERR CALL:C155($Txt_errorMethod)

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 