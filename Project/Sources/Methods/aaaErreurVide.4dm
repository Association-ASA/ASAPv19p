//%attributes = {}
  //  // TRACE
  //TABLEAU ENTIER LONG($tbCode;0)
  //TABLEAU TEXTE($TabInt;0)
  //TABLEAU TEXTE($TabLib;0)
  //C_ENTIER LONG($i;$erreur)
  //C_TEXTE($PHP_Error_Txt)

  //LIRE PILE DERNIÈRE ERREUR($tbCode;$TabInt;$TabLib)
  //$erreur:=error
  //BEEP
  //$PHP_Error_Txt:=""
  //Boucle ($i;1;Taille tableau($tbCode))
  //$PHP_Error_Txt:=$PHP_Error_Txt+Chaîne($tbCode{​​$i}​​)+" - "+$TabInt{​​$i}​​+" - "+$TabLib{​​$i}​​+Caractère(Retour chariot)
  //Fin de boucle 
  //FIXER TEXTE DANS CONTENEUR($PHP_Error_Txt)