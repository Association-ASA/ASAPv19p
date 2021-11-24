//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Méthode : __tool_getTheDoc
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 31/10/19, 17:18:08
  // Paramètres
  // https://forums.4d.com/Post/FR/32300475/1/32300476#32300476
  // From A. deMontard code shared on forum


$referenceLigne:=Pop up menu:C542(New collection:C1472("static documentation";"livedoc";"bugs base").join(";"))
If ($referenceLigne<3)
	$version:=Request:C163("Which version R:")
End if 

$vers_t:=Application version:C493
$version_t:=Substring:C12($vers_t;1;2)
$release_t:=Substring:C12($vers_t;3;1)
$langage_t:=Choose:C955(Command name:C538(1)="Sum";"fe";"fr")

Case of 
		
	: ($referenceLigne=1)
		If ($version#"")
			$url_t:="https://livedoc.4d.com/4D-Langage-18-R"+String:C10(Num:C11($version))+"/4D-Langage.100-4053634."+$langage_t+".html"
		Else 
			$url_t:="https://livedoc.4d.com/home."+$langage_t+".html"
		End if 
		
		OPEN URL:C673($url_t)
		
	: ($referenceLigne=2)  //page langage de livedoc
		If (Command name:C538(1)="Sum")
			OPEN URL:C673("https://livedoc.4d.com/4D-Langage-17-R"+String:C10(Num:C11($version))+"/4D-Langage.100-4053634.fe.html")
		Else 
			OPEN URL:C673("https://livedoc.4d.com/4D-Langage-17-R"+String:C10(Num:C11($version))+"/4D-Langage.100-4053634.fr.html")
		End if 
		
	: ($referenceLigne=3)  //bug base version R suivante
		OPEN URL:C673("https://bugs.4d.fr/fixes?version="+$version_t+Choose:C955(Num:C11($release_t)>0;"_R"+String:C10(Num:C11($version));""))
		
End case 