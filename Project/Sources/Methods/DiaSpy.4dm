//%attributes = {}
C_LONGINT:C283($Salé;$FT)
C_OBJECT:C1216($Objet)
READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45];[DiaData:45]XType:5="spy")
If (Records in selection:C76([DiaData:45])=0)
	$FichierAsaDia:=<>PermCheDropBox+"Asadia:asadia2.txt"
	$Doc:=Open document:C264($FichierAsaDia)
	$Tout:=DiaFabriqueTbMin ($Doc;"**6§§")
	  // RECEVOIR PAQUET($Doc;$Tout;$T)  // tout le paquet
	CLOSE DOCUMENT:C267($Doc)
	OB SET ARRAY:C1227($Objet;"emailasa";<>TbMailAsa)
	OB SET ARRAY:C1227($Objet;"emailuti";<>TbMailUtil)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XObjet:15:=OB Copy:C1225($Objet)
	[DiaData:45]XNom:1:="Liste des inscrits"
	[DiaData:45]XType:5:="spy"
End if 
[DiaData:45]XDate:3:=Current date:C33
SAVE RECORD:C53([DiaData:45])
$Objet:=[DiaData:45]XObjet:15
ARRAY TEXT:C222($TbMailAsa;0)
ARRAY TEXT:C222($TbMailUtil;0)
OB GET ARRAY:C1229($Objet;"emailasa";$TbMailAsa)
OB GET ARRAY:C1229($Objet;"emailuti";$TbMailUtil)
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)
DOCUMENT LIST:C474($CD;$TbNomFichier)
$FT:=Size of array:C274($TbNomFichier)
ARRAY TEXT:C222($TbIntrus;0)
ARRAY TEXT:C222($TbPhoto;0)
ARRAY DATE:C224($TbDate;0)
For ($Salé;1;$FT)
	If ($TbNomFichier{$Salé}="photo@") | ($TbNomFichier{$Salé}="npc@")
		$CDF:=$CD+$TbNomFichier{$Salé}
		$Html:=Document to text:C1236($CDF)
		$Pos:=Position:C15("hidden";$Html)
		$Reste:=Substring:C12($Html;$Pos)
		$Pos:=Position:C15("value=";$Reste)
		$Reste:=Substring:C12($Reste;$Pos+7)
		$Pos:=Position:C15(<>ZGuil;$Reste)
		$email:=Substring:C12($Reste;1;($Pos-1))
		If (Find in array:C230($TbMailAsa;$email)<0)
			APPEND TO ARRAY:C911($TbIntrus;$email)
			APPEND TO ARRAY:C911($TbPhoto;$TbNomFichier{$Salé})
			GET DOCUMENT PROPERTIES:C477($CDF;$verrouillé;$invisible;$créé;$crééà;$modifié;$modif)
			APPEND TO ARRAY:C911($TbDate;$créé)
		End if 
	End if 
End for 
$Rapport:=""
$FT:=Size of array:C274($TbIntrus)
For ($Salé;1;$FT)
	$Rapport:=$Rapport+$TbIntrus{$Salé}+<>ZTab+$TbPhoto{$Salé}+<>ZTab+String:C10($TbDate{$Salé})+<>ZCR
End for 
  // FIXER TEXTE DANS CONTENEUR($Rapport)
$0:=$Rapport