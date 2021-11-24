//%attributes = {"invisible":true,"preemptive":"indifferent","executedOnServer":false,"publishedSql":false,"publishedWeb":false,"shared":false,"publishedWsdl":false,"publishedSoap":false}
C_POINTER:C301($1)  // pointer to JSON-String

If (Count parameters:C259>=1)
	Content_t:=$1->
Else 
	Content_t:=""
End if 

C_POINTER:C301($wa_p)
$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5; "webZone")
$file:=Convert path system to POSIX:C1106(Folder:C1567(fk resources folder:K87:11).file("codemirror/compare4D/viewJSON.html").platformPath)
// WA SET PREFERENCE($wa_p->;WA enable Web inspector;True)
WA OPEN URL:C1020($wa_p->; "file:///"+$file)