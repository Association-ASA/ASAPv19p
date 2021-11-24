/*  asadia.js = script de la page de diagnose d'une lésion*/

$(function() {
  
  gerepages();
  /*  Gestion du changement de page */
   $('[id^="Ajax"]').click (function(){
     var requete = choixNavigateur();
     var doc = "ajaxpage"+this.id+"£"+$("#mailvisiteur").val();
     requete.open("post",doc,false);
     requete.send(null);
     var reponse = requete.responseText;
     $('#corps').html(reponse);
     gerepages();
   });
    
  function gerepages() {
    // Page diagnose
      window.onresize = function(){
      /* disparition des fleches */
        $('[src*="images/fleche"]').hide();
        $('#flechephotoengrand').attr('alt',"Placer les explications");
        $('#flechephotoengrand').attr('title',"Placer les explications");
        var srcbouton = srcbouton.replace('IconeNF','IconeF');
        $('#flechephotoengrand').attr('src',srcbouton);
      };
      
      
      /*  Masquage intitial des résultats de recherche  */ 
        $('#resultat').hide();
        $('#critere').hide();
        $('#formule').hide();
        $('#boutonvoir').hide();
        
      /*  Masquage intitial du commentaire photo en grand  */
        $('#fermeture').hide();
        $('#com').hide();
        
      /*  Lancement de la fabrication de la formule de recherche */
        $('.casesp').change(function() // Clic sur une espece
        {
          formulerequete("e");
        });
        
        $('.casorg').change(function() // Clic sur un organe
        {
          formulerequete("o");
        });
        
        $('.changerequete').change(function() // Clic sur une lésion
        {
          formulerequete("l");
        });
        
      /*  Fabrication de la formule de recherche */
      function formulerequete(clic)
        {        
          var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")         /*  Prise en compte de la langue */
          var esp=""      /* Les espèces */
          $('.casesp').each(function(index) {
            if ($(this).is(':checked')==true) {
              esp=esp+', '+$(this).attr('name');
            }
          }) ;
          if (esp.length>0) {
            esp=esp.substring(2);
            afficheesp = esp;
          }
          else {
            afficheesp ='toutes les espèces '
          }
                  
          var org=""         /* Les organes */
          $('.casorg').each(function(index) {
          if ($(this).is(':checked')==true) {
          org=org+', '+$(this).attr('name');
          }
          }) ;
          if (org.length>0) {
            org=org.substring(2);
            afficheorg = org;
          }
          else {
            afficheorg ='tous les organes '
          }
          
          /* Passons aux lésions */
          var les=""
          $('.ms-drop').find('input:checked').each(function () {
              les = les +','+ this.value;
          });
          afficheles = les
          if (les=="" || les==null) {
            les="";
            afficheles = 'Toutes les lésions ';
          }
          else{
            les=les.substring(1);
          }
          afficheles = les
          if (french==true) {
            var liste= ($('#asa').is(':checked')==true) ? 'a' : 'd' ;
          }
          else{
            var liste= 'e' ;
          }
          
          /* Fabrication de la formule envoyée à 4D */
          var formule = liste+'Espèces : '+esp+"<br />"+'Organes : '+org+"<br />"+'Lésions : '+les
          /* envoi à 4D */
          var NbPhotosCritere = flipflop(formule);/* Effectue la requete AJAX et renvoie le nombre de photos */
          
          /* Affichage du résultat */
          var pos = NbPhotosCritere.indexOf("§");
          var NbPhotos= NbPhotosCritere.substring(pos+1)
          if (NbPhotos==0) {
            var resumerech = french?"Aucune photo ne répond aux critères proposés : <br />":"No photo meets the proposed criteria: <br />";
          }
          else{
            var s = (NbPhotos>1)?"s":"";
            var ent = (NbPhotos>1)?"ent":"";
            var reponde = french?" répond"+ent+" aux critères proposés : <br />": " meet"+ s +" the proposed criteria: <br />";
            var resumerech = NbPhotos+" photo"+s+reponde;
          }
          if(french==true){
            var afficheres = resumerech + afficheles +' sur '+ afficheorg +' chez les ' + afficheesp + ' </br>';
          }
          else{
            var criterelesorg = NbPhotosCritere.substring(0,pos);
            var afficheres = resumerech + afficheles + criterelesorg + ' </br>';
          }
          /*
          afficheres = afficheres + '<p id="boutonvoir" class="textecentre" style="display: block;">';
          */
          afficheres = afficheres +'<br /> <button id="boutuerecherche" class="textebanalgrand">';
          var annule = french?'Annuler la recherche</button>': 'Cancel Search</button>';
          afficheres = afficheres + annule
          $('#formule').html(afficheres);
          $('#formule').show();
          if (NbPhotos>200) {
            $('#boutonvoir').show();/* bouton voir si ... le 200 est bon ! */
            $('#tbphotos').html("");
            $('#photolesion').html("");
            $('#trieusephotos').html("");
            
           /* Gestion du clic sur le bouton de voir les photos #bouvisenombreuse */
            $('#bouvisenombreuse').click(function(){
              var requete = choixNavigateur();
              var doc = "flipfloc"+liste+formule;
              requete.open("post",doc,false);
              requete.send(null);
              var reponse = requete.responseText;
              var pos = reponse.indexOf("£");
              var NbPhotos = reponse.substring(0,pos);
              reponse = reponse.substring(pos+1);
              affichetbphotos(reponse);
              $('#boutonvoir').hide();
            });
          }
          else{
            $('#boutonvoir').hide();
            $('#tbphotos').show();
            $('#trieusephotos').show();
          }
          
          /* Gestion du clic sur le bouton de annuler la recherche #boutuerecherche */
          $('#boutuerecherche').click(function(){
              /* Masquage des zones et boutons */
              $('#trieusephotos').hide();
              $('#tbphotos').hide();
              $('#formule').hide();
              $('#boutonvoir').hide();
              /* Décochage des cases */
              $(":checkbox").prop('checked', false);
           });
        }
      
      /* Affichage du tableau des photos entre 200 et 20 */
      function affichetbphotos(reponse)
        {
          reponse=reponse.substring(1); /* élimination du b */  
          $('#tbphotos').html(reponse);/* placement du tableau renvoyé par 4D */  
          $('#tbphotos').show();/* placement du tableau renvoyé par 4D */  
          $('#photolesion').html("");/* effaçage de l'image de la lésion sur clic du tableau */  
          $('#trieusephotos').html("");/* effaçage de la liste d'images */  
          $('#bouvisetrieuse').show();/* apparition du bouton de visualisation de la liste des photos */
          $('#TbRes').dataTable({
             "pagingType": "full_numbers"
          }); /* mise en forme tablulée du tableau */
          var drap = $('#flagA').attr('src');
          var french = (drap=="images/DrapeauA.gif")
          if(french==true){
            $('#TbRes_length').html('Liste des photographies');// annonce du tableau */
          }
          else{
            $('#TbRes_length').html('List of photos');// annonce du tableau */
          }/* Gestion des évènements suite à la création du tableau*/
            /* gestion du clic sur le changement de page -> effaçage des images */
            $('#TbRes_paginate').click(function(){
               $('#trieusephotos').html("");/* effaçage de la liste d'images */  
               $('#photolesion').html("");/* effaçage de l'image de la lésion sur clic du tableau */  
            });
            
          /* Gestion du clic sur le bouton d'affichage */
            $('#bouvisetrieuse').click(function(){
                affichelesphotos('toutes')
            });
          
          /* Gestion du clic sur une ligne du tableau*/
            $('#TbRes tbody').on('click', 'tr', function () {
              var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
              var init = french? 'F':'A';
               $('tr.TbCorpsL').removeClass('selected');/* déselectionne toutes les lignes  */ 
               $(this).toggleClass('selected');/* sélectionne la ligne cliquée  */ 
               var numimage = $('td', this).eq(0).text();/* récupération, dans la colonne 1 du n° de diapo  */
               affichelesphotos(numimage)
               $('[id^="boutonnpc"]').click(function(){
                  affichenpc(this)
                })
             });
        };
    
           
        /*  Fabrication du résultat de la formule de recherche */
      function flipflop(formule)  
        {
          /*  Prise en compte de la langue */
          var drap = $('#flagA').attr('src');
          var french = (drap=="images/DrapeauA.gif")
          
          /*  Envoi AJAX à 4D */
          var requete = choixNavigateur();
          var doc = "flipflop"+formule;
          requete.open("post",doc,false);
          requete.send(null);
          var reponse = requete.responseText;
          var pos = reponse.indexOf("£");
          var Prelude = reponse.substring(0,pos);
          var pos2 = reponse.indexOf("§");
          var NbPhotos = reponse.substring(pos,pos2+1);
          if (NbPhotos <200) { /* on limite l'affichage du tableau à des sélections raisonnables */
            var reponse = (pos>0)? reponse.substring(pos+1):'0';
            if (reponse.charAt(0)=="b") { /* b = Plus de 20 photos*/
              affichetbphotos(reponse);
            }
            else { /* Moins de 20 photos*/
              reponse=reponse.substring(1); /* élimination du a */  
              $('#trieusephotos').html(reponse);/* fabrication de la liste d'images à partir de 4D*/ 
              $('#trieusephotos').show();/* montrons la liste d'images*/ 
              $('#tbphotos').html("");/* effaçage du tableau */  
              $('#bouvisetrieuse').hide()/* effaçage du bouton de visualisation de la liste des photos */
              /* toutes les images de choix d'une rubrique */
              /* ont une id de type lp+ x= type de rubrique + n°de la photo  */
              /* donc commençant par lp */
              $('[id^="lp"]').click(function(){
                var init = french?"F":"A";
                var doc = init+$(this).attr('id');/* fabrication du message AJAX envoyé à 4D  */
                var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
                requete.open("post",doc,false);
                requete.send(null);
                
                var reponse = requete.responseText;/* réception de la réponse de 4D  */
                varidtexte = "#texte"+doc.substring(4);/*  */
                /* doc.substring(3,9) = repérage du n°de la photo dans les caractères renvoyés par 4D   */
                varideffet = "#com"+doc.substring(4);/* */
                $(varidtexte).html(reponse);/* réception de la rubrique */
                $(varideffet).fadeTo(10,0.01);/* Effaçage de la rubrique */
                $(varideffet).fadeTo(1000,0.8); /* Affichage progressif de la rubrique */
                
                /* Initialisation des actions des images et du bouton des npc 
                  gestion du clic de l'image de la lésion
                  */
                $('.imageenlistenpc').click(function(){  
                  engrand(this);
                });
               
               
                $('[id^="boutonnpc"]').click(function(){
                  affichenpc(this)
                })
                
                /*  initialisation de clic sur paniers*/
                $('[id^="panierreset"]').click(function(){
                  $(varidtexte).html("");/* remise à blanc du bloc */
                })
                
                $('[id^="paniersumit"]').click(function(){
                  var requete = choixNavigateur();
                  var idtexte ='#'+this.id.replace('paniersumit','texte');
                  var doc = "panier"+$('#mailvisiteur').val()+"£"+$(idtexte).html();
                  requete.open("post",doc,false);
                  requete.send(null);
                  var reponse = requete.responseText;
                  var message = "Photographie ajoutée au panier ";
                  $(varidtexte).html(message);/* remise à blanc du bloc */
                });
              });
              
              $('[id^="lp"]').mouseover(function(){
                var nomimagea = $(this).attr('src');
                var nomimagen = nomimagea.replace('Repos','Actif');
                $(this).attr('src',nomimagen);
              })
              
               $('[id^="lp"]').mouseout(function(){
                var nomimagea = $(this).attr('src');
                var nomimagen = nomimagea.replace('Actif','Repos');
                $(this).attr('src',nomimagen);
              })
               
            } // fin du else
            
            $('.imageenliste').click(function(){ /* gestion du clic de l'image de la lésion */
                engrand(this);
            });
            
          }  // fin du if
          else{
            $('#photolesion').html("");/* effaçage de l'image de la lésion sur clic du tableau */  
            $('#tbphotos').html("");/* effaçage du tableau */
          };
          
          return Prelude;
          
        };
        
       /* Page NPC */
        
      function affichenpc(lui){
          var doc = 'refnpc'+$(lui).attr('id').substring(9);/* fabrication du message AJAX envoyé à 4D  */
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null); /* traitée par la méthode WebEcritPageNPC de 4D  */
          var reponse = requete.responseText;
          window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
        };
        
        $('.imageenliste').click(function(){ /* gestion du clic de l'image de la lésion */
            engrand(this);
        });
        
      function clicdansflechenpc(lui){
          var idt = '#'+lui.id +"t";
          var idi = '#'+"image"+lui.id ;
          if ($(idt).is(':visible')) {
              $(idt).slideUp(1000);
              $(idi).attr('src','images/trianglebas.jpeg');
          }
          else {
           $(idt).slideDown(1000);
           $(idi).attr('src','images/trianglehaut.jpeg');
          }             
        };
    
        $('.adtitre2') .click(function(){
          clicdansflechenpc(this)
        });
    
        $('[id^="npcphotos"]').click(function(){
          var rang = $(this).attr('id').substring(9);
          var srcimageclic = $('#photonpc'+rang).attr('src');
          var numpetitephoto = srcimageclic.substring(7,12);
          var srcimagenpc = $('#grandephotonpc').attr('src');
          var numphotonpc = srcimagenpc.substring(7,12);
          var srcimageref = $('#grandephotoref').attr('src');
          var numphotoref = srcimageref.substring(7,12);
          var doc = 'npcclic'+rang+numpetitephoto+numphotonpc+numphotoref;/* fabrication du message AJAX envoyé à 4D  */
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
          var reponse = requete.responseText;
          var poslivre = reponse.indexOf("£");
          var htmlpetitephoto = reponse.substring(0,poslivre);
          var htmlgrandephoto = reponse.substring(poslivre+1);
          var poslivre = htmlgrandephoto.indexOf("£");
          var htmldiagnostic = htmlgrandephoto.substring(poslivre+1);
          htmlgrandephoto = htmlgrandephoto.substring(0,poslivre);
          $('#npcphotos'+rang).html(htmlpetitephoto);
          $('#npcphoto').html(htmlgrandephoto);
          $('#npcformule').html(htmldiagnostic);
          $('.imageenliste').click(function(){ /* gestion du clic de l'image de la lésion */
            engrand(this);
          });
          
          // On gère la visibilité partielle en bascule
          $('.adtitrenpc') .click(function(){
            clicdansflechenpc(this)      
          });
        });
        
        
       /*  PHOTO EN GRAND  */ 
        /* CREATION DE LA PHOTO EN GRAND*/
          function engrand(lui){
            var french = ($('#flagA').attr('src')=="images/DrapeauA.gif");
            var init = french?"F":"A";
            var srcimage = $(lui).attr('src');
            var numimage = srcimage.substring(7,12);
            var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
            var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
            var doc = init+'afficheengrand'+numimage+"_"+largeurf+"_"+hauteurf;/* fabrication du message AJAX envoyé à 4D  */
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
            
            var reponse = requete.responseText;
            window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
          }
          
        /* GESTION DU SURVOL DES BOUTONS*/
          $('.bouton').mouseover(function(){ 
             var nomimagea = $(this).attr('src');
             var nomimagen = nomimagea.replace('Repos','Actif');
             $(this).attr('src',nomimagen);
          })
          
        /* GESTION DE LA FIN DE SURVOL DES BOUTONS */
          $('.bouton').mouseout(function(){ 
            var nomimagea = $(this).attr('src');
            var nomimagen = nomimagea.replace('Actif','Repos');
            $(this).attr('src',nomimagen);
          })
     
        /* AFFICHAGE DES PHOTOS LIEES  */
          $('[id^="imagette"]').click(function(){
            var french = ($('#quittephotoengrand').attr('src')=="quitter");
            var numimagea = this.id.substring(8);  /* N° de la nouvelle image à afficher  */
            
            /* Modification du titre de la page */
              varancnum =  window.document.title.substring(8);
              window.document.title = 'Photo n°'+numimagea;
            
            /* Remplacement des attributs de diapo appelée par l'appelante */
            
            var il = $('#photodia').width();
            var ih =  $('#photodia').height();
            $(this).removeClass("imagesuph");
            $(this).removeClass("imagesupv");
            if (il>ih) {
              $(this).addClass("imagesuph");
            }
            else{
               $(this).addClass("imagesupv");
            }
            $(this).attr('title',varancnum);/* title  */
            $(this).attr('alt',varancnum);/* alt  */
            $(this).attr('id',"imagette"+varancnum);/* id  */
            $(this).attr('src',"images/"+varancnum+"is.jpg");/* source  */
           
            /* Modification de l'image */
              var srcimagea = 'images/'+numimagea+'.jpg';
              $('#photodia').attr('src',srcimagea);
              
            /* disparition des fleches */
              $('[src*="images/fleche"]').hide();
              $('#flechephotoengrand').attr('src',"images/IconeFleRepos.png");
              
           
            /* fermeture des commentaires */
              $('#com').hide();
              $('#fermeture').hide();
          });
                                                                                 
        /* CLIC SUR BOUTONS COMMENTAIRES (id se terminent toutes par "photoeg") */ 
          $('[id*="photoeg"]').click(function(){
            var french = ($('#quittephotoengrand').attr('title')=="Quitter");
            var init = french?"F":"A";
            var numdia = document.title.substring(8);
            var type = $(this).attr('id');
            var doc = init+'metlesinfos'+ type.charAt(0)+numdia;
            
            var requete = choixNavigateur();
            requete.open("post",doc,false);
            requete.send(null);
            var reponse = requete.responseText;
            $('#com').html(reponse);
            $('#com').show();
            $('#fermeture').show();
            $('[id^="boutonnpc"]').click(function(){
              affichenpc(this)
            })
          });
        
        /* REDIMENSIONNEMENT  */
          $('#resize').click(function(){
            var french = ($('#quittephotoengrand').attr('title')=="Quitter");
            var wl = $(window).width(); /* Largeur de la fenetre du navigateur */
            var wh = $(window).height();/* Hauteur de la fenetre du navigateur */
            var il = $('#photodia').width();/* Largeur de l'image */
            var ih = $('#photodia').height();/* Hauteur de l'image */
            
            if (wl==il) { /* Non redimensionné  */
             var newlargeuri = (wh*100/ih)+"%"
              $('#photodia').attr("width",newlargeuri); /*  Attribution de la largeur de l'image*/
              var ttlarge = french?"Occuper toute la largeur":"Full width";
              $('#resize').attr("alt",ttlarge);
              $('#resize').attr("title",ttlarge);
              $('#resize').attr("src","Images/IconeEnlargeRepos.png");
            }
            else{  /* Redimensionné  */
              var newhauteuri = "100%"
              $('#photodia').attr("width",newhauteuri); /*  Attribution de la largeur de l'image*/
              var tthaut = french?"Ajuster à la fenêtre":"Fit to window";
               $('#resize').attr("alt",tthaut);
              $('#resize').attr("title",tthaut);
              $('#resize').attr("src","Images/IconeResizeRepos.png");
            }
            $('[src*="images/fleche"]').hide();
            var metfleche = french?"Placer les explications":"Put explanations";
            $('#flechephotoengrand').attr('alt',metfleche);
            $('#flechephotoengrand').attr('title',metfleche);
            var srcbouton = srcbouton.replace('IconeNF','IconeF');
            $('#flechephotoengrand').attr('src',srcbouton);
          });
        
        /* FERMETURE D'UN COMMENTAIRE  */
          $('#fermeture').click(function(){
            $('#com').hide();
            $('#fermeture').hide();
          });
        
        /*  METTRE ENLEVER LES FLECHES */
         $('#flechephotoengrand').click(function(){
          /* var titrebouton = $('#flechephotoengrand').attr('alt'); */
          var french = ($('#quittephotoengrand').attr('title')=="Quitter");
          var anglais = french? "":"a";
          var srcbouton = $('#flechephotoengrand').attr('src');
            if (srcbouton.substring(0,15) == "images/IconeFle") {
              var srcbouton = srcbouton.replace('IconeF','IconeNF')
              var otefleche = french?"Enlever les flèches d'explication":"Remove explanation";
              $('#flechephotoengrand').attr('alt',otefleche);
              $('#flechephotoengrand').attr('title',otefleche);
              var numdia = document.title.substring(8);
              var doc = "metlesfleches" + numdia + anglais ;
              var requete = choixNavigateur();
              requete.open("post",doc,false);
              requete.send(null);
              var reponse = requete.responseText;
              /*
               réponse type
               "flecheadroite.PNG;X;Y;commentaire$
               flecheenbas.PNG;X;Y;commentaire$ ...
              */
             
              for (var i=1;i<5;i=i+1) 
              {
              /* Traitement de la ligne */
                var pos = reponse.indexOf('£');
                var ligne = reponse.substring(0,pos);
                 // raccourcissement de la chaine
                reponse = reponse.substring(pos+1);
              /* type d'image */
                var pos = ligne.indexOf(';');
                var lasrc = 'images/'+ligne.substring(0,pos);
                varcible = '#fleche'+i
                $(varcible).attr('src',lasrc);
              /* coordonnées */
                var largeur = $('#photodia').width();
                var hauteur = $('#photodia').height();
                ligne = ligne.substring(pos+1);
                var pos = ligne.indexOf(';');
                var coordX =  ligne.substring(0,pos);
                ligne = ligne.substring(pos+1);
                var pos = ligne.indexOf(';');
                var coordY =  ligne.substring(0,pos);
                if (coordX+coordY=="") {
                  $(varcible).hide();
                }
                else{
                  var dX = 0;
                  var dY = 0;
                  switch (i) {
                      case 1 :
                        dX =-35;
                        dY=-14;
                      break;
                    
                      case 2 :
                      dX=-14;
                      dY=-35;
                      break;
                    
                      case 3 :
                        dY=-14;
                        break;
                      
                      case 4 :
                        dX=-14;
                        break;
                    }
                  $(varcible).show();
                  var haut = Math.round(hauteur*coordY)+dY;
                  var droite = Math.round(largeur*coordX) + dX;
                /* déplacement */
                  $(varcible).css({
                    top: haut,
                    left: droite,
                  });
                /* le commentaire */
                  var com = ligne.substring(pos+1);
                  $(varcible).attr('title',com);
                  $(varcible).attr('alt',com);
                }
              }
            }
            else{
              $('[src*="images/fleche"]').hide();
              var metfleche = french?"Placer les explications":"Put explanation";
             
              $('#flechephotoengrand').attr('alt',metfleche);
              $('#flechephotoengrand').attr('title',metfleche);
              var srcbouton = srcbouton.replace('IconeNF','IconeF');
            }
            $('#flechephotoengrand').attr('src',srcbouton);
          });
       
       
        /* RETOUR D'IMAGE EN GRAND  */
        /*  Bouton quitter */
          $('#quittephotoengrand').click(function(){
             window.close();
          });
       
       
       
      /* Gestion des deux types de liste  */
    
        
        /* Gestion de la liste anapath */
          $('#asa').on('click', function()
        {
          var nomenclat= 'nomenclature asa';/* fabrication du message AJAX envoyé à 4D  */
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",nomenclat,false);
          requete.send(null);
          
          var reponse = requete.responseText;/* réception de la réponse de 4D  */
          $('#lesion').html(reponse);/* remplacement de la liste */
          $('select').multipleSelect({
              isOpen: true,
              keepOpen: true
            });
        });
        
          /* Gestion de la liste dgal */
        $('#dgal').on('click', function()
        {
          var nomenclat= 'nomenclature dgal';/* fabrication du message AJAX envoyé à 4D  */
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",nomenclat,false);
          requete.send(null);
          var reponse = requete.responseText;/* réception de la réponse de 4D  */
          $('#lesion').html(reponse);/* remplacement de la liste */
          $('select').multipleSelect({
              isOpen: true,
              keepOpen: true
            });
        });
        
        /* Fabrication de la liste des images à partir du bouton Voir les photographies */
        function affichelesphotos(une)
        {
          var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
          var init = french?"F":"A";
          $('#trieusephotos').html("")/* Vide l'espace à remplir  */
          var doc = "filelesphotos"+init/*  Fabrication du message AJAX envoyé à 4D  */
          if (une.length==5) { /* c'est UNE image  */
            doc = doc + une +";";
          }
          else{ /* "toutes" = les images du tableau affichée  */
            $('#TbRes tbody > tr').each(function() {
              var ligneimage = $(this).eq(0).text();
              var numimage = parseInt(ligneimage);
              doc = doc + numimage+";";
            });
          }
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null);
          
          var reponse = requete.responseText;/* réception de la réponse de 4D  */
          var pos = reponse.indexOf("£");
          var reponse = reponse.substring(pos+2);
          /*$('#resultat').show(); apparition du bouton de visualisation de la liste des photos */ 
          /* $('#critere').show();apparition de la synthèse de la formule de recherche */ 
          $('#trieusephotos').html(reponse);/*  Affichage de la liste des photos */
          $('#trieusephotos').show();
          $('.imageenliste').click(function(){
                engrand(this);
          });
          
          /* gestion du clic de l'image de choix d'une rubrique */
          /* toutes les images de choix d'une rubrique */
          /* ont une id de type lp+ x= type de rubrique + n°de la photo  */
          /* donc commençant par lp */
          $('[id^="lp"]').click(function(){
            var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
            var init = french? 'F':'A';
            var doc = init+$(this).attr('id');/* fabrication du message AJAX envoyé à 4D  */
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null);
            
            var reponse = requete.responseText;/* réception de la réponse de 4D  */
            /* doc.substring(4) = repérage du n°de la photo dans les caractères renvoyés par 4D   */
            varidtexte = "#texte"+doc.substring(4)
            varideffet = "#com"+doc.substring(4)
            $(varidtexte).html(reponse);/* réception de la rubrique */
            $(varideffet).fadeTo(10,0.01);/* Effaçage de la rubrique */
            $(varideffet).fadeTo(2000,0.8);/* Affichage progressif de la rubrique */
            $('[id^="boutonnpc"]').click(function(){
              affichenpc(this)
            })
            $('[id^="panierreset"]').click(function(){
              $(varidtexte).html("");/* remise à blanc du bloc */
            })
            
            $('[id^="paniersumit"]').click(function(){
              var requete = choixNavigateur();
              var idtexte ='#'+this.id.replace('paniersumit','texte');
              var doc = "panier"+$('#mailvisiteur').val()+"£"+$(idtexte).html();
              requete.open("post",doc,false);
              requete.send(null);
              var reponse = requete.responseText;
              var message = "Photographie ajoutée au panier ";
              $(varidtexte).html(message);/* annonce de travail accompli */
            })
            
          });
          
          $('[id^="lp"]').mouseover(function(){
            var nomimagea = $(this).attr('src');
            var nomimagen = nomimagea.replace('Repos','Actif');
            $(this).attr('src',nomimagen);
          })
              
          $('[id^="lp"]').mouseout(function(){
            var nomimagea = $(this).attr('src');
            var nomimagen = nomimagea.replace('Actif','Repos');
            $(this).attr('src',nomimagen);
          })
          
        }; // fin de affichelesphotos
      
      // gestion des listes
        /*  actions intitial */
        formatetb('#listelesion');
        initclicdetaillesion();
        initclicdetailmotif(); 
        initclicdetailphoto();
        initlancerdiaporama();

        var langue = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "En":"Fr";
        var nbtotal = $('#nbtotal').val();
        var nbactuel = $('#nbactuel').val();
      
        /* Saisie dans champ de recherche */
        $("#cherchelesion").bind("keyup", function(){
          var name = $("#cherchelesion").val();
          if ((name.length>2)||(name.length==0))
          {
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var trouve = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "searcha":"cherche";
            var indicationf = "Cliquer sur l'icône du détail pour obtenir le contenu de la lésion.";
            var indicationa = "Click the icon detail of lesion you want to display the content. ";
            var mde = ($('#flagA').attr('src')=="images/DrapeauF.gif")? indicationa:indicationf;
            $('#ledetaillesion').html(mde);
            var doc = trouve+name;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebChercheLesion de 4D  */
            var reponse = requete.responseText;
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            $('#nbactuel').val(nb);
            affichetblesion(reponse,'#listelesion');
            initclicdetaillesion();
          }
        });
        
        $("#cherchemotif").bind("keyup", function(){
          var name = $("#cherchemotif").val();
          if ((name.length>2)||(name.length==0))
          {
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var trouve = "motifcherche";
            var doc = trouve+name;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebChercheMotif de 4D  */
            var reponse = requete.responseText;
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            $('#nbactuel').val(nb);
            $('#ledetailmotif').html("Cliquer sur l'icône du détail pour obtenir le contenu du motif."); 
            affichetblesion(reponse,'#listemotif');
            initclicdetailmotif();
          }
        });
        
        $("#cherchephoto").bind("keyup", function(){
          var name = $("#cherchephoto").val();
          if ((name.length>2)||(name.length==0))
          {
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var trouve = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "find":"trou";
            var doc = trouve+name;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebChercheLesion de 4D  */
            var reponse = requete.responseText;
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            $('#nbactuel').val(nb);
            affichetblesion(reponse,'#listephoto');
            initclicdetailphoto();
          }
        });
        
        function  affichetblesion(reponse,liste){
          $(liste).html(reponse);
          formatetb(liste)
        }
        
        /*  Appel 4D et Affichage du tableau  */ 
        $('#btnaffiche').click(function(){
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          var doc = "aboulelistelesion"
          requete.open("post",doc,false);
          requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
          var reponse = requete.responseText;
          affichetblesion(reponse,'#listelesion');
        });
        
        function initclicdetailmotif(){
          $('[id^="motifdetail"').click(function(){
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var doc = this.id;
            /*var haut = findPos(this);
            var rect = this.getBoundingClientRect();
            */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetailmotif').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+doc.replace('motifdetail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
          });
        }
        
         function initclicdetaillesion(){
          $('[id^="detail"').click(function(){
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var doc = this.id;
            /*var haut = findPos(this);
            var rect = this.getBoundingClientRect();
            */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetaillesion').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+doc.replace('detail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
          });
        }
        
        
        function initclicdetailphoto(){
          $('[id^="diadetail"').click(function(){
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var doc = this.id;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetailphoto').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+doc.replace('detail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
            initclicsurphoto()
          });
        }
        
        function formatetb(liste){
          var nbtotal = $('#nbtotal').val();
          var nbactuel = $('#nbactuel').val();
          if (liste == "#listemotif")
            {
              var quoinom = "motif";
              var quoiid = "motif";
              nbactuel =(nbactuel=="1")? 'un seul '+quoinom +" " : ' '+nbactuel+" "+quoinom+"s ";
              var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
              var surtotalde = "sur un total de ";
            }
          else
          {
            var langue = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "En":"Fr";
            var lesion = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "lesion":"lésion";
            var quoinom = (liste == "#listephoto") ? "photo" : lesion;
            var quoiid = (liste == "#listephoto") ? "photo" : "lesion";
            var quoinom = (liste == "#listemotif") ? "motif" : quoinom;
            var quoiid = (liste == "#listemotif") ? "motif" : quoiid;
            var rienf = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
            var riena = "Sorry, no "+quoinom+"s have the string \""+$("#cherche"+quoiid).val()+"\" in the announced criteria"
            var rien = (langue=="Fr")? rienf : riena;
            nbactuelf = (nbactuel=="1")? 'une seule '+quoinom : ' '+nbactuel+" "+quoinom+"s ";
            nbactuela = (nbactuel=="1")? 'only one '+quoinom: ' '+nbactuel+" "+quoinom+"s ";
            nbactuel = (langue=="Fr")? nbactuelf : nbactuela ;
            var surtotalde = (langue=="Fr")? "sur un total de " : "out of a total of ";
          }
          
         $('#TbLes').dataTable(
            {
              "scrollY": "500px",
              "scrollCollapse": true,
              "paging": false,
              "ordering": true,
              "searching": false,
              "language":
              {
                  "sProcessing":     "Traitement en cours...",
                  "sSearch":         "Rechercher :",
                  "sLengthMenu":     "Afficher _MENU_ dossiers",
                  "sInfo":           nbactuel+ surtotalde +nbtotal,
                  /*
                  "sInfoEmpty":      "Affichage du dossier 0 à 0 sur 0 dossier",
                  */
                  "sInfoEmpty":      "",
                  "sInfoFiltered":   "(filtré de _MAX_ éléments au total)",
                  "sInfoPostFix":    "",
                  "sLoadingRecords": "Chargement en cours...",
                  "sZeroRecords":    "Aucun dossier à afficher",
                  "sEmptyTable":     rien,
                  "oPaginate": {
                      "sFirst":      "Premier",
                      "sPrevious":   "Précédent",
                      "sNext":       "Suivant",
                      "sLast":       "Dernier"
                  },
                  "oAria": {
                      "sSortAscending":  ": activer pour trier la colonne par ordre croissant",
                      "sSortDescending": ": activer pour trier la colonne par ordre décroissant"
                  }
              }
            }
          );
        }
        
        function initclicsurphoto(){
          $('.photoasadia').click(function(){ /* gestion du clic de l'image de la lésion */
              engrand(this);
            });
        }
        // fin de la gestion des listes
        
        // Gestion des textes
        /*
         $('[id^="texteajax"]').click (function(){
          var requete = choixNavigateur();
          var doc = "ajaxtexte"+this.id+$("#mailvisiteur").val();
          requete.open("post",doc,false);
          requete.send(null);
          var reponse = requete.responseText;
          $('html').html(reponse);
        });
        */
        
        // Gestion des paniers
        function initlancerdiaporama(){
          $('#ledetailpanier').sortable(); // la liste contenant les images préférées est déclarée de façon à ce qu'on puisse ranger ces dernières
          $('[id^="lancerpanier"]').click(function(){
            var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
            var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
            var requete = choixNavigateur();
            var doc = this.id+"_"+largeurf+"_"+hauteurf;
            requete.open("post",doc,false);
            requete.send(null);
            var reponse = requete.responseText;
            window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
            // $('.bouton').hide();
            // initdiaporamagestion();
           
          });
        }
        /*
        function initdiaporamagestion(){
          $('div').keypress(function(e){
            console.log(e.keyCode);
            console.log(e.which);
          });
        }
        */
        // Fin de gestion des textes
    } // fin de gerepages
  });

/* initialisation AJAX en fonction du navigateur */

function choixNavigateur() {
    if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
    return new ActiveXObject('Microsoft.XMLHTTP');
    else
    return new XMLHttpRequest();
  }
 
 function findPos(obj){
    var curleft = curtop = 0;
    if (obj.offsetParent) {
        curleft = obj.offsetLeft
        curtop = obj.offsetTop
        while (obj == obj.offsetParent) {
            curleft += obj.offsetLeft
            curtop += obj.offsetTop
        }
    }
    return [curleft,curtop];
  }

  