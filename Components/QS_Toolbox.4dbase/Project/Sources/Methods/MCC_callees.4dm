//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_BOOLEAN:C305($created)
C_TEXT:C284($local_path; $htmlFile; $fileContent)
C_OBJECT:C1216($file)

Case of 
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd50"))->=1)
		$object:="rd50"
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd51"))->=1)
		$object:="rd51"
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd52"))->=1)
		$object:="rd52"
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd53"))->=1)
		$object:="rd53"
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd54"))->=1)
		$object:="rd54"
	: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd0"))->=1)
		$object:="rd0"
		
End case 

//$local_path:=Get 4D folder(Current resources folder)+"html_d3"+Folder separator
$local_path:=Folder:C1567(fk resources folder:K87:11).folder("html_d3").platformPath

Case of 
	: ($object="RD50") | ($object="RD51") | ($object="RD54")
		$file:=File:C1566("/RESOURCES/html_d3/files/datas.json")
		
	: ($object="RD52") | ($object="RD53")
		$file:=File:C1566("/RESOURCES/html_d3/files/datas.csv")
		
	: ($object="rd0")
		MCC_LH_clicked
		
End case 

If (Num:C11($object)>0)
	$fileContent:=d3_export($object)
	
	If ($file.isFile)
		$file.delete()
	End if 
	$created:=$file.create()
	If ($created)
		$file.setText($fileContent)
	End if 
	
	PROCESS_sleep(15)
	$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5; "webZone")
	$htmlFile:=Convert path system to POSIX:C1106($local_path+Replace string:C233(OBJECT Get title:C1068(*; $object); " "; "_")+".html")
	WA OPEN URL:C1020($wa_p->; "file:///"+$htmlFile)
End if 