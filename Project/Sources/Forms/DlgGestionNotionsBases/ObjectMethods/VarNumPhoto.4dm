  //CHERCHER([Diapositives];[Diapositives]NumOrdreDiapos=Num(VarNumPhoto))
  //Si (Enregistrements trouvés([Diapositives])=0)
  //ALERTE("Désolé, aucune photo n'a "+<>ZGuil+VarNumPhoto+<>ZGuil+" comme numéro")
  //OBJET FIXER VISIBLE(VarPhoto;Faux)
  //VarNomLésionPhoto:=""
  //VarNomOrganeP:=""
  //VarNomEspeceP:=""
  //Sinon 
  //LIEN RETOUR([Diapositives]NumOrdreDiapos)
  //VarPhoto:=[Atlas]Photo
  //VarNomEspeceP:=[Diapositives]Espece
  //VarNomOrganeP:=[Diapositives]Organe
  //VarNomLésionPhoto:=[Diapositives]NomLesion
  //OBJET FIXER VISIBLE(VarPhoto;Vrai)

  //Fin de si 
