 
 $(function() { 
  $('[id^="bouhistoire"]').click(function(){histoireremplace(this);});  // demande remplacement du questionnaire par sa sauvegarde
  function histoireremplace(lui){
   if (lui.id.indexOf("&") > 0){
    var doc = lui.id;
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
    var reponse = requete.responseText;  // cas des photos de la question
    $('body').html(reponse);// réception de la page de l'ancien questionnaire
    suitemodifcdf()
    stopPropagation(lui);
   }
   else{
     // Confirmation
     var mesalerte = "Cliquer sur 'oui' va remplacer l'actuel questionnaire par celui que vous avez choisi "
     $( "#alerte" ).html(mesalerte);
     $( "#alerte" ).attr('title',"ATTENTION");
     $( "#alerte" ).dialog({
      modal: true,
      buttons: {
       oui : function() {
         $( this ).dialog( "close" );
         var doc = lui.id;
         var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
         requete.open("post",doc,false);
         requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
         var reponse = requete.responseText;  // cas des photos de la question
         $('body').html(reponse);
         suitemodifcdf()
         stopPropagation(lui);
        },
          
       non : function() {
         $( this ).dialog( "close" );
         var doc = lui.id+"_";
         var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
         requete.open("post",doc,false);
         requete.send(null); /* traitée par la méthode WebQuizzModifieCdF */
         var reponse = requete.responseText;  // cas des photos de la question
         $('body').html(reponse);// réception de la page de l'ancien questionnaire
         suitemodifcdf()
         stopPropagation(lui);
       }
      }
     });
   }
  }
  
});  // Fin du jQuery

/* initialisation AJAX en fonction du navigateur */

function choixNavigateur() {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
    return new ActiveXObject('Microsoft.XMLHTTP');
    else
    return new XMLHttpRequest();
  }