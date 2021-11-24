//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 26/05/13, 07:01:47
  // ----------------------------------------------------
  // Méthode : DiaWebIdentification
  // Description
  // Méthode declenchée lors de la tentative de login
  // pour l'accès à AsaDia 3 Web
  // Paramètre : {$1} si Langue différente du français
  // ----------------------------------------------------

C_TEXT:C284($Ligne;$THTML)

ARRAY TEXT:C222(TbNoms;0)  // les noms récoltés sur le formulaire Web P1
ARRAY TEXT:C222(TbValeurs;0)  // les valeurs récoltées sur le formulaire Web P1
WEB GET VARIABLES:C683(TbNoms;TbValeurs)  // remplissage des tableaux
If (Size of array:C274(TbValeurs)=0)
	DiaWebEcritPageDepartFr 
Else 
	VarLogin:=TbValeurs{1}  // valeur du seul champ
	QUERY:C277([DiaUtilisateurs:14];[DiaUtilisateurs:14]EmailASA:12=VarLogin)
	  // CHERCHER([DiaUtilisateurs]; & [DiaUtilisateurs]Caduc=Faux)
	If (Records in selection:C76([DiaUtilisateurs:14])=0) & (VarLogin#"@nottingham.ac.uk") & (VarLogin#"@helsinki.fi")
		  // il ne l'a pas trouvé
		Varmail:=VarLogin
		WEB SEND FILE:C619("asadia3webErreur.shtml")  // dialogue d'erreur
	Else 
		If (Count parameters:C259=0)
			$Langue:="F"
		Else 
			$Langue:=$1
		End if 
		DiaWebEcritPageDiagnose ($Langue;True:C214)  // affichage de la page HTML complète, entièrement écrite par 4D
		CREATE RECORD:C68([DiaData:45])  // XDonnees de connexion
		[DiaData:45]XNom:1:=VarLogin
		[DiaData:45]XType:5:="Wad3"
		[DiaData:45]XDate:3:=Current date:C33
		[DiaData:45]XHeure:13:=Current time:C178
		[DiaData:45]XTexte:7:=NavigateurLabo
		[DiaData:45]XAlpha:14:=$Langue
		SAVE RECORD:C53([DiaData:45])
		ZVerrouAttendre (->[DiaUtilisateurs:14])
		If ([DiaUtilisateurs:14]Caduc:13)
			[DiaUtilisateurs:14]Caduc:13:=False:C215
			SAVE RECORD:C53([DiaUtilisateurs:14])
		End if 
	End if 
End if 
ZAmnistieInternationale 
