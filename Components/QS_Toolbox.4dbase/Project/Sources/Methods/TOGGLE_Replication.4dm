//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 06/03/17, 20:19:07
  // ----------------------------------------------------
  // méthode : Toggle_Replication
  // description
  // http://kb.4d.com/assetid=77664
  //
  // paramètres
  // ----------------------------------------------------
  // here is a method that can be used to disable or enable replication on every table in the database
  //
  //
  // Toggle_Replication (True)  // enable replication on all tables
  // toggle_Replication (False) // disable replication on all tables
  //

C_BOOLEAN:C305($1)
C_LONGINT:C283($a)
C_TEXT:C284($toggle;$SQLCommands)

If (Count parameters:C259=1)
	
	$toggle:=Choose:C955($1;"ENABLE";"DISABLE")
	
	For ($a;1;Get last table number:C254)
		
		  // loop over all valid table number
		
		If (Is table number valid:C999($a))
			
			  // table number is valid (not deleted)
			$SQLCommands:="ALTER TABLE ["+Table name:C256($a)+"] "+$toggle+" REPLICATE;"
			
			Begin SQL
				EXECUTE IMMEDIATE :$SQLCommands;
			End SQL
			
		End if 
	End for 
End if 
