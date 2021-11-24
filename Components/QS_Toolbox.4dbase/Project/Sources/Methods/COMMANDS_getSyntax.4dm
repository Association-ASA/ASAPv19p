//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$codePreview:="<br/><br/>"
If (Form:C1466.name#"")
	C_COLLECTION:C1488($ent)
	$Language:=Config_getLanguage
	$ent:=Storage:C1525.commands4d.query($Language+" = :1"; Form:C1466.name)
	$codePreview:=HTML_escapeCharacters($ent[0].syntax+("\n"*2)+TOOLS_get_TIPS(Num:C11($ent[0].id)))
End if 

If ($codePreview="<br/><br/>")
	$codePreview:="No information found for '<i>"+Form:C1466.name+"<i/>'."
End if 
WA SET PAGE CONTENT:C1037(*; "webZone"; "<html><body><font face=\"Verdana\" size=\"2\">"+$codePreview+"</font></body></html>"; "")