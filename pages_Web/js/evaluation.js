 
 $(function() {
  
 
   // Changement du chemin de fer
     suitemodifcdf(); // Changement du chemin de fer
     /*suitemodifp1();*/
     actionquestionnaire(); // actions dans le questionnaire
  

   // LE CHEMIN DE FER
   function suitemodifcdf(){
     $('.imagesurvol').click(function(){modifiechemindefer(this);}); // change le curseur sur survol image
     $('[class$="quizz"]').change(function(){changechampevaluation(this); });// Changement d'une valeur d'un champ
     $('[id^="objectifs"]').change(function(){changeobjectif(this);});      // gestion du clic sur le bouton de présentation en mode Plan
     $('[id^="cbtheme"]').change(function(){changecbtheme(this);});      // gestion du clic sur le bouton de présentation en mode Plan
     $('.imagequizz').click(function(){engrand(this);}); //Agranissement d'une photo
     $('.textareaphoto').change(function(){changechampevaluation(this);});// Changement d'une valeur d'un textarea
     $('[id^="ModePlan"]').click(function(){modeplan(this);});      // gestion du clic sur le bouton de présentation en mode Plan
     $('[id^="ImpQuest"]').click(function(){impquest(this);});      // gestion du clic sur le bouton de présentation en mode Plan
     $('[id^="MdE"]').click(function(){modaliteevaluation(this);}); // Modalités d'évaluation : immédiate ou progressive
     $('[id^="oeil"]').click(function(){montrequestionnaire(this);});  // demande visualisation du questionnaire
     $('[id^="Histoire"]').click(function(){histoirequestionnaire(this);});  // demande visualisation des sauvegardes du questionnaire
     $('[id^="Sauvegarde"]').click(function(){sauvequestionnaire(this);});  // demande visualisation des sauvegardes du questionnaire
     $('.champlistephotossup').change(function(){gerephotosup(this);}); // gestion des photos explicatives de la justification de la réponse (merci Laure)
     $('.textareaphotor').change(function(){changecomphotosup(this);}); // gestion des photos explicatives de la justification de la réponse (merci Laure)
     $('[id^="PUM"]').change(function(){changepum(this);}); // gestion des menus locaux espèce et lésion de la P1
     $('[id^="LiPUM"]').change(function(){changelipum(this);}); // gestion des menus locaux des filtres de la P1
     $('.caseko').click(function(){clicko(this);}); // gestion des menus locaux espèce et lésion de la P1
   }
   
    function changepum(lui) {
      var valeuroption = $(lui). children("option:selected"). text();
      var doc = 'quizz'+lui.id+valeuroption;
      var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
      requete.open("post",doc,false);
      requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
      var reponse = requete.responseText;
      $("#champlistephoto").html(reponse);
      suitemodifcdf();
     };
     
     function changelipum(lui) {
      var valeuroption = $(lui). children("option:selected"). text();
      var origine = $('#institution').val()
      var doc = lui.id+"_"+valeuroption+"_"+origine;
      var requete = choixNavigateur();
      requete.open("post",doc,false);
      requete.send(null); 
      var reponse = requete.responseText;
      $("#zonephoto").html(reponse);
      suitemodifcdf(); // Changement du html P1
     };
     
    function clicko(lui) {
     if ($(lui).is(':checked')==true) {
      var uuidphoto = lui.id;
      var mesalerte = "Cliquer sur 'oui' va enlever la photo de la liste"
      $( "#alerte" ).html(mesalerte);
      $( "#alerte" ).attr('title',"ATTENTION");
      $( "#alerte" ).dialog({
       modal: true,
       buttons: {
        oui : function() {
          $( this ).dialog( "close" );
          var doc = 'supphotosup'+uuidphoto;
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null); /* traitée par la méthode QuizzSupPhotoSup */
          /*var reponse = requete.responseText;  */
         $('#tr'+uuidphoto).hide();
           stopPropagation(lui);
         },
           
        non : function() {
          $( this ).dialog( "close" );
          $(lui).attr('checked',false);
        }
       }
      });
      suitemodifcdf();
     };
    };
     
  function modifiechemindefer(lui) {
   if(lui.id.substring(1,2) =="S"){
    var mesalerte = "Cliquer sur 'oui' va supprimer "
    if(lui.id.substring(0,1) =="Q"){
     mesalerte = mesalerte + "la question désignée ET toutes ses réponses"
    }
    else {
     mesalerte = mesalerte + "la réponse désignée"
    }
    $( "#alerte" ).html(mesalerte);
    $( "#alerte" ).attr('title',"ATTENTION");
    $( "#alerte" ).dialog({
     modal: true,
     buttons: {
      oui : function() {
        $( this ).dialog( "close" );
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
       },
         
      non : function() {
        $( this ).dialog( "close" );
      }
     }
    });
   }
   else {
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
  }
    
   function changeobjectif(lui) {
     var contenutextarea = $('#'+lui.id).val();
     var contenutextarea = contenutextarea.replace(/\n/g, '£');
     var doc = 'changeobjectif'+lui.id+'£'+ contenutextarea;
     var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
     requete.open("post",doc,false);
     requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
     var reponse = requete.responseText;  // cas des photos de la question
     $("#cdf").html(reponse);
     suitemodifcdf();
     stopPropagation(lui);
   }
   
  
  function changechampevaluation(lui) {
   var contenutextarea = $('#'+lui.id).val().replace(/\n/g, '£');
   var doc = 'changechampquizz'+lui.id+'£'+contenutextarea;
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
  
  function changecbtheme(lui) {
   var doc = lui.id+'£'+$(lui).is(":checked");
   var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
   requete.open("post",doc,false);
   requete.send(null); /* traitée par la méthode WebQuizzStockeChangement */
   var reponse = requete.responseText;  // cas des photos de la question
   
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
   
   function impquest(lui){
    var doc = lui.id;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode QuizzImprimeQuestionnaire de 4D  */
    var reponse = requete.responseText;
    window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
    stopPropagation(lui);
    stopPropagation(lui);
   }
   
   function modaliteevaluation(lui){
    var tbdoc =$(lui).val()+'_'+lui.id;
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
    window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
    stopPropagation(lui);
   }
   
   
   // gestion du clic sur le bouton de récupération d'une version
  function sauvequestionnaire(lui){
    var doc = lui.id;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null);// Traitement à faire dans Sur Connexion Web (QuizzAfficheSauvegardes)
  }
  
  // gestion du clic sur le bouton de récupération d'une version
  function histoirequestionnaire(lui){
    var doc = lui.id;/* fabrication du message AJAX envoyé à 4D  */
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null);// Traitement à faire dans Sur Connexion Web (QuizzAfficheSauvegardes)
    var reponse = requete.responseText;
    $('body').html(reponse) ;/* Ouverture dans une nouvelle fenêtre */
    $('[id^="bouhistoire"]').click(function(){histoireremplace(this);});  // demande remplacement du questionnaire par sa sauvegarde
  }
   
  function gerephotosup(lui){
   var idchamp = '#'+lui.id;
   var valeurchamp = $(idchamp).val();
   var doc = "photossup"+lui.id+"£"+valeurchamp;
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    var pos = reponse.indexOf('£');
    $(idchamp).val(reponse.substring(0,pos));
    var htmlbloc = reponse.substring(pos+1)
    var idbloc = idchamp.replace('C','B');
    $(idbloc).html(htmlbloc);
    $('.imagequizz').click(function(){engrand(this);}); //Agranissement d'une photo
    suitemodifcdf();
  }
   
   function changecomphotosup(lui){
    var idchamp = '#'+lui.id;
    var valeurchamp = $(idchamp).val().replace(/\n/g, '£');
    var doc = "comsup"+lui.id+"§"+valeurchamp;
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
  }
  
   // UTILISATION du QUESTIONNAIRE
  function actionquestionnaire(){
     $('[id^="repquizz"]').mouseover(function(){debutsurvol(this);}); // Réaction suite au début de survol sur une réponse
     $('[id^="repquizz"]').mouseout(function(){finsurvol(this);}); // Réaction suite à le fin de survol sur une réponse
     $('[id^="repquizz"]').click(function(){clicreponse(this);}); // Réaction suite à un clic sur une réponse
     $("#retour").click(function(){clicretour(this);});    // Réaction suite à un clic sur le bouton suite
     $('[id^="suite"]').click(function(){clicsuite(this);});      // Réaction suite à un clic sur le bouton suite
     $('[id^="boutonenvoimulti"]').click(function(){clicenvoimulti(this);});      // Réaction suite à un clic sur le bouton suite
     $('.imagequizz').click(function(){engrand(this);}); //Agranissement d'une photo
     $('#AjaxDiagnoseF').click(function(){fermefenetre();});
     $('#retourbilan').click(function(){fermefenetre();});
     $('[id^="voirquestion"]').click(function(){revoirquestion(this);});
   }
   
      /* Suite au début de survol d'une réponse */
  function debutsurvol(lui){
    var idsource = '#'+lui.id.replace('rep','im');
    $(idsource).attr('src',"images/reponse.png");
    /*actionquestionnaire();*/
    stopPropagation(lui);
  }
   
    /* Suite au début de survol d'une réponse */
  function finsurvol(lui){
    var idsource = '#'+lui.id.replace('rep','im');
    $(idsource).attr('src',"images/reponsepossible.png");
    /*actionquestionnaire();*/
    stopPropagation(lui);
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
    var doc = "suitequizz"+lui.id+"£"+$('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $('#quizzcorps').html(reponse);
    actionquestionnaire();
    stopPropagation(lui);
  }
  
  
   /* Suite à un clic sur le bouton suite dans le cadre d'une question à choix multiple  */
  function clicenvoimulti(lui){
    var idcasescoche="";      /* Les espèces */
     $('[id^="casequizz"]').each(function(index) {
        if ($(this).is(':checked')==true) {
          idcasescoche=idcasescoche+$(this).attr('id')+',';
         }
      }) ;
    var doc = "multiplelancequizz"+lui.id+"£" + idcasescoche + "£" + $('#quizzsuivi').val();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    $('#quizzcorps').html(reponse);
    actionquestionnaire();
    stopPropagation(lui);
  }
  
   /* Suite à un clic sur le bouton revoir la question  */
  function revoirquestion(lui){
    var doc = lui.id;
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
    var reponse = requete.responseText;
    window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
    actionquestionnaire();
    stopPropagation(lui);
  }
  
  
   function fermefenetre(){
    window.close();
  }
  
 
 
});  // Fin du jQuery

/* initialisation AJAX en fonction du navigateur */

function choixNavigateur() {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
    return new ActiveXObject('Microsoft.XMLHTTP');
    else
    return new XMLHttpRequest();
  }