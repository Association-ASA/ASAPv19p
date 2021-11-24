//%attributes = {"preemptive":"indifferent","executedOnServer":false,"invisible":true,"published4DMobile":{"scope":"none"},"publishedSql":false,"publishedWeb":false,"shared":false,"publishedWsdl":false,"publishedSoap":false}
C_TEXT:C284($1;Content_t2)
C_POINTER:C301($wa_p)

$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5;"webComment")
Content_t2:=""

If (QS_miniVersionR (3))
	METHOD GET COMMENTS:C1189($1;Content_t2;*)
	
	C_TEXT:C284($wa_htmlEditor)
	WA SET PREFERENCE:C1041($wa_p->;WA enable Web inspector:K62:7;True:C214)
	$file:=Convert path system to POSIX:C1106(File:C1566("/RESOURCES/markdown/comment.html").platformPath)
	WA OPEN URL:C1020($wa_p->;"file:///"+$file)
	OBJECT SET VISIBLE:C603(*;"webComment";True:C214)
	
Else 
	WA SET PAGE CONTENT:C1037($wa_p->;"<html><body><h1>In project mode, Comments are avaiblable from 4D v18R3 and upper.</h1></body></html>";"file:///")
	
End if 
