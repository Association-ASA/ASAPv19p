C_LONGINT:C283($evt)
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ZAmnistieInternationale 
		READ WRITE:C146([DiaTextesWebParagraphes:37])
		
		VarTexte:=[DiaTextesWebParagraphes:37]CorpsParagraphe:8
		
		  // Gestion du PUM des noms de texte
		ALL RECORDS:C47([DiaTextesWeb:38])
		$FT:=Records in selection:C76([DiaTextesWeb:38])
		ARRAY TEXT:C222(PUMTextes;$FT)
		ARRAY LONGINT:C221(TbIDTexte;$FT)
		SELECTION TO ARRAY:C260([DiaTextesWeb:38]TitreTexte:2;PUMTextes;[DiaTextesWeb:38]IDTexteWeb:1;TbIDTexte)
		SORT ARRAY:C229(PUMTextes;TbIDTexte;>)
		$Liste:=""
		
		  //C_ENTIER LONG($Salé;$FT)
		
		  //Boucle ($Salé;1;$FT)
		  //$Liste:=$Liste+chaine(TbIDTexte{$Salé})+<>ZTab+PUMTextes{$Salé}+<>ZCR
		  //Fin de boucle
		  //FIXER TEXTE DANS CONTENEUR($liste)
		PUMTextes:=1
		VarNomGeneral:=PUMTextes{PUMTextes}
		DiaWebTextesAfficheGestion 
		LISTBOX SELECT ROW:C912(ListBoxTextes;0;lk supprimer de sélection:K53:3)
		
		
		ZViderSelectionCourante (->[DiaTextesWebParagraphes:37])
		
		ARRAY TEXT:C222(PUMListe;2)
		PUMListe{1}:="DGAL"
		PUMListe{2}:="ENV"
		PUMListe:=1
		DiaWebTextesListesLesions 
		
		ARRAY TEXT:C222(PUMLes;0)
		OBJECT SET VISIBLE:C603(PUMLes;False:C215)
		
		VarNomMotif:=""
		VarNomLésion:=""
		LIST TO ARRAY:C288("Organe";PUMOrgane)
		
		VarNomLésionPhoto:=""
		VarNomOrganeP:=""
		VarNomEspeceP:=""
		VarNumPhoto:=""
		OBJECT SET VISIBLE:C603(VarPhoto;(VarNumPhoto#""))
		
		  // Page 2
		
		  // Index
		ALL RECORDS:C47([DiaTexteIndex:39])
		SELECTION TO ARRAY:C260([DiaTexteIndex:39]EntreeIndex:2;TbEntreIndex;[DiaTexteIndex:39]DefinitionIndex:3;TbTexteIndex)
		LONGINT ARRAY FROM SELECTION:C647([DiaTexteIndex:39];TbIDIndex)
		SORT ARRAY:C229(TbEntreIndex;TbTexteIndex;TbIDIndex;>)
		VarDetailTexte:=""
End case 
