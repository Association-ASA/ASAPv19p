/*  js home page du site de l'ASA  */
$(function() {
  var requete = choixNavigateur();
  var doc = "brevehasard";
  requete.open("post",doc,false);
  requete.send(null);
  var reponse = requete.responseText;
  $('#breve').html(reponse);
  $('#brevetexte').slideUp();
  $('#esp').click(function(){
    $('#brevetexte').slideDown('slow');
  });

}); // Fin de jQuery

 function choixNavigateur()
  {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1){
    return new ActiveXObject('Microsoft.XMLHTTP');
    }
    else{
    return new XMLHttpRequest();
    }
  }
