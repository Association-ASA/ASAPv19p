//%attributes = {}

  //  // ----------------------------------------------------
  //  // Nom utilisateur : cgm 
  //  // Date et heure : 27/08/18, 17:56:03
  //  // ----------------------------------------------------
  //  // Méthode : WebPanierVoirDescriptif
  //  // Description
  //  // Création du HTML lié à la visualisation du descriptif d'un panier
  //  // Paramètre $1=message Ajax  $2=login
  //  // ----------------------------------------------------
  //Mess:=$1
  //$Pos:=Position("£";$Mess)

  //$NumEnrPanierN:=Num(Sous chaîne($Mess;1;($Pos-1)))
  //$Mess:=Sous chaîne($Mess;($Pos+1))
  //$Pos:=Position("£";$Mess)
  //$NomPanier:=Sous chaîne($Mess;1;($Pos-1))
  //$Mess:=Sous chaîne($Mess;($Pos+1))
  //$Pos:=Position("£";$Mess)
  //$Initiales:=Sous chaîne($Mess;1;($Pos-1))
  //$Descriptif:=Sous chaîne($Mess;($Pos+1))

  //$THTML:=$THTML+"        <br />"+<>ZCR
  //$THTML:=$THTML+"        Précisez les initiales du créateur si vous voulez que ce panier soit identifié comme le sien."+<>ZCR
  //$THTML:=$THTML+"      </span>"+<>ZCR
  //$THTML:=$THTML+"      <input id="+<>ZGuil+"numdiapopanier"+$Rang+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+NumImageA+<>ZGuil+" />"+<>ZCR
  //$THTML:=$THTML+"        <br /><br />"+<>ZCR
  //$THTML:=$THTML+"      <label for="+<>ZGuil+"nompanier"+$Rang+<>ZGuil+">Nom du panier</label> "
  //$THTML:=$THTML+"<input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"nompanier"+$Rang+<>ZGuil+" size="+<>ZGuil+"30"+<>ZGuil
  //$THTML:=$THTML+" maxlength="+<>ZGuil+"30"+<>ZGuil+" value="+<>ZGuil+"30"+<>ZGuil+">"+<>ZCR
  //Si ($FT>0)
  //$THTML:=$THTML+"      <select id="+<>ZGuil+"pumpanier"+$Rang+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"        <option value="+<>ZGuil+"rien"+<>ZGuil+">"+"Sélectionnez un panier </option>"+<>ZCR
  //Boucle ($Salé;1;$FT)
  //$Initialecourante:=$TbInitialesPaniers{$Salé}
  //$Qui:=(Num($Initialecourante="")*" (tous)")+(Num($Initialecourante#"")*(" ("+$Initialecourante+")"))
  //$THTML:=$THTML+"        <option value="+<>ZGuil+Chaîne($TbNumEnrPaniers{$Salé})+<>ZGuil+">"+$TbNomPaniers{$Salé}+$Qui+"</option>"+<>ZCR
  //Fin de boucle 
  //$THTML:=$THTML+"      </select>"+<>ZCR
  //Fin de si 
  //$THTML:=$THTML+"      <br />"+<>ZCR
  //$THTML:=$THTML+"      <label for="+<>ZGuil+"initcreateur"+$Rang+<>ZGuil+">Initiales du créateur</label> "
  //$THTML:=$THTML+"<input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"initcreateur"+$Rang+<>ZGuil+" size="+<>ZGuil+"10"+<>ZGuil+" maxlength="+<>ZGuil+"5"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"      <br />"+<>ZCR
  //$THTML:=$THTML+"      <br />"+<>ZCR
  //$THTML:=$THTML+"      <label for="+<>ZGuil+"companier"+$Rang+<>ZGuil+">Description du panier</label> "
  //$THTML:=$THTML+"<textarea name="+<>ZGuil+""+<>ZGuil+" id="+<>ZGuil+"companier"+$Rang+<>ZGuil+" cols="+<>ZGuil+"60"+<>ZGuil+" rows="+<>ZGuil+"5"+<>ZGuil+"></textarea>"+<>ZCR
  //$THTML:=$THTML+"      <br /> "+<>ZCR
  //$THTML:=$THTML+""+<>ZCR

  //$THTML:=$THTML+"      <button  class="+<>ZGuil+"adtitre2e"+<>ZGuil+" id="+<>ZGuil+"paniersumit"+$Rang+<>ZGuil+">Ajouter au panier</button> "
  //$THTML:=$THTML+"<button  class="+<>ZGuil+"adtitre3e"+<>ZGuil+" id="+<>ZGuil+"panierreset"+$Rang+NumImageA+<>ZGuil+">Ne PAS ajouter au panier</button> "+<>ZCR

  //$0:=$THTML
