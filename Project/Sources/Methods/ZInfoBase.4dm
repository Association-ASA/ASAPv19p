//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 03/05/18, 19:47:00
// ----------------------------------------------------
// Paramètres
// Pas de paramètres
// ----------------------------------------------------
// Méthode : ZInfoBase
// Description
//

C_TEXT:C284(<>ZSaintDuJour; <>ZCheminStruture; <>ZCheminData; <>ZTailleBase; <>ZIPbase; <>ZRacineWeb; <>ZDossierActif; <>ZDossierRessources)
C_OBJECT:C1216($Ob)

//$Chem:=ZDocNomFichier(System folder(Desktop); 1)
//<>PermCheDropBox:=$Chem+"Dropbox"+Folder separator
//$OK:=Test path name(<>PermCheDropBox)

<>PermCheDropBox:=Folder:C1567(fk desktop folder:K87:19).folder("Dropbox").platformPath
$ok:=Folder:C1567(fk desktop folder:K87:19).folder("Dropbox").exists

If (<>ZClient)
	QUERY:C277([XData:1]; [XData:1]XNom:2="Passeport"; *)
	QUERY:C277([XData:1];  & [XData:1]XType:3="Papiers")
	$Ob:=[XData:1]XObjet:18
	
	<>ZCheminStruture:=OB Get:C1224($ob; "Structure"; Is text:K8:3)
	<>ZCheminData:=OB Get:C1224($ob; "Data"; Is text:K8:3)
	<>ZTailleBase:=String:C10(Round:C94(OB Get:C1224($ob; "TailleBase"; Is longint:K8:6)/1024/1024; 1))+" Mo"
	<>ZIPbase:=OB Get:C1224($ob; "IP"; Is text:K8:3)
	<>ZRacineWeb:=OB Get:C1224($ob; "RacineWeb"; Is text:K8:3)
	<>ZDossierActif:=OB Get:C1224($ob; "DossierActif"; Is text:K8:3)
	<>ZDossierRessources:=OB Get:C1224($ob; "DossierRessources"; Is text:K8:3)
	
	
Else 
	
	
	<>ZCheminStruture:=Structure file:C489
	<>ZCheminData:=Data file:C490
	<>ZTailleBase:=String:C10(Get document size:C479(Data file:C490)/1024/1024)+" Mo"
	// <>ZIPbase:=ZTrouveIPExterne 
	<>ZIPbase:=""
	<>ZRacineWeb:=Get 4D folder:C485(HTML Root folder:K5:20; *)
	<>ZDossierActif:=Get 4D folder:C485(Active 4D Folder:K5:10; *)
	<>ZDossierRessources:=Get 4D folder:C485(Current resources folder:K5:16; *)
	
	<>PermCheDosPdf:=Get 4D folder:C485(HTML Root folder:K5:20)+"pdf"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosPdf)<0)  // c'est le chemin de dossier des pdf du site Web
		CREATE FOLDER:C475(<>PermCheDosPdf)
	End if 
	
	//$folder:=Folder(fk web root folder).folder("pdf")
	//If ($folder.exists=False)
	//$folder.create()
	//End if 
	//<>PermCheDosPdf:=$folder.platformName
	
	<>PermCheDosRap:=<>PermCheDosPdf+"Rapports"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosRap)<0)  // c'est le chemin de dossier de téléchargement du rapport
		CREATE FOLDER:C475(<>PermCheDosRap)
	End if 
	
	<>PermCheDosFac:=<>PermCheDosPdf+"Factures"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosRap)<0)  // c'est le chemin de dossier de téléchargement du rapport
		CREATE FOLDER:C475(<>PermCheDosFac)
	End if 
	
	<>PermCheDosAtt:=<>PermCheDosPdf+"Attestations"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosAtt)<0)  // c'est le chemin de dossier des attestations du site Web
		CREATE FOLDER:C475(<>PermCheDosAtt)
	End if 
	
	<>PermCheDosProforma:=<>PermCheDosPdf+"Proforma"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosProforma)<0)  // c'est le chemin de dossier de téléchargement des proforma
		CREATE FOLDER:C475(<>PermCheDosProforma)
	End if 
	
	<>PermCheDosTel:=Get 4D folder:C485(HTML Root folder:K5:20)+"Téléchargements"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosTel)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosTel)
	End if 
	
	<>PermCheDosPJCourrielWeb:=Get 4D folder:C485(HTML Root folder:K5:20)+"PJCourriels"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosPJCourrielWeb)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosPJCourrielWeb)
	End if 
	
	If ($ok)
		<>CDDossierEmailsContraries:=<>PermCheDropBox+"synchrobases"+Folder separator:K24:12+"Emails non reçus"+Folder separator:K24:12
		If (Test path name:C476(<>CDDossierEmailsContraries)#Is a folder:K24:2)
			CREATE FOLDER:C475(<>CDDossierEmailsContraries)
		End if 
		
		// Les dossiers pour le RAEMA
		<>PermCheDosRapIni:=<>PermCheDropBox+"synchrobases"+Folder separator:K24:12+"Dossier Rapports"+<>ZSéparateur
		If (Test path name:C476(<>PermCheDosRapIni)<0)  // c'est le chemin de dossier de dépot des rapports
			CREATE FOLDER:C475(<>PermCheDosRapIni)
		End if 
	End if 
	
End if 

If ($ok)
	<>PermCheDosPJCourrielSource:=<>PermCheDropBox+"SynchroBases"+Folder separator:K24:12+"DossierPJCourriels"+Folder separator:K24:12
	If (Test path name:C476(<>PermCheDosPJCourrielSource)<0)  // c'est le chemin de dossier des téléchargements du site Web
		CREATE FOLDER:C475(<>PermCheDosPJCourrielSource)
	End if 
End if 

// Les dossiers pour le Mail
$CAT:=Get 4D folder:C485(Database folder:K5:14)+"Dossier Messages"+<>ZSéparateur
If (Test path name:C476($CAT)<0)  // c'est un chemin de dossier
	CREATE FOLDER:C475($CAT)
End if 
$CAT:=Get 4D folder:C485(Database folder:K5:14)+"Dossier PJ"+<>ZSéparateur
If (Test path name:C476($CAT)<0)  // c'est un chemin de dossier
	CREATE FOLDER:C475($CAT)
End if 




