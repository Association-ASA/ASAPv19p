//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 16/07/16, 16:52:54
  // ----------------------------------------------------
  // Méthode : WebAbouleListeMotif
  // Description
  // Permet au site Web de construire
  // la page des motifs de saisie en français uniquement
  // ----------------------------------------------------



  // le HTML
$THTML:="Motifs de saisie£P3£"
$NomPDF:="Motif"
$THTML:=$THTML+DiaWebCreationHTMLAide ("F";1;$NomPDF)
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">Liste des motifs de saisie</p>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        Pour afficher le détail d'un motif de saisie, cliquez sur l'image du détail de la ligne correspondante<br />"+<>ZCR
$THTML:=$THTML+"      Pour chercher les motifs de saisie qui contiennent une chaine de caractère*, entrez-la dans le champ suivant : <input id="+<>ZGuil+"cherchemotif"+<>ZGuil+" type="+<>ZGuil+"text"+<>ZGuil+" />  <br />"+<>ZCR
$THTML:=$THTML+"      <span class="+<>ZGuil+"textepetit"+<>ZGuil+">     * La recherche se declenche au troisième caractère entré et porte sur le nom du motif, les éléments techniques et réglementaires ainsi que la réponse aux éleveurs.</span><br />"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
If (Gibier)
	QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1>80000)
	  //JOINTURE([Diapositives];[DiaMotifSaisieDGAL])
	DISTINCT VALUES:C339([Diapositives:40]MotifSaisieDGAL:23;$TbMotifsDAL)
	QUERY WITH ARRAY:C644([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;$TbMotifsDAL)
	ORDER BY:C49([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;>)
Else 
	QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]TypeListe:8="a")
End if 
$FT:=String:C10(Records in selection:C76([DiaMotifSaisieDGAL:42]))
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbtotal"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      <input id="+<>ZGuil+"nbactuel"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+$FT+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"listemotif"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+DiaWebCreationHTMLListeMotifs 
$THTML:=$THTML+"      </div>"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"ledetailmotif"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        Cliquer sur l'icône du détail pour obtenir le contenu du motif."+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"boutonbas"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <a href="+<>ZGuil+"pdf/DGAL-ASA_Motif_Retrait.pdf"+<>ZGuil+">Télécharger la liste des motifs de saisie</a>"+<>ZCR
$THTML:=$THTML+"                      "+<>ZCR  // espacement des boutons
$THTML:=$THTML+"        <a href="+<>ZGuil+"pdf/Correspondance.pdf"+<>ZGuil+">Télécharger le fichier de correspondance</a>"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
  // $THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia3.js"+<>ZGuil+"></script>"+<>ZCR

ZAmnistieInternationale 
WEB SEND TEXT:C677($THTML)
  // FIXER TEXTE DANS CONTENEUR($THTML)