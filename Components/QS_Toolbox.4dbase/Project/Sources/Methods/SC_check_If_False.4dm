//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 03/04/2019
  // ----------------------------------------------------
  // Méthode : SC_check_If_False
  // Description
  //  Identify all methods in all objects containing this kind of code:
  //
  // if (False) ... end if
  // if (1=2) ... end if
  // if (True)  ... end if                      // What???
  // Begin SQL /* .... */ end SQL
  //
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
C_TEXT:C284($langage;$1;$MethText;$path)
C_COLLECTION:C1488($coll)

$path:=$1
$langage:=Config_getLanguage 
$coll:=New collection:C1472

  // Pattern to detect code set as comment
$Pattern1:="(?si-m)((if \\("+Choose:C955($langage="en";"False";"Faux")+"\\))(.+?)(end if))"
$Pattern2:="(?si-m)((if \\(1=2\\))(.+?)(end if))"
$Pattern3:="(?si-m)((if \\(2=1\\))(.+?)(end if))"
$Pattern4:="(?si-m)((if \\("+Choose:C955($langage="en";"True";"Vrai")+"\\))(.+?)(end if))"
$Pattern10:="(?si-m)(Begin SQL[\\r\\n\\t]*/\\*.+?\\*/[\\r\\n\\t]*End SQL)"

METHOD GET CODE:C1190($path;$MethText;*)

If (REGEX_ExtractText ($Pattern1;$MethText;"1 2 3 4";->$tableau2D;0)=0)
	$coll.push("If (False) ... End if")
End if 

If (REGEX_ExtractText ($Pattern2;$MethText;"1 2 3 4";->$tableau2D;0)=0)
	$coll.push("If (1=2) ... End if")
End if 

If (REGEX_ExtractText ($Pattern3;$MethText;"1 2 3 4";->$tableau2D;0)=0)
	$coll.push("If (2=1) ... End if")
End if 

If (REGEX_ExtractText ($Pattern4;$MethText;"1 2 3 4";->$tableau2D;0)=0)
	$coll.push("If (True) ... End if")
End if 

If (REGEX_ExtractText ($Pattern10;$MethText;"1";->$tableau2D;0)=0)
	$coll.push("Begin SQL /* ... */ End SQL")
End if 
$0:=$coll