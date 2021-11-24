  //$evt:=Événement formulaire
  //Au cas ou 
  //: ($evt=Sur chargement)
  //CHERCHER([Diapositives];[Diapositives]MotifSaisieDGAL=[MotifSaisieDGAL]LibelleMotifSaisieDGAL)
  //OBJET FIXER VISIBLE(BouImagesMotif;(Enregistrements trouvés([Diapositives])>0))
  //$FT:=Enregistrements trouvés([Diapositives])
  //TABLEAU ENTIER LONG(TbNumPhotoImagette;$FT)
  //Boucle ($Salé;1;6)
  //CHERCHER([Atlas];[Atlas]NumOrdreDiapo=[Diapositives]NumOrdreDiapos)
  //$Pt:=Pointeur vers("VarImageR"+Chaîne($Salé))
  //Si (Enregistrements trouvés([Atlas])=0)
  //$Pt->:=[Atlas]Photo
  //OBJET FIXER VISIBLE($Pt->;Faux)
  //Sinon 
  //OBJET FIXER VISIBLE($Pt->;Vrai)
  //CRÉER IMAGETTE([Atlas]Photo;$Pt->;285;190;6;16)
  //TbNumPhotoImagette{$Salé}:=[Diapositives]NumOrdreDiapos
  //Fin de si 
  //ENREGISTREMENT SUIVANT([Diapositives])
  //Fin de boucle 
  //Fin de cas 
