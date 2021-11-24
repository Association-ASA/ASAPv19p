// ----------------------------------------------------
// Nom utilisateur (OS) : Admin
// Date et heure : 25/10/16, 15:44:27
// ----------------------------------------------------
// Méthode : DlgSuiviReponse.Bouton1
// Description : importe le fichier d'excel de Ghislaine enregistré en texte tabulation
// 
// ----------------------------------------------------
// UTILISER FILTRE("iso-8859-1";1)
// UTILISER FILTRE("Macintosh";1)

//UTILISER FILTRE("Macintosh";1)
//$doc:=Ouvrir document("";Mode lecture)
//Si (ok=1)
//RECEVOIR PAQUET($doc;$ligne;<>ZCR)
//Si ($ligne#"@_@")
//ALERTE("Désolé, le fichier ouvert n'est pas le bon")
//Sinon 
//TABLEAU TEXTE(TbGhislaine;0)
//TABLEAU TEXTE(TbNumLaboGS;0)
//Repeter 
//$pos:=Position(<>ZTAB;$ligne)
//$premièrecellule:=Sous chaîne($ligne;1;$pos-1)
//$pos2:=Position("_";$premièrecellule)
//Si ($pos2=0)
//$NumLabo:=$premièrecellule
//Sinon 
//$NumLabo:=Sous chaîne($premièrecellule;1;$pos2-1)
//Fin de si 
//$ResteLigne:=Remplacer chaîne(Sous chaîne($ligne;$pos+1);Caractère(10);"")
//Si ($NumLabo#"") & ($ResteLigne#(<>ZTab+"@"))
//AJOUTER À TABLEAU(TbNumLaboGS;$NumLabo)
//AJOUTER À TABLEAU(TbGhislaine;$ResteLigne)
//Fin de si 
//RECEVOIR PAQUET($doc;$ligne;<>ZCR)
//$ligne:=Remplacer chaîne($ligne;Caractère(10);"")
//Jusque ($ligne="")
//Fin de si 
//FERMER DOCUMENT($doc)
//Fin de si 
//UTILISER FILTRE(*;1)

// calcul des tableaux similaires pour les données Web
QUERY:C277([WebConnexions:13]; [WebConnexions:13]Campagne:5=VarNumRaema; *)
QUERY:C277([WebConnexions:13];  & [WebConnexions:13]BoolEnvoi:8=True:C214)

//VALEURS DISTINCTES([WebConnexions]CodeConnexion;$TbUUIDLabo)
DISTINCT VALUES:C339([WebConnexions:13]UUIDParticipation:12; $TbUUIDLabo)
$TT:=Size of array:C274($TbUUIDLabo)
SORT ARRAY:C229($TbUUIDLabo; >)

ARRAY TEXT:C222(TbWeb; 0)
ARRAY TEXT:C222(TbNumLaboWeb; 0)
$Rapport:=""
$Fichier:=""

For ($salé; 1; $TT)
	// CHERCHER([WebConnexions];[WebConnexions]CodeConnexion=$TbUUIDLabo{$salé};*)
	QUERY:C277([WebConnexions:13]; [WebConnexions:13]UUIDParticipation:12=$TbUUIDLabo{$salé}; *)
	QUERY:C277([WebConnexions:13];  & [WebConnexions:13]BoolEnvoi:8=True:C214)
	ORDER BY:C49([WebConnexions:13]; [WebConnexions:13]NumEnvoi:9; <)
	$pos:=Position:C15(<>ZTAB; [WebConnexions:13]TextePJ:7)
	$premièrecellule:=Substring:C12([WebConnexions:13]TextePJ:7; 1; ($pos-1))
	$reste:=Substring:C12([WebConnexions:13]TextePJ:7; $pos+1)
	APPEND TO ARRAY:C911(TbNumLaboWeb; $premièrecellule)
	APPEND TO ARRAY:C911(TbWeb; $reste)
	$Fichier:=$Fichier+[WebConnexions:13]TextePJ:7+<>ZCR
End for 

//  // comparaison des tableaux
//COPIER TABLEAU(TbNumLaboGS;$TbGSSeule)

//Boucle ($salé;1;$TT)
//$L:=Chercher dans tableau(TbNumLaboGS;TbNumLaboWeb{$salé})
//Si ($L=-1)  // On n'a pas trouvé le labo dans GS
//  // le labo existe dans le Web mais pas dans GS
//Sinon   // On a trouvé le labo dans GS

//  // Notons qu'on a trouvé de labo
//$L2:=Chercher dans tableau($TbGSSeule;TbNumLaboWeb{$salé})
//SUPPRIMER DANS TABLEAU($TbGSSeule;$L2)

//$ligneGS:=TbGhislaine{$L}
//$ligneWeb:=TbWeb{$salé}
//Si ($ligneGS#$ligneWeb)

//  //FIXER TEXTE DANS CONTENEUR($ligneGS)
//  //FIXER TEXTE DANS CONTENEUR($ligneWeb)
//$Compteur:=1
//Repeter 
//$PosGS:=Position(<>ZTab;$ligneGS)
//$CelluleGS:=Sous chaîne($ligneGS;1;($PosGS-1))
//$ligneGS:=Sous chaîne($ligneGS;($PosGS+1))
//$PosWeb:=Position(<>ZTab;$ligneWeb)
//Si ($PosWeb>0)
//$CelluleWeb:=Sous chaîne($ligneWeb;1;($PosWeb-1))
//Sinon 
//$CelluleWeb:=$ligneWeb
//Fin de si 
//Si ($CelluleWeb="")
//$CelluleWeb:="NaN"
//Fin de si 
//$ligneWeb:=Sous chaîne($ligneWeb;($PosWeb+1))
//$Compteur:=$Compteur+1
//Si ($CelluleGS#$CelluleWeb)
//$Pb:=Vrai
//Si ($CelluleWeb[[1]]="0")  // cas des cases à cocher 
//  // tentative de reformatage
//$Format:="0"*Longueur($CelluleWeb)
//$CelluleGS:=Chaîne(Num($CelluleGS);$Format)
//$Pb:=($CelluleGS#$CelluleWeb)
//Fin de si 
//Si ($Pb)
//$Rapport:=$Rapport+"Labo "+TbNumLaboWeb{$salé}+" Colonne "+Chaîne($Compteur)+" : "+$CelluleGS+" (GS) / "+$CelluleWeb+" (Web)"+<>ZCR
//Fin de si 
//Fin de si 
//Jusque ($PosWeb=0)
//  //Si ($ligneGS#TbWeb{$Compteur+1})
//  //$Rapport:=$Rapport+"Colonne "+chaine($Compteur+1)+" : "+$CelluleGS+" (GS) / "+TbWeb{$Compteur+1}+" (Web)"
//  //fin de si
//  // Le labo existe dans GS et dans le Web mais n'a pas le même contenu
//Fin de si 
//Fin de si 
//Fin de boucle 

//Si (Taille tableau($TbGSSeule)>0)
//$s:=Num(Taille tableau($TbGSSeule)>1)*"s"
//$onta:=(Num(Taille tableau($TbGSSeule)>1)*"ont")+(Num(Taille tableau($TbGSSeule)=1)*"a")
//$Rapport:=$Rapport+<>ZCR2+"ATTENTION : "+Chaîne(Taille tableau($TbGSSeule))+"labo"+$s+" ("+ZTableauVersTexte (->$TbGSSeule;", ")
//$Rapport:=$Rapport+") "+$onta+" été compté"+$s+" plusieurs fois"
//Fin de si 
//FIXER TEXTE DANS CONTENEUR($Rapport)
$CD:=Get 4D folder:C485(Dossier base:K5:14)+"fichierraema.txt"
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
USE CHARACTER SET:C205("ISO-8859-1"; 0)  // Filtre iso-latin
$doc:=Create document:C266($CD)
SEND PACKET:C103($doc; $Fichier)
CLOSE DOCUMENT:C267($doc)
USE CHARACTER SET:C205(*; 0)
OBJECT SET VISIBLE:C603(BouEnvoiFichier; True:C214)
