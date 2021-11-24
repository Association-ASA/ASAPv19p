// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 25/12/15, 08:25:13
// ----------------------------------------------------
// Méthode : DlgGestionNotionsBases.ListBoxTextes
// Description
//
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($C; $L)
$evt:=Form event code:C388
LISTBOX GET CELL POSITION:C971(ListBoxTextes; $C; $L)
If ($L>0)
	Case of 
		: ($evt=Sur données modifiées:K2:15)
			GOTO RECORD:C242([DiaTextesWebParagraphes:37]; Colonne4N{Colonne4N})
			[DiaTextesWebParagraphes:37]NiveauTitre:13:=Colonne2N{Colonne4N}
			[DiaTextesWebParagraphes:37]OrdreAffichage:12:=Colonne3N{Colonne4N}
			[DiaTextesWebParagraphes:37]TitreParagraphe:6:=Colonne1{Colonne4N}
			SAVE RECORD:C53([DiaTextesWebParagraphes:37])
			
		: ($evt=Sur nouvelle sélection:K2:29)
			GOTO RECORD:C242([DiaTextesWebParagraphes:37]; Colonne4N{$L})
			VarTexte:=[DiaTextesWebParagraphes:37]CorpsParagraphe:8
			VarNomMotif:=[DiaTextesWebParagraphes:37]MotifSaisie:11
			VarNomLésion:=[DiaTextesWebParagraphes:37]NomLesion:10
			
		: ($evt=Sur double clic:K2:5)
			READ WRITE:C146([DiaTextesWebParagraphes:37])
			GOTO RECORD:C242([DiaTextesWebParagraphes:37]; Colonne4N{$L})
			$F:=Open form window:C675([DiaTextesWebParagraphes:37]; "Saisie")
			MODIFY RECORD:C57([DiaTextesWebParagraphes:37])
			CLOSE WINDOW:C154
			DiaWebTextesAfficheGestion
			
	End case 
End if 