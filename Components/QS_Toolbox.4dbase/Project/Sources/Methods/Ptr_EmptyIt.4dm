//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 07:46:35
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : Ptr_EmptyIt
  // Description
  //  http://forums.4d.com/Post/FR/4942528/1/4942529#4942529

  //Ptr_empty (->obj1{;...;->objN)
C_POINTER:C301(${1})
C_LONGINT:C283($lType;$i)
  //_
For ($i;1;Count parameters:C259)
	If (Not:C34(Is nil pointer:C315(${$i})))
		$lType:=Type:C295(${$i}->)
		
		Case of 
				
			: ($lType=Is text:K8:3) | ($lType=Is alpha field:K8:1) | ($lType=Is string var:K8:2)
				${$i}->:=""
				
			: (($lType=Is real:K8:4) | ($lType=Is integer:K8:5) | ($lType=Is integer 64 bits:K8:25) | ($lType=Is longint:K8:6))
				${$i}->:=0
				
			: ($lType=Is date:K8:7)
				${$i}->:=!00-00-00!
				
			: ($lType=Is boolean:K8:9)
				${$i}->:=False:C215
				
			: ($lType=Is time:K8:8)
				${$i}->:=?00:00:00?
				
			: ($lType=Is picture:K8:10)
				C_PICTURE:C286($im)
				${$i}->:=$im
				
			: ($lType>=Real array:K8:17) & ($lType<=Boolean array:K8:21)  //13 à 22
				If (Size of array:C274(${$i}->)>0)
					DELETE FROM ARRAY:C228(${$i}->;1;Size of array:C274(${$i}->))
				End if 
				
			: ($lType=Is pointer:K8:14)
				C_POINTER:C301($p)
				${$i}->:=$p
				
			: ($lType=Is BLOB:K8:12)
				SET BLOB SIZE:C606(${$i}->;0)
				
			: ($lType=Is object:K8:27)
				${$i}->:=New object:C1471
				
			: ($lType=Is collection:K8:32)
				${$i}->:=New collection:C1472
				
			Else   //indéfinie ou non traité
				C_TEXT:C284($sNomVar)
				C_LONGINT:C283($ltable;$lChamp)
				RESOLVE POINTER:C394(${$i};$sNomVar;$lTable;$lChamp)
				ALERT:C41(Current method name:C684+" type non traité "+String:C10($lType)+"\r"+$sNomVar)
		End case 
		
	End if 
End for 