 
 $(function() {
  
 
   // Changement du chemin de fer
     suitemodifcdf(); // Changement du chemin de fer
     actionquestionnaire(); // actions dans le questionnaire
  

   // LE CHEMIN DE FER
   function suitemodifcdf(){
     $('.imagesurvol').click(function(){modifiechemindefer(this);}); // change le curseur sur survol image
     $('[class$="quizz"]').change(function(){changechampevaluation(this); });// Changement d'une valeur d'un champ
     $('.imagequizz').click(function(){engrand(this);}); //Agranissement d'une photo
     $('.textareaphoto').change(function(){changechampevaluation(this);});// Changement d'une valeur d'un textarea
     $('[id^="ModePlan"]').click(function(){modeplan(this);});      // gestion du clic sur le bouton de présentation en mode Plan
     $('[id^="MdE"]').click(function(){modaliteevaluation(this);}); // Modalités d'évaluation : immédiate ou progressive
     $('[id^="oeil"]').click(function(){montrequestionnaire(this);});  // demande visualisation du questionnaire
   }
   
  function modifiechemindefer(lui) {
     var doc = 'modifiechemindefer'+lui.id;
     var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
     requete.open("post",doc,false);
     requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
     var reponse = requete.responseText;  // cas des photos de la question
     if(lui.id.charAt(1)==="V")
     {
      $("#detailquestion").html(reponse);
     }
     else{
     $("#cdf").html(reponse);
     }
     suitemodifcdf();
     stopPropagation(lui);
   }
  
  function changechampevaluation(lui) {
   var doc = 'changechampquizz'+lui.id+'£'+$('#'+lui.id).val();
   var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
   requete.open("post",doc,false);
   requete.send(null); /* traitée par la méthode WebQuizzStockeChangement */
   var reponse = requete.responseText;  // cas des photos de la question
   if(reponse !== ""){
    var pos = reponse.indexOf('§');
    if(reponse.substring(0,pos) !==""){
      var htmlchamp = reponse.substring(0,pos);
      var idchamp = '#'+lui.id;
      $(idchamp).val(htmlchamp);
    }
    reponse = reponse.substring(pos+1)
    pos = reponse.indexOf('£');
    var idzonephoto = '#LPP'+reponse.substring(0,pos)
    var htmldiv = reponse.substring(pos+1)
    $(idzonephoto).html(htmldiv)
   suitemodifcdf();
   }
   stopPropagation(lui);
  }
 
  /* CREATION DE LA PHOTO COMPLETE EN GRAND*/
  function engrand(lui){
    var srcimage = $(lui).attr('src');
    var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
    var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
    var doc = 'quizzaffichepleinecran'+srcimage+"_"+largeurf+"_"+hauteurf +"_"+$('#quizzsuivi').val();;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    window.open(reponse); /* Ouverture dans une nouvelle fenêtre */
    stopPropagation(lui);
  }
   
  function modeplan(lui){
    var nomimagea = $(lui).attr('src');
    if(nomimagea.indexOf('haut')>0) {
     var nomimagen = nomimagea.replace('haut','bas');
     $(lui).attr('src',nomimagen);
     $(lui).attr('title','Afficher le mode détaillé');
     $(lui).attr('alt','Afficher le mode détaillé');
     $('[id^="LPP"]').hide();
    }
    else{
     var nomimagen = nomimagea.replace('bas','haut');
     $(lui).attr('src',nomimagen);
     $(lui).attr('title','Afficher le mode Plan');
     $(lui).attr('alt','Afficher le mode Plan');
     $('[id^="LPP"]').show();
    }
     stopPropagation(lui);
   }
   
   function modaliteevaluation(lui){
    var tbdoc =$(lui).val()+'_'+lui.id
    var doc = "modaliteevaluation"+tbdoc;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    stopPropagation(lui);
   }
   
  function montrequestionnaire(lui){
    var doc = "montrequestionnaire"+lui.id;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
    stopPropagation(lui);
   }
   
   // UTILISATION du QUESTIONNAIRE
  function actionquestionnaire(){
     $('[id^="repquizz"]').click(function(){clicreponse(this);}); // Réaction suite à un clic sur u
     $("#retour").click(function(){clicretour(this);});    // Réaction suite à un clic sur le bouton suite
     $('[id^="suite"]').click(function(){clicsuite(this);});      // Réaction suite à un clic sur le bouton suite
     $('[id^="boutonenvoimulti"]').click(function(){clicenvoimulti(this);});      // Réaction suite à un clic sur le bouton suite
     $('.imagequizz').click(function(){engrand(this);}); //Agranissement d'une photo
   }
     /* Suite à un clic sur une réponse*/
  function clicreponse(lui){
    var doc = lui.id+"_"+$('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $("#quizzreponse").html(reponse);
    actionquestionnaire();
    stopPropagation(lui);
  }
  
   /* Suite à un clic sur le bouton retour*/
  function clicretour(lui){
    var doc = "retourquizz"+$('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $('#quizzcorps').html(reponse);
     actionquestionnaire();
     stopPropagation(lui);
  }
  
  /* Suite à un clic sur le bouton suite*/
  function clicsuite(lui){
    var doc = "suitequizz"+$('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $('#quizzcorps').html(reponse);
    actionquestionnaire();
    stopPropagation(lui);
  }
  
  
   /* Suite à un clic sur le bouton suite dans le cadre d'une question à choix multiple*/
  function clicenvoimulti(lui){
   
    var idcasescoche=""      /* Les espèces */
     $('[id^="casequizz"]').each(function(index) {
        if ($(this).is(':checked')==true) {
          idcasescoche=idcasescoche+$(this).attr('id')+',';
         }
      }) ;
    var doc = "multiplelancequizz£" + idcasescoche + "_" + $('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $('#quizzcorps').html(reponse);
    actionquestionnaire();
    stopPropagation(lui);
  }
  
});  // Fin du jQuery

/* initialisation AJAX en fonction du navigateur */

function choixNavigateur() {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
    return new ActiveXObject('Microsoft.XMLHTTP');
    else
    return new XMLHttpRequest();
  }