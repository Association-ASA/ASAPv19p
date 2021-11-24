//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($name)
C_OBJECT:C1216($signal)
C_TEXT:C284($action_txt)

$txt:="Creation of graphviz document is in progress."
displayInfo ($txt)

$path:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"All Project Methods"+Folder separator:K24:12
$name:=OB Copy:C1225(Form:C1466.methodSelected[0])
$param:=New object:C1471("name";$name;"ext";$action_txt;"path";$path;"window";Current form window:C827)

$signal:=New signal:C1641
CALL WORKER:C1389("QST_job";"Graphviz_neightbouring";$param;$signal)
$signal.wait()
displayInfo ("Graphviz schema creation finished. Check 'All Project Methods' folder to get the schema.")
SHOW ON DISK:C922($path+$name.name+".png")