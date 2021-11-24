// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 29/03/16, 14:04:08
// ----------------------------------------------------
// Méthode : DlgTraductions.BouPlus
// Description
//
//
// Paramètres
// ----------------------------------------------------


If (PUMTraduc=5)  // Seulement pour les textes
	READ WRITE:C146([DiaData:45])
	QUERY:C277([DiaData:45]; [DiaData:45]XNom:1="TbTraducTexte"; *)
	QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="TbTra")
	ZVariableVersBlob(->[DiaData:45]XBlob:11; ->Colonne1; ->Colonne2; ->Colonne3)
	// actualisation des tableaux de traductions des textes
	OB SET ARRAY:C1227([DiaData:45]XObjet:15; "TbRefTexte"; Colonne4)
	OB SET ARRAY:C1227([DiaData:45]XObjet:15; "TbTexteF"; Colonne1)
	OB SET ARRAY:C1227([DiaData:45]XObjet:15; "TbTexteE"; Colonne2)
	OB SET ARRAY:C1227([DiaData:45]XObjet:15; "TbTexteR"; Colonne3)
	COPY ARRAY:C226(Colonne1; <>TbTexteF)  //  texte en français
	COPY ARRAY:C226(Colonne2; <>TbTexteE)  //  texte en en anglais
	COPY ARRAY:C226(Colonne3; <>TbTexteR)  //  texte en en russe
	COPY ARRAY:C226(Colonne4; <>TbRefTexte)  //  texte en de référence
	SAVE RECORD:C53([DiaData:45])
	ZAmnistiePartielle(->[DiaData:45])
	
End if 