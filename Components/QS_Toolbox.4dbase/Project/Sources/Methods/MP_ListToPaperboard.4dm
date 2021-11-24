//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 28/02/19, 18:08:15
  // Paramètres
  // ----------------------------------------------------
  // {$1} : Boolean, if passed, then export all information
  // ----------------------------------------------------
  // Méthode : MP_ListToPaperboard
  // Description
  // 

C_OBJECT:C1216($ent)
C_TEXT:C284($out_t)
C_BOOLEAN:C305($all)

$all:=False:C215
If (Count parameters:C259>0)
	$all:=True:C214
End if 

$out_t:="Method list from "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName+": "+String:C10(Date:C102(Current date:C33))+" @ "+String:C10(Current time:C178)+"\r"

If (Form:C1466.methodSelected.length=0)
	Form:C1466.methodSelected:=Form:C1466.listboxDisplayed
End if 

Case of 
	: ($all)
		
		$out_t:=$out_t+"\rMethod name\tAttr. Invisible\tAttr. On Server\t"
		$out_t:=$out_t+"Attr. Shared\tAttr. Web\tAttri. SOAP\t"
		$out_t:=$out_t+"Attr. WSDL\tAttr. SQL\tLast Update\t"
		$out_t:=$out_t+"Nb lines\tNb empty\tNb Comment\t"
		$out_t:=$out_t+"Nb Nested\tComplexity\r"
		
	: (Not:C34($all))
		$out_t:=$out_t+"\rMethod name\tLast update"
End case 

For each ($ent;Form:C1466.methodSelected)
	Case of 
		: ($all)
			
			$out_t:=$out_t+"\r"+$ent.name+"\t"+String:C10($ent.attributes.invisible)+"\t"+String:C10($ent.attributes.executedOnServer)+"\t"
			$out_t:=$out_t+String:C10($ent.attributes.shared)+"\t"+String:C10($ent.attributes.publishedWeb)+"\t"+String:C10($ent.attributes.publishedSoap)+"\t"
			$out_t:=$out_t+String:C10($ent.attributes.publishedWsdl)+"\t"+String:C10($ent.attributes.publishedSql)+"\t"+String:C10(Date:C102($ent.lastUpdate))+"\t"
			$out_t:=$out_t+String:C10($ent.nbLines)+"\t"+String:C10($ent.nbEmpty)+"\t"+String:C10($ent.nbComment)+"\t"
			$out_t:=$out_t+String:C10($ent.nbNested)+"\t"+String:C10($ent.Complexity)
			
		: (Not:C34($all))
			$out_t:=$out_t+"\r"+$ent.name+"\t"+String:C10(Date:C102($ent.lastUpdate))
	End case 
End for each 
SET TEXT TO PASTEBOARD:C523($out_t)

$out_t:=String:C10(Form:C1466.methodSelected.length)+" methods information copied."
displayInfo ($out_t)