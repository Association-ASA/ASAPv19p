  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 25/12/12, 18:11:31
  // ----------------------------------------------------
  // Description

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($Txt)
		C_COLLECTION:C1488($copyrights)
		
		$copyrights:=New collection:C1472
		Form:C1466.copyrights:=New collection:C1472
		
		$copyrights.push(New object:C1471("name";"STK - Source ToolKit";"version";"1.0";"licence";"MIT";"site";"http://sources.4d.com/trac/4d_stk"))
		$copyrights.push(New object:C1471("name";"kroki!";"version";"current";"licence";"MIT";"site";"https://kroki.io/"))
		$copyrights.push(New object:C1471("name";"CodeMirror";"version";" 5.44.0";"licence";"MIT";"site";"https://github.com/codemirror/"))
		$copyrights.push(New object:C1471("name";"Nircmd";"version";"2.81";"licence";"freeware";"site";"http://www.nirsoft.net/utils/nircmd.html"))
		$copyrights.push(New object:C1471("name";"User Mode Navigator";"version";"awesome";"licence";"TOOLS";"site";"https://github.com/ThomasMaul"))
		$copyrights.push(New object:C1471("name";"Oviyam";"version";"awesome";"licence";"commercial";"site";"https://www.protee.org/index.php/en/products-en/management-tools/oviyam-en"))
		$copyrights.push(New object:C1471("name";"ogTools";"version";"awesome";"licence";"commercial";"site";"https://www.protee.org/index.php/en/products-en/management-tools/ogtools-for-4d"))
		$copyrights.push(New object:C1471("name";"4D-Forum";"version";"";"licence";"";"site";"http://forums.4d.com/"))
		$copyrights.push(New object:C1471("name";"Keisuke Miyako";"version";"awesome";"licence";"TOOLS";"site";"https://github.com/miyako"))
		$copyrights.push(New object:C1471("name";"Lutz Veith";"version";"awesome";"licence";"";"site";"https://github.com/lveith"))
		Form:C1466.copyrights:=$copyrights
		
		  //$copyrights.push(New object("name";"PHPWord";"version";"0.12.1";"licence";"LGPL version 3";"site";"https://github.com/PHPOffice/PHPWord"))
		  //$copyrights.push(New object("name";"JSON Editor Online";"version";"5.5.2";"licence";"Apache License, Version 2.0";"site";"https://github.com/josdejong/jsoneditor"))
		  //$copyrights.push(New object("name";"Graphviz";"version";"2.36";"licence";"Eclipse Public License";"site";"http://www.graphviz.org/"))
		  //$copyrights.push(New object("name";"jsdifflib";"version";"1.10";"licence";"BSD license";"site";"https://github.com/cemerick/jsdifflib"))
		
		$QS_TBX_SOFTNAME:=Storage:C1525.QS_TBX_SHARED_DATA.SoftName
		
		$txt:=$QS_TBX_SOFTNAME+" find its spirit from 'STK - Source ToolKit', by J. Pupier, 4D SA. Thanks to him."
		$txt:=$txt+"It uses some free or opensource software. The full list is available at the next tab.\r"
		$txt:=$txt+"If you wish to get the source code of one of them, included the original STK, just clic on the weblink to access to the website.\r\r"
		$txt:=$txt+"For some parts of "+$QS_TBX_SOFTNAME+", we take our inspiration:\r"
		$txt:=$txt+"- Get The Code Out and Code Explorer: by J. Pupier\r"
		$txt:=$txt+"- Concept Web export:  from 'Code Analysis component' by Dani Beaubien (Open Road Development)\r"
		$txt:=$txt+"- Analysis & Update Toolbox: from 4D Summit 2013, by Denis Jaeger\r"
		$txt:=$txt+"and ideas from shared code on 4D-Forum. Special thanks to Arnaud de Montard, Keisuke Miyako, Denis Jaeger, Bertrand Soubeyrand, VDL, Mimosa and some others great contibutors.\r"
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"userGuide"))->:="User Guide / Guide Utilisateur"
		(OBJECT Get pointer:C1124(Object named:K67:5;"QS_TBX_CPST_Valid_Until"))->:="Licence valid until "+String:C10(Date:C102(Form:C1466.end);Internal date long:K1:5)
		
		C_TEXT:C284($wa_htmlEditor)
		C_TEXT:C284(Content_t2)
		C_POINTER:C301($wa_p)
		
		$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5;"webComment")
		Content_t2:=File:C1566("/RESOURCES/documentation/releaseNotes.md").getText("UTF-8")
		$wa_htmlEditor:=Convert path system to POSIX:C1106(File:C1566("/RESOURCES/markdown/releaseNotes.html").platformPath)
		WA SET PREFERENCE:C1041($wa_p->;WA enable Web inspector:K62:7;True:C214)
		WA OPEN URL:C1020($wa_p->;"file:///"+$wa_htmlEditor)
		
		OBJECT SET VISIBLE:C603(*;"webComment";True:C214)
		
End case 
