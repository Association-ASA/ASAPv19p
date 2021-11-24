/*  asadia.js = script de la page de diagnose d'une lésion*/

$(function() {
    // GESTION DES FAQ
  initfaqpage ()
  function initfaqpage (){
        $('#faqpage').click(function(){
            var textefaq = '<br /> <br /> <span class="panierconsigne">Pour envoyer une remarque à l'+"'"+'ASA concernant la page actuelle'
            textefaq=textefaq+', remplissez le champ ci dessous et cliquez sur le bouton "Envoyer".</span><br />'
            textefaq=textefaq+'<textarea name="" id="comfaq" cols="55" rows="5"></textarea>'
            textefaq=textefaq+'<br /><br />'
            textefaq=textefaq+'<button  class="adtitre1e" id="faqsumit">Envoyer</button>'
            textefaq=textefaq+'<button  class="adtitre2e" id="faqreset">Ne PAS envoyer</button> <br />'
            $('#faqcontenu').html(textefaq);
            $('#faqsumit').click(function(){
                var titrepage = $('#titredelapage').html();
                var indexchaine =  titrepage.indexOf("ech") ; // Diagnose
                var contexte = titrepage;
                if (indexchaine > 0) {
                  var contexte = contexte + "§" + $('#formule').text();  // 14 photos trouvées ...
                }
                else{
                    var indexchaine =  titrepage.indexOf("documen") ;
                    if (indexchaine > 0) {
                      var contexte = titrepage ; // cours illustrés
                    }
                    else{
                    var contexte = contexte + "§" + $('#TbLes_info').text();  // 14 photos trouvées ...
                    }
                }   
                var doc = 'faqreception' + contexte + '£'+ $('#mailvisiteur').val() + '£' +$('#comfaq').val();
                var requete = choixNavigateur();
                requete.open("post",doc,false);
                requete.send(null);
                var reponse = requete.responseText;
                var textefaq = '<br /> <br /> <span class="panierconsigne">Votre message a bien été envoyé à l'+"'"+'ASA.<br /><br />'
                textefaq=textefaq+"Nous vous remercions de votre collaboration à l'amélioration  d'AsaDia.</span><br /><br />"
                textefaq=textefaq+'<button  class="adtitre1e" id="faqreset">Fermer le dialogue</button> <br />'
                $( "#faqcontenu" ).html(textefaq);
                $('#faqreset').click(function(){
                    $( "#faqcontenu" ).html("");
                });
            });
            
            $('#faqreset').click(function(){
                $( "#faqcontenu" ).html("");
            });
        });   
    }
  
    // GESTION DE LA VUE PLEINE PAGE DES PANIERS
  
    // lancer le panier  
    $('#lancerpanier').click(function(){
       var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
       var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
       var requete = choixNavigateur();
       var doc = this.id+$('#valeurxdonnees').val()+"_"+largeurf+"_"+hauteurf;
       requete.open("post",doc,false);
       requete.send(null);
       var reponse = requete.responseText;
       window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
       // $('.bouton').hide();
       // initdiaporamagestion();
     });
    
    // écoute du clavier
    $(document).keyup(function(touche){ 
      if(document.title.substring(0,9)=='Diaporama'){  // seulement si diaporama
        var titrepage = document.title;
        // On cherche s'il n'est pas de type "Diaporama (1 sur 9)"
        var titrepage = titrepage.substring(11);
        var pageactuelle = parseInt(titrepage);
        var pos = titrepage.indexOf('sur');
        var totalpage = parseInt(titrepage.substring(pos+4));
        var appui = touche.which || touche.keyCode; // le code est compatible tous navigateurs grâce à ces deux propriétés
        // alert(appui);
        switch (appui) {
          case 39: // touche flèche à droite -> photo suivante
           if (pageactuelle == totalpage) {
             window.close();
           }
           else{
             gerediaporamaclavier('photoapres');
           }
           break;
           
          case 37:  // touche flèche à gauche -> photo précédente
           if (pageactuelle == 1) {
             alert('Vous êtes déjà sur la première photo');
           }
           else{
             gerediaporamaclavier('photoavant');
           }
           break;
             
          case 27:  // touche escape -> fin de diaporama
           window.close();
           break;
          
          case 80:  // touche 'p' -> apparition des boutons d'explication de la photo
            var langue = $("#languecourante").val();
            var numenrpanier = $('#valeurxdonnees').val();
            var doc = langue+'boutonsdiaporama'+$('#numphoto').val()+'£'+pageactuelle;
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
                requete.open("post",doc,false);
                requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#boutonsphotoengrand').html(reponse);
            $('#com').hide();
            $('#fermeture').hide();
            // GESTION DES BOUTONS PLEINE PAGE LORS D'UN DIAPOPRAMA
              /* GESTION DU SURVOL DES BOUTONS*/
                // début survol
                $('.bouton').mouseover(function(){ 
                   var nomimagea = $(this).attr('src');
                   var nomimagen = nomimagea.replace('Repos','Actif');
                   $(this).attr('src',nomimagen);
                })
                // fin survol
                $('.bouton').mouseout(function(){ 
                  var nomimagea = $(this).attr('src');
                  var nomimagen = nomimagea.replace('Actif','Repos');
                  $(this).attr('src',nomimagen);
                })
            
              /* CLIC SUR BOUTONS COMMENTAIRES (id se terminent toutes par "photoeg") */ 
                $('[id*="photoeg"]').click(function(){
                   var french = ($('#quittephotoengrand').attr('title')=="Quitter");
                    /* var init = french?"F":"A"; */
                   var init = $("#languecourante").val();
                   var numdia = $('#numphoto').val();
                   var type = $(this).attr('id');
                   var doc = init+'metlesinfos'+ type.charAt(0)+numdia+"_"+$('#mailvisiteur').val();
                   var requete = choixNavigateur();
                   requete.open("post",doc,false);
                   requete.send(null);
                   var reponse = requete.responseText;
                   $('#com').html(reponse);
                   $('#com').show();
                   $('#fermeture').show();
                   $('[id^="boutonnpc"]').click(function(){
                     affichenpc(this);
                   });
                   $('#faqsumit').click(function(){
                        var contexte = "photo en grand§"+document.title;
                        var doc = 'faqreception' + contexte + '£'+ $('#mailvisiteur').val() + '£' +$('#comfaq').val();
                        var requete = choixNavigateur();
                        requete.open("post",doc,false);
                        requete.send(null);
                        var reponse = requete.responseText;
                        var textefaq = '<br /> Votre message a bien été envoyé à l'+"'"+'ASA.'
                        textefaq=textefaq+"Nous vous remercions de votre collaboration à l'amélioration  d'AsaDia.</span><br /><br />"
                        $( "#com" ).html(textefaq);
                    });
                   
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
                 var french = true;
                 var srcbouton = $('#flechephotoengrand').attr('src');
                   if (srcbouton.substring(0,15) == "images/IconeFle") {
                     var srcbouton = srcbouton.replace('IconeF','IconeNF')
                     var otefleche = french?"Enlever les flèches d'explication":"Remove explanation";
                     $('#flechephotoengrand').attr('alt',otefleche);
                     $('#flechephotoengrand').attr('title',otefleche);
                     var numdia = $('#numphoto').val();
                     var doc = "metlesfleches" + numdia ;
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
            // Fin de GESTION DES BOUTONS PLEINE PAGE LORS D'UN DIAPOPRAMA
           break;        
        } // fin switch
      }; // fin de  seulement si diaporama
    });  // fin du keyup
    
    // gestion la page du diaporama 
    initclicdiaporama();
    
    function initclicdiaporama(){
      if(document.title.substring(0,9)=='Diaporama'){  // seulement si diaporama
        $('#boutonsphotoengrand').html("");  // On vide la zone des boutons
        $('#quittephotoengrand').hide(); // cachons le bouton quitter qui sert à identifier la langue
      }
    }
    
    // gestion de la suppression d'une photo d'un panier 
    function initclicpoubellepanier () {
      $('.poubelle').click(function(){
       var idphoto = '#'+this.id.replace('poubelle','photopanier');
       var mess = "  Voulez-vous vraiment enlever la photo du diaporama ???  <br />"
        $( "#dialog" ).html(mess);
        $( "#dialog" ).attr('title','Enlever la photo du panier');
       $( "#dialog" ).dialog({
          modal: true,
          buttons: {
            "Oui": function() {
              $(idphoto).remove();
              // actualisation de la liste dans 4D
              var doc = ""
              $('[id^="photopanier"]').each(function(){
                  doc = doc+this.id+"£";
              });
              var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
                requete.open("post",doc,false);
                requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
             $( this ).dialog( "close" );
             $( "#dialog" ).html("");
            },
            "Non": function() {
              $( this ).dialog( "close" );
            }
          }
        });
      });
    }
    
    

    
    // gestion des va et vient par bouton du diaporama par les boutons (inactive)
    $('[id^="photoa"]').click(function(){
        gereclicboutonpanier(this);
    });
    
    function gereclicboutonpanier(lui){
      var titrepage = document.title;
       titrepage = titrepage.substring(11);
      var pageactuelle = parseInt(titrepage);
      var pos = titrepage.indexOf('sur');
      var totalpage = parseInt(titrepage.substring(pos+4));
       var idbouton = lui.id;
       var numenrpanier = $('#valeurxdonnees').val();
       var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
       var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
       if (((pageactuelle !== 1)  && (idbouton == 'photoavant')) || ((pageactuelle !== totalpage)  && (idbouton == 'photoapres'))) {
         var requete = choixNavigateur();
         var doc = "diaporamapanier"+numenrpanier+'_'+largeurf+'_'+hauteurf+'£'+idbouton+'£'+document.title;
         requete.open("post",doc,false);
         requete.send(null);
         var reponse = requete.responseText;
         var pos = reponse.indexOf('£');
         var titrepage = reponse.substring(0,pos);
         reponse = reponse.substring(pos+1);
         document.title = titrepage
         $('#photo').html(reponse);
         initclicboutonpanier();
       }
     }

    // gestion des va et vient du diaporama par le clavier
    function gerediaporamaclavier(touche){
      var titrepage = document.title.substring(11);
      var pageactuelle = parseInt(titrepage);
      var pos = titrepage.indexOf('sur');
      var totalpage = parseInt(titrepage.substring(pos+4));
      var numenrpanier = $('#valeurxdonnees').val();
      var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
      var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
      var requete = choixNavigateur();
      var doc = "diaporamapanier"+numenrpanier+'_'+largeurf+'_'+hauteurf+'£'+touche+'£'+document.title;
      requete.open("post",doc,false);
      requete.send(null);
      var reponse = requete.responseText;
      var pos = reponse.indexOf('£');
      var titrepage = reponse.substring(0,pos);
      reponse = reponse.substring(pos+1);
      document.title = titrepage
      $('#photo').html(reponse);
      $('#boutonsphotoengrand').html("");  // On vide la zone des boutons
    }
    
    initclicpoubellepanier();
    
    // Fin de GESTION DES PANIERS

  
 
    

    gerepages('lesion');
    /*  Gestion du changement de page */
     $('[id^="Ajax"]').click (function(){
        var requete = choixNavigateur();
        var doc = "ajaxpage"+this.id+"£"+$("#mailvisiteur").val();
        requete.open("post",doc,false);
        requete.send(null);
        var reponse = requete.responseText;
        $('#corps').html(reponse);
        var liste = "#listelesion";
        var idpage = this.id;
        if (idpage.indexOf("Panier")>0) {
           liste =  "#listepanier";
        } 
        gerepages(liste);
     });
  function sensibilisecases (){
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
        
        $('#typephoto').change(function() // Clic sur le type de photographie
        {
          formulerequete("t");
        });
        
         $('#trouveparnum').change(function() // Clic sur le type de photographie
        {
          envoirequetedia();
        });
  }
  
  function gerepages(liste) {
    // Page diagnose
      
      /*  Masquage intitial des résultats de recherche  */ 
        $('#resultat').hide();
        $('#critere').hide();
        $('#formule').hide();
        $('#boutonvoir').hide();
        
      /*  Masquage intitial du commentaire photo en grand  */
        $('#fermeture').hide();
        $('#com').hide();
        
      sensibilisecases ();
         
    // gestion du clic dans les boutons des images en liste
    function clicsuriconedetailphoto(lui){
      /*
       var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
      var init = french?"F":"A";
      */
      var init = $("#languecourante").val();
      var panier = ($(lui).attr('id').substring(2,3)=="p")  // repère s'il s'agit d'un panier
      var doc = panier ? (init+$(lui).attr('id')+$('#mailvisiteur').val()):(init+$(lui).attr('id'));
      var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
      requete.open("post",doc,false);
      requete.send(null);
      
      var reponse = requete.responseText;/* réception de la réponse de 4D  */
      /* doc.substring(3,9) = repérage du n°de la photo dans les caractères renvoyés par 4D   */
      if (panier) {  // cas du clic sur le bouton "panier" des images en liste
        var idtexte = "#texte"+$(lui).attr('id').substring(3);
        $(idtexte).html(reponse);/* réception de la rubrique */
        /*  effet du clic sur le menu local des paniers*/
        $('[id^="pumpanier"]').change(function(){
          var rang = this.id.substring(9);
          var requete = choixNavigateur();
          var numdiaclic = $("#numdiapopanier"+rang).val();
          var lignepum = $(this).val();
          var doc = "pumpanier"+lignepum;
          requete.open("post",doc,false);
          requete.send(null);
          var reponse = requete.responseText;
          var poslivre = reponse.indexOf("£");
          var nompanier = reponse.substring(0,poslivre);
          reponse = reponse.substring(poslivre+1);
          var poslivre = reponse.indexOf("£");
          var initiales = reponse.substring(0,poslivre);
          var descriptif = reponse.substring(poslivre+1);
          $("#nompanier"+rang).val(nompanier);
          $("#initcreateur"+rang).val(initiales);
          $("#companier"+rang).val(descriptif);
        });
        
        /*  initialisation de clic sur les boutons du dialogue des paniers  */
        $('[id^="panierreset"]').click(function(){
          var idphoto = this.id.substring(12);
          var rang = this.id.substring(11,12);
          var idtexte ='#texte'+idphoto+rang;
          $(idtexte).html("");/* remise à blanc du bloc */
        })
          
        $('[id^="paniersumit"]').click(function(){
            var langue = $("#languecourante").val();
            var rang = this.id.substring(11);
            var numdiaclic = $("#numdiapopanier"+rang).val();
            var requete = choixNavigateur();
            var idtexte ='#texte'+numdiaclic+rang;
            var doc = "panier"+langue+$('#mailvisiteur').val()+"£"+numdiaclic+"£"+$('#nompanier'+rang).val()+"£"+$('#initcreateur'+rang).val()+"£"+$('#companier'+rang).val();
            requete.open("post",doc,false);
            requete.send(null);
            var reponse = requete.responseText;
            if ($('#nompanier'+rang).val()=="") {
              $('#nompanier'+rang).attr("placeholder",reponse);
            }
            else{
              $(idtexte).html(reponse);
            }
            /*
            var message = 'La photographie "'+numdiaclic+'" a été ajoutée au panier "'+$('#nompanier'+rang).val()+'".';
            $(idtexte).html(message);
            }
            */
          
        });
      } // fin de traitement du clic sur le bouton "panier" des images en liste
      
      else{  // autres clics
        var idtexte = "#texte"+doc.substring(4);
        var ideffet = "#com"+doc.substring(4);/* */
        $(idtexte).html(reponse);/* réception de la rubrique */
        $(ideffet).fadeTo(10,0.01);/* Effaçage de la rubrique */
        $(ideffet).fadeTo(1000,0.8); /* Affichage progressif de la rubrique */
        $('[id^="boutonnpc"]').click(function(){
            affichenpc(this)
        })
      }
    }
    
         // Formule diapos isolées
       function envoirequetedia()
        {
            $(":checkbox").prop('checked', false);
            var photoparnum = $("#trouveparnum").val();
            var formule = "n"+photoparnum;
            var requete = choixNavigateur();
            var doc = "affichephotosparnum"+photoparnum;
            requete.open("post",doc,false);
            requete.send(null);
            var reponse = requete.responseText;
            var pos = reponse.indexOf("£");
            var prelude = reponse.substring(0,pos);
            var listephotos = reponse.substring(pos+1);
            $('#trieusephotos').html(listephotos);/* fabrication de la liste d'images à partir de 4D*/ 
            $('#trieusephotos').show();/* montrons la liste d'images*/ 
            $('#formule').html(prelude);/* effaçage du tableau */  
            $('#formule').show();
            $('#tbphotos').html("");/* effaçage du tableau */  
            $('#bouvisetrieuse').hide()/* effaçage du bouton de visualisation de la liste des photos */
            /* toutes les images de choix d'une rubrique */
            /* ont une id de type lp+ x= type de rubrique + n°de la photo  */
            /* donc commençant par lp */
            $('[id^="lp"]').click(function(){
              /* gestion du clic de l'icône de commentaire */
              clicsuriconedetailphoto(this);
              /* gestion du clic de l'image de la lésion dans la fenetre NPC*/
              $('.imageenlistenpc').click(function(){  
                engrand(this);
              });
              /* gestion du clic sur le bouton NPC */
              $('[id^="boutonnpc"]').click(function(){
                affichenpc(this)
              })
            });
            
            /* gestion du survol sur l'icône de commentaire */
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
            
           // gestion du la tudaison de la recherche
            $('#boutuerecherche').click(function(){
              /* Masquage des zones et boutons */
              $('#trieusephotos').hide();
              $('#tbphotos').hide();
              $('#formule').hide();
              $('#boutonvoir').hide();
              $("#trouveparnum").val("")
              /* Décochage des cases */
              $(":checkbox").prop('checked', false);
            });
            
             $('.imageenliste').click(function(){ /* gestion du clic de l'image de la lésion */
                engrand(this);
            });
            
        };
      /*  Fabrication de la formule de recherche */
            /*  Fabrication de la formule de recherche */
      function formulerequete(clic)
        {        
          var languecourante =$("#languecourante").val();   /*  Prise en compte de la langue */
          var gibier = ($('#AjaxLesionFG').length===1); /*  Prise en compte du gibier */

          /* Fabrication de la formule envoyée à 4D */
           // demande par n° des diapos
           if(clic === "n"){
            var photoparnum = $("#trouveparnum").val();
            var formule = "n"+photoparnum;
          }
           // demande par critères autres
          else{  
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
            
            /* Fabrication de la formule envoyée à 4D */
             // gestion des variantes ou non
             if(gibier){
                var typephoto ="t"
              }
              else{
                var typephoto = ($('#toutesdia').is(':checked')==true) ? "t" : "" ;
                if(typephoto==""){
                   typephoto = ($('#sansvariantedia').is(':checked')==true) ? "s" : "v" ;
                 }
              }
           
            // gestion des variantes ou non
           if (languecourante=="F") {
              if(gibier){
                var liste =($('#asa').is(':checked')==true) ? 'y' : 'z' ;
              }
              else{
              var liste= ($('#asa').is(':checked')==true) ? 'x' : 'd' ;               
              }
            }
            else{
              var liste= languecourante ;
            }
            var formule = typephoto+liste+'Espèces : '+esp+"<br />"+'Organes : '+org+"<br />"+'Lésions : '+les;
          }
          
          
          
          /* envoi à 4D */
          var NbPhotosCritere = flipflop(formule);/* Effectue la requete AJAX et renvoie le nombre de photos */
          
          /* Affichage du résultat */
            var pos = NbPhotosCritere.indexOf("§");
            var NbPhotos= NbPhotosCritere.substring(pos+1)

          // demande des photos par leur n°
            if(clic === "n"){
            if (NbPhotos==0) {
                var resumerech ="Aucune photo n'a comme numéro ceux indiqués dans le champ ci-dessus.<br />";
              }
              else{
                
                var resumerech ="Aucune photo n'a comme numéro ceux indiqués dans le champ ci-dessus.<br />";
              }
            }
           // demande par critères autres
          else{  
           
            var afficheres = NbPhotosCritere.substring(0,pos)
            $('#formule').html(afficheres);
            $('#formule').show();
            $("#trouveparnum").val("")
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
          clic.stopPropagation;
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
              /*
              var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
              var init = french? 'F':'A';
              */
              var init = $("#languecourante").val();
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
                /* gestion du clic de l'icône de commentaire */
                clicsuriconedetailphoto(this);
                /* gestion du clic de l'image de la lésion dans la fenetre NPC*/
                $('.imageenlistenpc').click(function(){  
                  engrand(this);
                });
                /* gestion du clic sur le bouton NPC */
                $('[id^="boutonnpc"]').click(function(){
                  affichenpc(this)
                })
              });
              /* gestion du survol sur l'icône de commentaire */
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
            } // fin du else 'Moins de 20 photos'
            
            $('.imageenliste').click(function(){ /* gestion du clic de l'image de la lésion */
                engrand(this);
            });
            
          }  // fin du if  <200 photos
          else{  // plus de 200 photos
            $('#photolesion').html("");/* effaçage de l'image de la lésion sur clic du tableau */  
            $('#tbphotos').html("");/* effaçage du tableau */
          };
          return Prelude;  //  ???
        }
        
        
       /* Page NPC */
      function affichenpc(lui){
          var doc = 'refnpc'+$(lui).attr('id').substring(9)+"_"+$('#mailvisiteur').val();/* fabrication du message AJAX envoyé à 4D  */
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
       
       /* GESTION GRANDE PHOTO COMPLETE */
       
        /* CREATION DE LA PHOTO COMPLETE EN GRAND*/
          function engrand(lui){
            var init = $("#languecourante").val();
            var srcimage = $(lui).attr('src');
            var numimage = srcimage.substring(13,18);
            var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
            var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
            var doc = init+'afficheengrand'+numimage+"_"+largeurf+"_"+hauteurf+"_"+$('#mailvisiteur').val();/* fabrication du message AJAX envoyé à 4D  */
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
            var reponse = requete.responseText;
            window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
          }
          
          function engrandpanier(lui){
           var numimage = lui.id.substring(5);
            var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
            var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
            var doc = "F"+'afficheengrand'+numimage+"_"+largeurf+"_"+hauteurf+"_"+$('#mailvisiteur').val();/* fabrication du message AJAX envoyé à 4D  */
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebAfficheImageEnGrand de 4D  */
            var reponse = requete.responseText;
            window.open(reponse) /* Ouverture dans une nouvelle fenêtre */
          }
          
         /* GESTION du redimentionnement*/
         window.onresize = function(){
            // disparition des fleches
            $('[src*="images/fleche"]').hide();
            $('#flechephotoengrand').attr('alt',"Placer les explications");
            $('#flechephotoengrand').attr('title',"Placer les explications");
            $('#flechephotoengrand').attr('src','images/IconeFleRepos.png');
          };
          
        /* GESTION DU DEBUT DE SURVOL DES BOUTONS*/
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
          $('[id$="photoeg"]').click(function(){
            var french = ($('#quittephotoengrand').attr('title')=="Quitter");
            /* var init = french?"F":"A"; */
            var init = $("#languecourante").val();
            var numdia = document.title.substring(8);
            var type = this.id.charAt(0);
            var doc = init + 'metlesinfos'+ type + numdia + "_" + $('#mailvisiteur').val();
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
            $('#faqsumit').click(function(){
                var contexte = "photo en grand§"+document.title;
                var doc = 'faqreception' + contexte + '£'+ $('#mailvisiteur').val() + '£' +$('#comfaq').val();
                var requete = choixNavigateur();
                requete.open("post",doc,false);
                requete.send(null);
                var reponse = requete.responseText;
                var textefaq = '<br /> Votre message a bien été envoyé à l'+"'"+'ASA.<br />'
                textefaq=textefaq+"Nous vous remercions de votre collaboration à l'amélioration  d'AsaDia.</span><br /><br />" 
                $( "#com" ).html(textefaq);
            });
            
            if (this.id=='pphotoeg') {       
               /*  effect du clic sur le menu local des paniers*/
              $('[id^="pumpanier"]').change(function(){
                var rang = this.id.substring(9);
                var requete = choixNavigateur();
                var numdiaclic = $("#numdiapopanier"+rang).val();
                var lignepum = $(this).val();
                var doc = "pumpanier"+lignepum;
                requete.open("post",doc,false);
                requete.send(null);
                var reponse = requete.responseText;
                var poslivre = reponse.indexOf("£")
                var nompanier = reponse.substring(0,poslivre);
                reponse = reponse.substring(poslivre+1);
                var poslivre = reponse.indexOf("£")
                var initiales = reponse.substring(0,poslivre);
                var descriptif = reponse.substring(poslivre+1);
                $("#nompanier"+rang).val(nompanier);
                $("#initcreateur"+rang).val(initiales);
                $("#companier"+rang).val(descriptif);
              });
              /*  initialisation de clic sur boutons dialogue création d'un panier */
              $('[id^="panierreset"]').click(function(){
                $('#fermeture').trigger('click');
              })
                
              $('[id^="paniersumit"]').click(function(){
                  var langue = $("#languecourante").val();
                  var rang = this.id.substring(11);
                  var numdiaclic = $("#numdiapopanier"+rang).val();
                  var requete = choixNavigateur();
                  var doc = "panier"+langue+$('#mailvisiteur').val()+"£"+numdiaclic+"£"+$('#nompanier'+rang).val()+"£"+$('#initcreateur'+rang).val()+"£"+$('#companier'+rang).val();
                  requete.open("post",doc,false);
                  requete.send(null);
                  var reponse = requete.responseText;
                  if ($('#nompanier'+rang).val()=="") {
                    $('#nompanier'+rang).attr("placeholder",reponse);
                  }
                  else {
                    $('#com').html(reponse);/* actage de l'ajout  */
                  }
                /*
                if ($('#nompanier').val()=="") {
                  $('#nompanier').attr("placeholder","Précisez le nom du panier, SVP");
                }
                else {
                  var rang = this.id.substring(11);
                  var numdiaclic = $("#numdiapopanier"+rang).val();
                  var requete = choixNavigateur();
                  var doc = "panier"+$('#mailvisiteur').val()+"£"+numdiaclic+"£"+$('#nompanier'+rang).val()+"£"+$('#initcreateur'+rang).val()+"£"+$('#companier'+rang).val();
                  requete.open("post",doc,false);
                  requete.send(null);
                  var reponse = requete.responseText;
                  var message = 'La photographie "'+numdiaclic+'" a été ajoutée au panier "'+$('#nompanier'+rang).val()+'".';
                  $('#com').html(message);/* actage de l'ajout
                   }
                  */
                  
               
              });
            }
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
            else{  // on veut alors faire disparaître les flèches
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
       
       // FIN DE GESTION DES IMAGES EN GRAND
       
       
      /* Gestion des deux types de liste  */
    
        
        /* Gestion de la liste anapath */
          $('#asa').on('click', function()
        {
          var gibier = $("#typevisiteur").val();
          var json = '{"nomenclature" : "asa","typevisiteur" : "'+gibier+'"}'
          var doc = 'nomenclature'+json;
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null);
          var reponse = requete.responseText;/* réception de la réponse de 4D  */
          $('#lesion').html(reponse);/* remplacement de la liste */
          $('select').multipleSelect({
              isOpen: true,
              keepOpen: true
            });
          sensibilisecases ();
        });
        
          /* Gestion de la liste dgal */
        $('#dgal').on('click', function()
        {
          var gibier = $("#typevisiteur").val();
          var json = '{"nomenclature" : "dgal","typevisiteur" : "'+gibier+'"}'
          var doc = 'nomenclature'+json;
          var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
          requete.open("post",doc,false);
          requete.send(null);
          var reponse = requete.responseText;/* réception de la réponse de 4D  */
          $('#lesion').html(reponse);/* remplacement de la liste */
          $('select').multipleSelect({
              isOpen: true,
              keepOpen: true
            });
          sensibilisecases ();
        });
        
        /* Fabrication de la liste des images à partir du bouton Voir les photographies */
        function affichelesphotos(une)
        {
          /*
           var french = ($('#flagA').attr('src')=="images/DrapeauA.gif")
          var init = french?"F":"A";
          */
          /* var init = french?"F":"A"; */
          var init = $("#languecourante").val();
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
          
          /* gestion du clic de l'image de choix d'une explication */
          /* toutes les images de choix d'une explication */
          /* ont une id de type lp+ x= type d'explication + n°de la photo + rang */
          /* donc commençant par lp */
          $('[id^="lp"]').click(function(){
            clicsuriconedetailphoto(this);
          });
          $('[id^="boutonnpc"]').click(function(){
            affichenpc(this)
          })
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
        formatetb(liste);
        initclicdetaillesion();
        initclicdetailmotif(); 
        initclicdetailphoto();
        initclicdetailpanier();
        initclicauteurspumpanier();
        initfaqpage ()
    
    // gestion de la modification des caractéristiques du panier
    
        $('[id^="paniervoir"]').click(function(){
            var langue = $("#languecourante").val();
            var doc = this.id+langue;
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $("#voirdescriptifpanier").html(reponse);
            $("#colonnepanier").show();
            $("#voirdescriptifpanier").show();
            $("#boutonspanier").hide();
            $("#ledetailpanier").hide();
            $('#paniersumit').click(function(){
                numenr = $("#NumEnrPanierA").val();
                nompanier = $("#nompanier").val();
                initiales = $("#initcreateur").val();
                companier = $("#companier").val();
                var doc ="paniermodif"+numenr+'£'+nompanier+'£'+initiales+'£'+companier;
                requete.open("post",doc,false);
                requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
                var reponse = requete.responseText;
                $("#voirdescriptifpanier").html("");
                $("#colonnepanier").hide();
                $("#voirdescriptifpanier").hide();
                $("#AjaxPaniers").trigger('click');
            });
            
            $('#paniertuer').click(function(){
              var langue = $("#languecourante").val();
              var doc = "alertesuppanier"+langue;
              var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
              requete.open("post",doc,false);
              requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
              var reponse = requete.responseText;
              var pos = reponse.indexOf('£');
              var oui = reponse.substring(0,pos);
              reponse = reponse.substring(pos+1);
              var pos = reponse.indexOf('£');
              var non = reponse.substring(0,pos);
              var pos = reponse.indexOf('£');
              var titrealerte = reponse.substring(0,pos);
              reponse = reponse.substring(pos+1);
              var alerte = reponse.substring(pos+1);
              $( "#dialog" ).html(alerte);
              $( "#dialog" ).attr('title',titrealerte);
              $( "#dialog" ).dialog({
                  modal: true,
                  buttons: {
                    "yes": function() {
                      numenr = $("#NumEnrPanierA").val();
                      nompanier = $("#nompanier").val();
                      initiales = $("#initcreateur").val();
                      companier = $("#companier").val();
                      var doc ="paniertuer"+numenr;
                      requete.open("post",doc,false);
                      requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
                      var reponse = requete.responseText;
                      $("#voirdescriptifpanier").html("");
                      $("#colonnepanier").hide();
                      $("#voirdescriptifpanier").hide();
                      $("#AjaxPaniers"+langue).trigger('click');
                      $( this ).dialog( "close" );
                    },
                    "no": function() {
                      $( this ).dialog( "close" );
                    }
                  }
              });
            });
            
            $('#panierreset').click(function(){
                $("#voirdescriptifpanier").html("");
                $("#colonnepanier").hide();
                $("#voirdescriptifpanier").hide();
            });
        });
     // gestion de l'envoi du panier pour le partager
    
        $('[id^="panierenvoyer"]').click(function(){
            var langue = $("#languecourante").val();
            var doc = this.id+langue;
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $("#voirdescriptifpanier").html(reponse);
            $("#colonnepanier").show();
            $("#voirdescriptifpanier").show();
            $("#boutonspanier").hide();
            $("#ledetailpanier").hide();
            $('#panierenvoisumit').click(function(){
                numenr = $("#NumEnrPanierA").val();
                login = $("#login").val().replace(/\n/g,";");
                /* envoi de type "panierpartage5014£destinataire@domaine.fr" */
                var doc ="panierpartage"+langue+numenr+'£'+login;
                requete.open("post",doc,false);
                requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
                var reponse = requete.responseText;
                $("#AjaxPaniers").trigger('click');
                $("#voirdescriptifpanier").html(reponse);
                $("#colonnepanier").show();
                $("#voirdescriptifpanier").show();
                $("#boutonspanier").hide();
                $("#ledetailpanier").hide();
            });

            $('#panierenvoireset').click(function(){
                $("#voirdescriptifpanier").html("");
                $("#colonnepanier").hide();
                $("#voirdescriptifpanier").hide();
            });
        });
            
    // masquage initial du détail du panier    
        $("#colonnepanier").hide();
        var langue = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "En":"Fr";
        var nbtotal = $('#nbtotal').val();
        var nbactuel = $('#nbactuel').val();
      
    /* Saisie dans champ de recherche */
        $("#cherchelesion").bind("keyup", function(){
          var name = $("#cherchelesion").val();
          if ((name.length>2)||(name.length==0))
          {
            var langue = $("#languecourante").val();
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            /*
            var trouve = ($('#flagA').attr('src')=="images/DrapeauF.gif")? "searcha":"cherche";
            var indicationf = "Cliquer sur l'icône du détail pour obtenir le contenu de la lésion.";
            var indicationa = "Click the icon detail of lesion you want to display the content. ";
            var mde = ($('#flagA').attr('src')=="images/DrapeauF.gif")? indicationa:indicationf;
            $('#ledetaillesion').html(mde);
            */
            var doc = 'cherche'+langue+name;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebChercheLesion de 4D  */
            var reponse = requete.responseText;
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            var pos = reponse.indexOf('£');
            var instruction = reponse.substring(0,pos);
            $('#ledetaillesion').html(instruction);
            reponse = reponse.substring(pos+1);
            var pos = reponse.indexOf('£');
            reponse = reponse.substring(pos+1);
            $('#nbactuel').val(nb);
            affichetblesion(reponse,'#listelesion');
            initclicdetaillesion();
          }
        });
        
        $("#cherchemotif").bind("keyup", function(){
          var name = $("#cherchemotif").val();
          var gibier = $("#typevisiteur").val();
          var json = '{"nom" : "'+name+'","typevisiteur" : "'+gibier+'"}'
          if ((name.length>2)||(name.length==0))
          {
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var trouve = "motifcherche";
           // var doc = trouve+name;
            var doc = trouve+json;
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
        
        $("#trouvephoto").bind("keyup", function(){
          var name = $("#trouvephoto").val();
          if ((name.length>2)||(name.length==0))
          {
            var langue = $("#languecourante").val();
            var doc = "trouvephoto"+langue+name;
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode WebChercheLesion de 4D  */
            var reponse = requete.responseText;
            
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            var pos = reponse.indexOf('£');
            reponse = reponse.substring(pos+1);
            var pos = reponse.indexOf('£');
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
            var gibier = $("#typevisiteur").val();
            var json = '{"id" : "'+this.id+'","typevisiteur" : "'+gibier+'"}';
            var doc = 'motifdetail'+json;
            /*var haut = findPos(this);
            var rect = this.getBoundingClientRect();
            */
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetailmotif').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+this.id.replace('motifdetail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
          });
        }
        
         function initclicdetaillesion(){
          $('[id^="detail"').click(function(){
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var gibier = $("#typevisiteur").val();
            var json = '{"id" : "'+this.id+'","typevisiteur" : "'+gibier+'"}';
            var doc = 'detaillesion'+json;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetaillesion').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+this.id.replace('detail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
          });
        }
        
        
        function initclicdetailphoto(){
          $('[id^="diadetail"').click(function(){
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var gibier = $("#typevisiteur").val();
            var json = '{"id" : "'+this.id+'","typevisiteur" : "'+gibier+'"}';
            var doc = 'diadetail'+json;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetailphoto').html(reponse);
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+this.id.replace('detail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
            initclicsurphoto()
          });
        }
        
        function initclicdetailpanier(){
          $('[id^="panierdetail"').click(function(){
            var langue = $("#languecourante").val();
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var doc = this.id+langue;
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            $('#ledetailpanier').html(reponse);
            $("#boutonspanier").show();
            $("#ledetailpanier").show();
            $("#voirdescriptifpanier").hide();
            // rendre le panier triable     
            $('#ledetailpanier').sortable({
              containment: "#ledetailpanier", // Le drag ne peut sortir de l'élément qui contient la liste
              /* distance: 10, // Le drag ne commence qu'à partir de 10px de distance de l'élément*/
              // Evenement appelé lorsque l'élément est relaché
              stop: function(event, ui){
                  // Pour chaque item de liste
                  var doc = ""
                  $('[id^="photopanier"]').each(function(){
                      doc = doc+this.id+"£";
                  });
                  var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
                    requete.open("post",doc,false);
                    requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
              }
            });
            $('#colonnepanier').show();
            $('tr.TbCorpsL').removeClass('lignechoisie');/* noircit toutes les lignes  */
            var ligne = '#'+doc.replace('panierdetail','ligne')
            $(ligne).toggleClass('lignechoisie');/* rougit la ligne cliquée  */
            $('#lancepanier').click(function(){
              var langue = $("#languecourante").val();
              var largeurf = $(window).width(); /* Largeur de la fenetre du navigateur */
              var hauteurf = $(window).height();/* Hauteur de la fenetre du navigateur */
              var requete = choixNavigateur();
              var doc = langue+this.id+$('#valeurxdonnees').val()+"_"+largeurf+"_"+hauteurf;
              requete.open("post",doc,false);
              requete.send(null);
              var reponse = requete.responseText;
              window.open(reponse) ;/* Ouverture dans une nouvelle fenêtre */
            });
            initclicpoubellepanier ();
            $('.loupe').click(function(){
                  engrandpanier(this);
                });
            $('#dialog').hide();
          });
        }
        
        function initclicauteurspumpanier(){
          $('[id="auteurspumpanier').click(function(){
            var langue = $("#languecourante").val();
            var requete = choixNavigateur();/* envoi du message AJAX  à 4D  */
            var doc = langue+this.id+$("#mailvisiteur").val()+"£"+$('#auteurspumpanier option:selected').text();
            requete.open("post",doc,false);
            requete.send(null); /* traitée par la méthode aboulelistelesion de 4D  */
            var reponse = requete.responseText;
            var pos = reponse.indexOf('£');
            var nb = reponse.substring(0,pos);
            reponse = reponse.substring(pos+1);
            $('#nbactuel').val(nb);
            affichetblesion(reponse,'#listepanier');
            initclicdetailpanier();
            $('#colonnepanier').hide();
          });
        }
        
        
        // FORMATAGE DES LISTES
        function formatetb(liste){
          var langue = $("#languecourante").val();
          var nbtotal = $('#nbtotal').val();
          var nbactuel = $('#nbactuel').val();
          switch (liste) {
            case "#listemotif":
                var quoinom = "motif";
                var quoiid = "motif";
                nbactuel =(nbactuel=="1")? 'un seul '+quoinom +" " : ' '+nbactuel+" "+quoinom+"s ";
                var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
                var surtotalde = "sur un total de ";
                break;
              
            case "#listelesion":
              var quoinom = "lesion";
              var quoiid = "lesion";
              switch (langue) {
              case "F":
                var lesion = "lésion";
                var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
                nbactuel = (nbactuel=="1")? 'une seule '+quoinom : ' '+nbactuel+" "+quoinom+"s ";
                var surtotalde = "sur un total de " ;
                break;
              
              case "A":
                var lesion = "lesion";
                var rien = "Sorry, no "+quoinom+"s have the string \""+$("#cherche"+quoiid).val()+"\" in the announced criteria"
                nbactuel = (nbactuel=="1")? 'only one '+quoinom: ' '+nbactuel+" "+quoinom+"s ";
                var surtotalde = "out of a total of ";
                break;
                
              case "R":
                var lesion = "повреждения";
                var rien = "Извините, Никакие повреждения , которая отвечает предлагаемым критериям, отсутствует"
                nbactuel = (nbactuel=="1")? '1 '+lesion: ' '+nbactuel+" травма";
                var surtotalde = "из общего числа ";
            
              }
              break;
            
            
            case "#listephoto":
              var quoinom = "photo";
              var quoiid = "lesion";
              switch (langue) {
              case "F":
                var lesion = "lésion";
                var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#trouvephoto").val()+"\" dans les critères de recherche annoncés"
                nbactuel = (nbactuel=="1")? 'une seule '+quoinom : ' '+nbactuel+" "+quoinom+"s ";
                var surtotalde = "sur un total de " ;
                
              case "A":
                var lesion = "lesion";
                var rien = "Sorry, no "+quoinom+"s have the string \""+$("#trouvephoto").val()+"\" in the announced criteria"
                nbactuel = (nbactuel=="1")? 'only one '+quoinom: ' '+nbactuel+" "+quoinom+"s ";
                var surtotalde = "out of a total of ";
                
                
              case "R":
                var lesion = "повреждения";
                var rien = "Извините, Никакие повреждения , которая отвечает предлагаемым критериям, отсутствует"
                nbactuel = (nbactuel=="1")? '1 '+lesion: ' '+nbactuel+" травма";
                var surtotalde = "из общего числа ";
            
              }
              break;
       
            case "#listepanier":
              switch (langue) {
              case "F":
                var quoinom = "panier";
                var quoiid = "panier";
                nbactuel =(nbactuel=="1")? 'un seul '+quoinom +" " : ' '+nbactuel+" "+quoinom+"s ";
                var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
                var surtotalde = "sur un total de ";
              break;
              
              case "A":
                var quoinom = "magazine";
                var quoiid = "panier";
                nbactuel =(nbactuel=="1")? 'un seul '+quoinom +" " : ' '+nbactuel+" "+quoinom+"s ";
                var rien = "Sorry, no "+quoinom+"s have the string \""+$("#cherche"+quoiid).val()+"\" in the announced criteria"
                var surtotalde = "out of a total of ";
              break;
                
              case "R":
                var quoinom = "корзин";
                var quoiid = "panier";
                nbactuel = (nbactuel=="1")? '1 '+lesion: ' '+nbactuel+" корзины";
                var rien = "Извините, Никакие корзин , которая отвечает предлагаемым критериям, отсутствуетт"
                var surtotalde = "из общего числа ";
               break;
              }
            /*
            var quoinom = "panier";
            var quoiid = "panier";
            nbactuel =(nbactuel=="1")? 'un seul '+quoinom +" " : ' '+nbactuel+" "+quoinom+"s ";
            var rien = "Désolé, aucune "+quoinom+" n'a la chaine \""+$("#cherche"+quoiid).val()+"\" dans les critères de recherche annoncés"
            var surtotalde = "sur un total de ";
            break;
            */

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
        
        // FIN DE FORMARAGE DES LISTES
      
        // fin de la gestion des listes
        
        // APPEL DU CLIC SUR PHOTO REDUITE
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
        // Fin de gestion des textes
   
        
           
         
           
           liste.stopPropagation;

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

  