//%attributes = {"lang":"fr"}
// VisMotifSaisie
QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]TypeListe:8="A")
If (<>Boss)
	DiaGereListe(->[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1; "Liste"; "Liste"; "Liste"; "Saisie"; "Saisie"; ""; "")
Else 
	DiaGereListe(->[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1; "Liste"; "Liste"; "Liste"; "Visu"; "Visu"; ""; "")
End if 