//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($coll)
$coll:=New collection:C1472

C_TEXT:C284($Path)
C_LONGINT:C283($Majeur)
$Majeur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur

$Path:=Get 4D folder:C485(Active 4D Folder:K5:10;*)+"Favorites v"+String:C10($Majeur)+Replace string:C233("/Local/";"/";Folder separator:K24:12)
ARRAY TEXT:C222($LinksDB;0x0000)
DOCUMENT LIST:C474($Path;$LinksDB)

For ($Indice;1;Size of array:C274($LinksDB))
	$Pos:=Position:C15(".4Dlink";$LinksDB{$Indice})
	If ($pos>0)
		$coll.push(New object:C1471("name";$LinksDB{$Indice};"short_name";Substring:C12($LinksDB{$Indice};1;$pos-1)))
	End if 
End for 

Form:C1466.linksdb:=$coll