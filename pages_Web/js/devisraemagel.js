/*   Devis raema gel  */

function choixNavigateur() 
 {
   if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
   return new ActiveXObject('Microsoft.XMLHTTP');
   else
   return new XMLHttpRequest();  
 }
 
 
$(function(){    // attente du DOM pour jQuery
  // masquage des éléments
  $('#identificationlabo').hide(); // cache les n° de rama et code
  $('#nouveaulabo').hide(); // cache les renseignements du laboratoire
  $('#detailraemagel').hide(); // cache le détail du devis
  $('[id^="devlab"]').val(""); // vide les détails du devis
  $('[id^="cb"]').attr('checked',false); // Décoche les cases 
  $('[id^="raema"]').attr('checked',false); // décoche les boutons radio
  
  // gestion du clic dans les boutons radio Oui Non
  $('#raemaok').click(function(){
    $('#identificationlabo').show(); // montre les n° de rama et code
    $('[id^="devlab"]').val(""); // efface les renseignements du laboratoire
    $('#nouveaulabo').hide(); // cache les renseignements du laboratoire
    $('#detailraemagel').hide(); // cache le détail du devis
  });
  
  $('#raemako').click(function(){
    $('#nouveaulabo').show(); // les renseignements du laboratoire
    $('[id$="labo"]').val(""); // efface les n° et mdp du laboratoire
    $('#identificationlabo').hide(); // les n° de rama et code
    $('#detailraemagel').hide(); // le détail du devis
  });
  
  // Gestion de l'envoi du bouton d'identification 
  $('#envoi').click(function(evt){
    evt.preventDefault();
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    var doc = "devisid"+$('#numlabo').val()+"_"+$('#mdplabo').val();
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebDevisIdentification de 4D  */
    var reponse = requete.responseText;
     var poslivre = reponse.indexOf("£");
     var htmlannonce = reponse.substring(0,poslivre);
     var htmlprogramme = reponse.substring(poslivre+1);
    $('#detaillabo').html(htmlannonce);
    if (reponse.indexOf('Bonjour')>0) {
     $('#detailraemagel').html(htmlprogramme);
        // Calcul du devis
     $('[name^="cb"]').change(function(){
      var nomclic = $(this).attr("name");
      if($(this).is(':checked')==false){
       var nomavec = 'nbpotsupar'+nomclic.substring(2)
       var selectavec = '[name='+nomavec+']';
       $(selectavec).val("");
       var nomsans = 'nbpotsupsr'+nomclic.substring(2)
       var selectsans = '[name='+nomsans+']';
       $(selectsans).val("");
      }
       calculedevis();
     });
     
     
     $('[name^="nbpotsup"]').change(function(){
      var nomclic = $(this).attr("name");
      var nomcb = "cb"+nomclic.substring(10);
      var selectcb = '[name='+nomcb+']'
      var nbpot =  $(this).val();
      if ((nbpot>0) && ($(selectcb).is(':checked')==false))
      {
        $(selectcb).attr('checked', 'checked');
      }
       calculedevis();
     });
     
     // Gestion du nombre de pots
     $('[name^="nbpot"]').change(function(){
      Verif_nbpot(this)
     });
  
     $('#detailraemagel').show(); // Affichage du détail
    }
    else{
      $('#detailraemagel').hide(); // Masquage du détail
      $('#numlabo').val("");
      $('#mdplabo').val("");
    }
  });
   
  // Gestion du contenu de l'identification
  $('#numlabo').change(function(){
    Verif_nb(this)
  });
  
  $('#mdplabo').change(function(){
    Verif_mdp(this)
  });
  
  // Laboratoire nouveau
 $('[id^="devlab"]').change(function(){
    var affichedetail = true;
    $('[id^="devlab"]').each(function() {
      if ($(this).val()=="") {
        affichedetail = false
      };
    });
    if (affichedetail) {
      $('#detailraemagel').show(); // Affichage du détail
    }
    else{
      $('#detailraemagel').hide(); // Masquage du détail
    }
  });
 
 $('#devlabmail').change(function(){
    verif_mail(this)
  });

  // Calcul du devis
  $('[name^="cb"]').change(function(){
   var nomclic = $(this).attr("name");
   if($(this).is(':checked')==false){
    var nomavec = 'nbpotsupar'+nomclic.substring(2)
    var selectavec = '[name='+nomavec+']';
    $(selectavec).val("");
    var nomsans = 'nbpotsupsr'+nomclic.substring(2)
    var selectsans = '[name='+nomsans+']';
    $(selectsans).val("");
   }
    calculedevis();
  });
  
  
  $('[name^="nbpotsup"]').change(function(){
   var nomclic = $(this).attr("name");
   var nomcb = "cb"+nomclic.substring(10);
   var selectcb = '[name='+nomcb+']'
   var nbpot =  $(this).val();
   if ((nbpot>0) && ($(selectcb).is(':checked')==false))
   {
     $(selectcb).attr('checked', 'checked');
   }
    calculedevis();
  });
  
  // Gestion du nombre de pots
  $('[name^="nbpot"]').change(function(){
   Verif_nbpot(this)
  });
  
  function calculedevis(){  
   // MAI
    // Envoi principal Mai
    var nbmai = 0;
    $('[name^="cbmai"]').each(function() {
      if ($(this).is(':checked')==true) {
        nbmai = nbmai+1;
      };
    });
    
    // pot sup sans rapport mai
    var nbpotsrmai = 0;
    $('[name^="nbpotsupsrmai"]').each(function() {
      var nbcourant = $(this).val();
      if (nbcourant !== "") {
        nbpotsrmai = nbpotsrmai + parseInt(nbcourant);
      }
    });
    
    // pot sup avec rapport mai
    var nbpotarmai = 0;
    $('[name^="nbpotsuparmai"]').each(function() {
      var nbcourant = $(this).val();
      if (nbcourant !== "") {
        nbpotarmai = nbpotarmai + parseInt(nbcourant);
      }
    });
    
    
   // DECEMBRE
     // Envoi principal DECEMBRE
    var nbdec = 0;
    $('[name^="cbdec"]').each(function() {
      if ($(this).is(':checked')==true) {
        nbdec = nbdec+1;
      };
    });
    
     // pot sup sans rapport DECEMBRE
    var nbpotsrdec = 0;
    $('[name^="nbpotsupsrdec"]').each(function() {
      var nbcourant = $(this).val();
      if (nbcourant !== "") {
        nbpotsrdec = nbpotsrdec + parseInt(nbcourant);
      }
    });
    
     // pot sup avec rapport DECEMBRE
    var nbpotardec = 0;
    $('[name^="nbpotsupardec"]').each(function() {
      var nbcourant = $(this).val();
      if (nbcourant !== "") {
        nbpotardec = nbpotardec + parseInt(nbcourant);
      }
    });
    var inscrit = ($('#raemako').is(':checked')==true);
    var cotis = inscrit ? "N" : "O";
    var doc = "calculedevis"+cotis+nbmai+";"+nbpotsrmai+";"+nbpotarmai+";"+nbdec+";"+nbpotsrdec+";"+nbpotardec
    var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
    requete.open("post",doc,false);
    requete.send(null); /* traitée par la méthode WebDevisIdentification de 4D  */
    var reponse = requete.responseText;
    $('#totalht1').html(reponse)
    $('#totalht').val(reponse)
  };

  
}); // Fin du jQuery


function Verif_nb(nb) 
	{
    var nbre = nb.value;
    
    if ((nbre!="") && ((parseInt(nbre)!=nbre) || (nbre<1) || (nbre > 1000))) {
      alert("j'attendais le n° du laboratoire : un nombre entier inférieur à 1000");
      erreur(nb);
    }
    else{
     nb.style.backgroundColor = "#ffffff"; 
    }
  };
  
  
function Verif_nbpot(nb) 
	{
    var nbre = nb.value;
    
    if ((nbre!="") && ((parseInt(nbre)!=nbre) || (nbre<1) || (nbre > 1000))) {
      alert("j'attendais un nombre de pots : un nombre entier");
      erreur(nb);
    }
    else{
     nb.style.backgroundColor = "#ffffff"; 
    }
  };
   
function Verif_mdp(motpasse) 
	{
    var mdp=motpasse.value
      // test du remplissage, de la longueur de motpasse (this)
    if ((mdp !== "") && (mdp.length !== 10) ){
       alert( "Le mot de passe doit comporter 10 lettres alors que vous proposez '"+mdp+"' qui n'en comporte que "+mdp.length+". Merci de le rectifier");
       erreur(motpasse);
       }
    else{
     motpasse.style.backgroundColor = "#ffffff"; 
    }
  };
 
 function verif_mail(lemail)
 {
    var mail = lemail.value;
    if ((mail!="") && (/^[a-z0-9._-]+@[a-z0-9._-]+\.[a-z]{2,6}$/.test(mail) == false)) {
      alert( "l'email n'est pas valide");
      erreur(lemail);
    }
    else{
   lemail.style.backgroundColor = "#ffffff"; 
    }
  }

 // erreur
  function erreur(champ){
    champ.style.backgroundColor = "#fba";
    champ.value="";
    setTimeout(function(){champ.focus()},0); 
  };
  