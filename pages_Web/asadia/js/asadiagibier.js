
/*jQuery*/
$(function() {
    window.onresize = function(){
         //  $("body").prepend( "<div>" + $('window').width() + "</div>" );
        var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
        var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
       console.log(largeurf + hauteurf)
    };
    
  function engrand(lui){
        var srcimage = $(lui).attr('src');
        var numimage = srcimage.substring(7,12);
        var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
        var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
        var doc = init+'afficheengrand'+numimage+"_"+largeurf+"_"+hauteurf+"_"+$('#mailvisiteur').val();/* fabrication du message AJAX envoyé à 4D  */
        var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
        requete.open("post",doc,false);
        requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
        var reponse = requete.responseText;
        window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
    }
    $('[id^="tgibiercom"]').slideUp();
    
    $('[id^="gibiercom"]') .click(function(){
          clicdansflechegibier(this)
    });
    
    
    function clicdansflechegibier(lui){
          var idt = '#'+"t"+lui.id ;
          var idi = '#'+lui.id ;
          if ($(idt).is(':visible')) {
              $(idt).slideUp(1000);
              $(idi).attr('src','images/trianglebas.jpeg');
          }
          else {
           $(idt).slideDown(1000);
           $(idi).attr('src','images/trianglehaut.jpeg');
          }             
        };
    
});
/* fin de jQuery*/

function choixNavigateur() {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
    return new ActiveXObject('Microsoft.XMLHTTP');
    else
    return new XMLHttpRequest();
  }
  
  