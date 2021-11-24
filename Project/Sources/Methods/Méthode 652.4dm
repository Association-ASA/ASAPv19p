//%attributes = {"lang":"fr"}
$H:=ASAPTrouveDerNumLabo
//$Doc:=Ouvrir document("";Mode lecture)
//RECEVOIR PAQUET($Doc;$Ligne;<>ZCR)  // ET
//RECEVOIR PAQUET($Doc;$Ligne;<>ZCR)  // 1ere ligne
//LECTURE ÉCRITURE([XData])
//CHERCHER([XData];[XData]XType="FichiersAC")
//SÉLECTION VERS TABLEAU([XData]XNom;$TbNom;[XData]XDate;$TbDate;[XData]XValeur;$TbOcc)
//Tant que ($Ligne#"")
//TABLEAU TEXTE($TbLigne;0)
//ZTexteVersTableau ($Ligne;->$TbLigne;<>ZTab)
//$NomAC:=$TbLigne{1}
//$L:=Chercher dans tableau($TbNom;$NomAC)
//$TbDate{$L}:=Date($TbLigne{2})
//$TbOcc{$L}:=Num($TbLigne{3})
//RECEVOIR PAQUET($Doc;$Ligne;<>ZCR)
//Fin tant que 
//TABLEAU VERS SÉLECTION($TbDate;[XData]XDate;$TbOcc;[XData]XValeur)
//ZAmnistiePartielle (->[XData])

// DiaImporteTable (->[DiaData];Faux)

//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="70a";*)
//CHERCHER PAR ATTRIBUT([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"Sauvage";#;Null)
//$doc:=Sélectionner document("";"";"Quel doc ??";0)

//Yv18Zipf (document;document+".zip";"";Vrai)

//C_ENTIER LONG($Salé;1;$FT)
//LECTURE ÉCRITURE([CampagneParticipations])
//CHERCHER([CampagneParticipations];[CampagneParticipations]NumCampagne="@A")
//$FT:=Enregistrements trouvés([CampagneParticipations])
//Boucle ($Salé;1;$FT)
//CHERCHER([CampagneGelGermes];[CampagneGelGermes]UUIDParticipation=[CampagneParticipations]UUID)
//Si (Enregistrements trouvés([CampagneGelGermes])=0)
//SUPPRIMER ENREGISTREMENT([CampagneParticipations])
//Fin de si 
//ENREGISTREMENT SUIVANT([CampagneParticipations])
//Fin de boucle 



//Si (Macintosh commande enfoncée)
//TRACE
//Fin de si 
//CHERCHER PAR ATTRIBUT([Personnes];[Personnes]Arguments;"BoiteIsotherme";"#";Null)

//  //$proc:=EXÉCUTER SUR CLIENT("@";"Méthode Tests")