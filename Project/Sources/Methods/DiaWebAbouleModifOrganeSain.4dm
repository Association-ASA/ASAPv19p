//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 30/09/21, 07:39:07
// ----------------------------------------------------
// Méthode : DiaWebAbouleModifOrganeSain
// Description
// Méthode qui écrit le HTML de la div pavephotos
//  de la page de description des organes sains
// Paramètre : $1=message AJAX type anatomie + "_" + idespece+ "_" + idorgane
// doc = 'anatomie'+"_"+idespece+"_"+idorgane;
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)

$Mess:=$1  // suppression de "anatomie"
ARRAY TEXT:C222($TbA; 0)
ZTexteVersTableau($Mess; ->$TbA; "_")
$Espece:=Substring:C12($TbA{2}; 6)
$Organe:=Substring:C12($TbA{3}; 6)
Case of 
	: ($Organe="td")
		$Organe:="Tractus digestif"
		
	: ($Organe="Poumonscoeur")
		$Organe:="Poumons et coeur"
		
End case 
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="OrganeSainGibier"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=$Espece)
DISTINCT VALUES:C339([DiaData:45]XTexte:7; $TbOrgane)
SORT ARRAY:C229($TbOrgane; >)
$FT:=Size of array:C274($TbOrgane)
$THTML:=""
For ($Salé; 1; $FT)
	If (Find in array:C230($TbOrgane; $Organe)<0)
		$Checked:=Num:C11($Salé=1)*(" checked="+<>ZGuil+""+<>ZGuil)
		$Organe:=$TbOrgane{1}
	Else 
		$Checked:=Num:C11($TbOrgane{$Salé}=$Organe)*(" checked="+<>ZGuil+""+<>ZGuil)
	End if 
	$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil+" id="+<>ZGuil+"anato"+$TbOrgane{$Salé}+<>ZGuil
	$THTML:=$THTML+" name="+<>ZGuil+"organe"+<>ZGuil+$Checked+" />"+$TbOrgane{$Salé}+"<br />"+<>ZCR
End for 
QUERY SELECTION:C341([DiaData:45]; [DiaData:45]XTexte:7=$Organe)
$THTML:=$THTML+"£"+DiaEcritHTMLPhotoOrganeSain
WEB SEND TEXT:C677($THTML)

