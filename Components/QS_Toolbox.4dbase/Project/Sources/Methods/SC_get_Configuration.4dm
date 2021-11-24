//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Patrick
// date et heure : 23/12/11
// ----------------------------------------------------
// méthode : SC_get_Configuration
// description
//
//
// paramètres
// ----------------------------------------------------

C_OBJECT:C1216($infoSystem; $vol; $netwk; $ipAdr; $v)
ARRAY TEXT:C222($tabNoms; 0x0000)
ARRAY REAL:C219($tabValeurs; 0x0000)
ARRAY REAL:C219($tabNombre; 0x0000)
ARRAY TEXT:C222($TabNom; 0x0000)
ARRAY TEXT:C222($TabNomAlt; 0x0000)
ARRAY TEXT:C222($TabModele; 0x0000)
ARRAY TEXT:C222($TabNomPlg; 0x0000)
ARRAY TEXT:C222($TabComposant; 0x0000)
ARRAY TEXT:C222($TabNomCodec; 0x0000)
ARRAY TEXT:C222($TabCodec; 0x0000)
ARRAY LONGINT:C221($TabNum; 0x0000)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

GET MEMORY STATISTICS:C1118(1; $tabNoms; $tabValeurs; $tabNombre)
$infoSystem:=Get system info:C1571

var $obVersion : Object
$obVersion:=New object:C1471
SUPPORT_VersionApplication($obVersion)

$CurrentConfig:="SYSTEM CONFIGURATION\r"
$CurrentConfig:=$CurrentConfig+"System version: "+$infoSystem.osVersion+"\r"

$CurrentConfig:=$CurrentConfig+"4D Version: "+$obVersion.full+"\r"
$CurrentConfig:=$CurrentConfig+"Version type: "+Choose:C955(Version type:C495; "Demo version"; "64 bit version"; "Merged application")+"\r"
$CurrentConfig:=$CurrentConfig+"Computer Name: "+$infoSystem.machineName+"\r"
$CurrentConfig:=$CurrentConfig+"Computer Model: "+$infoSystem.model+"\r"
$CurrentConfig:=$CurrentConfig+"Account: "+$infoSystem.accountName+"\r"
$CurrentConfig:=$CurrentConfig+"User Name: "+$infoSystem.userName+"\r\r"

$CurrentConfig:=$CurrentConfig+"Processor: "+$infoSystem.processor+"\r"
$CurrentConfig:=$CurrentConfig+"Core: "+String:C10($infoSystem.cores)+"\r"
$CurrentConfig:=$CurrentConfig+"CPU Threads: "+String:C10($infoSystem.cpuThreads)+"\r"
$CurrentConfig:=$CurrentConfig+"Physical Memory: "+BASE_bytesToSTR($infoSystem.physicalMemory)+"\r"
$CurrentConfig:=$CurrentConfig+"Started since: "+String:C10(Time:C179($infoSystem.uptime); HH MM SS:K7:1)+"\r\r"

$CurrentConfig:=$CurrentConfig+"VOLUMES INFORMATION\r"
For each ($vol; $infoSystem.volumes)
	$CurrentConfig:=$CurrentConfig+"Mount point: "+$vol.mountPoint+"\r"
	
	If (OB Is defined:C1231($vol; "name"))
		$CurrentConfig:=$CurrentConfig+"Name: "+$vol.name+"\r"
	End if 
	
	
	$CurrentConfig:=$CurrentConfig+"Capacity: "+BASE_bytesToSTR($vol.capacity)+"\r"
	$CurrentConfig:=$CurrentConfig+"Available: "+BASE_bytesToSTR($vol.available)+"\r"
	$CurrentConfig:=$CurrentConfig+"File system: "+$vol.filesystem+"\r"
	
	Case of 
		: (OB Get type:C1230($vol; "disk")=Is collection:K8:32)
			
			For each ($v; $vol.disk)
				$CurrentConfig:=$CurrentConfig+"Size: "+BASE_bytesToSTR($v.size)+"\r"
				$CurrentConfig:=$CurrentConfig+"Description: "+$v.description+"\r"
				$CurrentConfig:=$CurrentConfig+"Identifier: "+$v.identifier+"\r"
				$CurrentConfig:=$CurrentConfig+"Interface: "+$v.interface+"\r"
			End for each 
			
		: (OB Get type:C1230($vol; "disk")=Is object:K8:27)
			$CurrentConfig:=$CurrentConfig+"Size: "+BASE_bytesToSTR($vol.disk.size)+"\r"
			$CurrentConfig:=$CurrentConfig+"Description: "+$vol.disk.description+"\r"
			$CurrentConfig:=$CurrentConfig+"Identifier: "+$vol.disk.identifier+"\r"
			$CurrentConfig:=$CurrentConfig+"Interface: "+$vol.disk.interface+"\r"
	End case 
	$CurrentConfig:=$CurrentConfig+"\r"
	
	
	//$CurrentConfig:=$CurrentConfig+"Size: "+BASE_bytesToSTR ($vol.disk.size)+"\r"
	//$CurrentConfig:=$CurrentConfig+"Capacity: "+BASE_bytesToSTR ($vol.capacity)+"\r"
	//$CurrentConfig:=$CurrentConfig+"Available: "+BASE_bytesToSTR ($vol.available)+"\r"
	//$CurrentConfig:=$CurrentConfig+"File system: "+$vol.filesystem+"\r"
	
	//$CurrentConfig:=$CurrentConfig+"Description: "+$vol.disk.description+"\r"
	//$CurrentConfig:=$CurrentConfig+"Identifier: "+$vol.disk.identifier+"\r"
	//$CurrentConfig:=$CurrentConfig+"Interface: "+$vol.disk.interface+"\r"
	//$CurrentConfig:=$CurrentConfig+"\r"
	
End for each 

$CurrentConfig:=$CurrentConfig+"Network information:\r"
For each ($netwk; $infoSystem.networkInterfaces)
	$CurrentConfig:=$CurrentConfig+"Network Name: "+$netwk.name+"\r"
	$CurrentConfig:=$CurrentConfig+"Network type: "+$netwk.type+"\r"
	
	For each ($ipAdr; $netwk.ipAddresses)
		$CurrentConfig:=$CurrentConfig+"Network Adresse (type): "+$ipAdr.type+"\r"
		$CurrentConfig:=$CurrentConfig+"Network Adresse: "+$ipAdr.ip+"\r"
	End for each 
	$CurrentConfig:=$CurrentConfig+"\r"
End for each 
$CurrentConfig:=$CurrentConfig+"\r"

// *** 2nd PART

$InfoPrinter:=Get current printer:C788
PRINTERS LIST:C789($TabNom; $TabNomAlt; $TabModele)
$InfoListeImprimante:=""

For ($a; 1; Size of array:C274($TabModele); 1)
	$InfoListeImprimante:=$InfoListeImprimante+"Model: "+$TabNom{$a}+"\r"
End for 

PLUGIN LIST:C847($TabNum; $TabNomPlg)
$InfoPlugs:=""

For ($a; 1; Size of array:C274($TabNomPlg); 1)
	$InfoPlugs:=$InfoPlugs+$TabNomPlg{$a}+"\r"
End for 

COMPONENT LIST:C1001($TabComposant)
$InfoComposants:=""

For ($a; 1; Size of array:C274($TabComposant); 1)
	$InfoComposants:=$InfoComposants+$TabComposant{$a}+"\r"
End for 

PICTURE CODEC LIST:C992($TabCodec; $TabNomCodec)
$InfoCODEC:=""

For ($a; 1; Size of array:C274($TabNomCodec); 1)
	$InfoCODEC:=$InfoCODEC+$TabNomCodec{$a}+" Codec: "+$TabCodec{$a}+"\r"
End for 

$CurrentConfig:=$CurrentConfig+"Current printer: "+$InfoPrinter+"\r"
$CurrentConfig:=$CurrentConfig+"Printers list: \r"+$InfoListeImprimante+"\r\r"
$CurrentConfig:=$CurrentConfig+"CODECS list: \r"+$InfoCODEC+"\r\r"
$CurrentConfig:=$CurrentConfig+"Components: \r"+$InfoComposants+"\r\r"
$CurrentConfig:=$CurrentConfig+"Plug-Ins: \r"+$InfoPlugs+"\r\r"

// Fragmentation
$CurrentConfig:=$CurrentConfig+"Tables fragmentation (>5%):\r\r"

For ($i; 1; Get last table number:C254; 1)
	If (Is table number valid:C999($i))
		$Frag:=Get table fragmentation:C1127(Table:C252($i)->)
		If ($Frag>50)
			$CurrentConfig:=$CurrentConfig+"Table: "+Table name:C256($i)+Char:C90(Tab:K15:37)+" Fragmentation: "+String:C10(Round:C94($frag; 1); "#0.0%")+"\r"
		End if 
	End if 
End for 

$CurrentConfig:=$CurrentConfig+"\rMemory state: General information\r\r"

$InfoMemoire1:=""
For ($a; 1; Size of array:C274($tabNoms); 1)
	$InfoMemoire1:=$InfoMemoire1+$tabNoms{$a}+Char:C90(Tab:K15:37)+" Value: "+BASE_bytesToSTR($tabValeurs{$a})+Char:C90(Tab:K15:37)+" Nombre : "+String:C10($tabNombre{$a})+"\r"
End for 

$CurrentConfig:=$CurrentConfig+$InfoMemoire1

If (Version type:C495 ?? 64 bit version:K5:25)
	C_OBJECT:C1216($dbFilter; $cache)
	OB SET:C1220($dbFilter; "dbFilter"; "All")
	
	$CurrentConfig:=$CurrentConfig+"\rCache information \r"
	$cache:=Cache info:C1402($dbFilter)
	
	$InfoMemoire1:="Maximum cache size:"+Char:C90(Tab:K15:37)+" Value: "+BASE_bytesToSTR($cache.maxMem)+"\r"
	$InfoMemoire1:=$InfoMemoire1+"Current cache size:"+Char:C90(Tab:K15:37)+" Value: "+BASE_bytesToSTR($cache.usedMem)+"\r\r"
	
	If ($cache.objects.length>0)
		$InfoMemoire1:=$InfoMemoire1+"Objects details\r"
		
		For each ($obj; $cache.objects)
			
			OB GET PROPERTY NAMES:C1232($obj; $tabProperties; $tabTypes)
			
			For ($a; 1; Size of array:C274($tabProperties))
				Case of 
					: ($tabProperties{$a}="type")
						$InfoMemoire1:=$InfoMemoire1+"Object: "+$obj.type+"\r"
						
					: ($tabProperties{$a}="table")
						$InfoMemoire1:=$InfoMemoire1+"Table: "+$obj.table+"\r"
						
					: ($tabProperties{$a}="database")
						$InfoMemoire1:=$InfoMemoire1+"Database: "+$obj.database+"\r"
						
					: ($tabProperties{$a}="priority")
						$InfoMemoire1:=$InfoMemoire1+"Priority: "+String:C10($obj.priority)+"\r"
						
					: ($tabProperties{$a}="lockersCount")
						$InfoMemoire1:=$InfoMemoire1+"Lockers count: "+String:C10($obj.lockersCount)+"\r"
						
					: ($tabProperties{$a}="lockersBytes")
						$InfoMemoire1:=$InfoMemoire1+"Lockers bytes: "+BASE_bytesToSTR($obj.lockersBytes)+"\r"
						
					: ($tabProperties{$a}="recordsTotalEntries")
						$InfoMemoire1:=$InfoMemoire1+"Records Total Entries: "+String:C10($obj.recordsTotalEntries)+"\r"
						
					: ($tabProperties{$a}="recordsCount")
						$InfoMemoire1:=$InfoMemoire1+"Records count: "+String:C10($obj.recordsCount)+"\r"
						
					: ($tabProperties{$a}="recordsBytes")
						$InfoMemoire1:=$InfoMemoire1+"Records bytes: "+String:C10($obj.recordsBytes)+"\r"
						
					: ($tabProperties{$a}="blobsTotalEntries")
						$InfoMemoire1:=$InfoMemoire1+"Blobs Total Entries: "+String:C10($obj.blobsTotalEntries)+"\r"
						
					: ($tabProperties{$a}="blobsCount")
						$InfoMemoire1:=$InfoMemoire1+"Blobs count: "+String:C10($obj.blobsCount)+"\r"
						
					: ($tabProperties{$a}="blobsBytes")
						$InfoMemoire1:=$InfoMemoire1+"Blobs bytes: "+BASE_bytesToSTR($obj.blobsBytes)+"\r"
				End case 
			End for 
			$InfoMemoire1:=$InfoMemoire1+"\r"
		End for each 
		
	End if 
Else 
	LB_Init_Start($Listbox_Name)
End if 
$CurrentConfig:=$CurrentConfig+$InfoMemoire1

SET TEXT TO PASTEBOARD:C523($CurrentConfig)
$FenetreInformation:="System information ready to be paste."
displayInfo($FenetreInformation)
