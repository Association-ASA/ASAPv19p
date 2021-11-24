$(function() {
  $('#images img').draggable(); // on rend les images de la galerie déplaçables
  $('.preferance').droppable(); // on initialise une zone de dépôt
  $('#liste').sortable(); // la liste contenant les images préférées est déclarée de façon à ce qu'on puisse ranger ces dernières
  $('#listeSuppr').selectable(); // enfin, la liste contenant les images supprimées est déclarée de façon à ce qu'on puisse sélectionner celles-ci

  
  $('#images img').draggable({
    revert : 'invalid', // on renvoie les images à leur place si elles ne sont pas déposées au bon endroit
    cursor : 'move', // on définit un nouveau curseur pour aider le visiteur à comprendre l'action
    stack : '#images img' // option dont je n'ai pas parlé, elle permet de mettre au premier plan l'image déplacée (cela empêche les autres de passer au-dessus)
  });
  
  $('.preferance').droppable({
      accept : '#images img', // très important, ce paramètre permet de n'accepter que les images de la galerie
      activeClass : 'hover', // classe appelée lorsqu'on commence l'action de transition
      hoverClass : 'active' // classe appelée lorsqu'on rentrer l'image dans la bonne zone
  });
  
  $('#liste').sortable({
      revert : true // les images sorties lors du rangement sont remises automatiquement à la bonne place
  });
  
  $('#listeSuppr').selectable();
  
  $('#images img').draggable({
    revert : 'invalid', // on renvoie les images à leur place si elles ne sont pas déposées au bon endroit
    cursor : 'move', // on définit un nouveau curseur pour aider le visiteur à comprendre l'action
    stack : '#images img' // option dont je n'ai pas parlé, elle permet de mettre au premier plan l'image déplacée (cela empêche les autres de passer au-dessus)
  });

  $('.preferance').droppable({
      accept : '#images img', // très important, ce paramètre permet de n'accepter que les images de la galerie
      activeClass : 'hover', // classe appelée lorsqu'on commence l'action de transition
      hoverClass : 'active', // classe appelée lorsqu'on rentrer l'image dans la bonne zone
      drop : function(event, ui){ // fonction de callback équipée de deux arguments, qui vont nous servir à récupérer l'élément courant
      }
  });
  
  $('#liste').sortable({
      revert : true // les images sorties lors du rangement sont remises automatiquement à la bonne place
  });
  
  $('#listeSuppr').selectable({
      stop : function(){ // cet évènement sert à lancer l'action une fois la sélection finie
      }
  });
  
  $('.preferance').droppable({
    accept : '#images img',
    activeClass: 'hover',
    hoverClass: 'active',
    drop : function(event, ui){
    var current = ui.draggable; // on récupère l'élément étant déplacé
    }
  });
  $('.preferance').droppable({
    accept : '#images img',
    activeClass: 'hover',
    hoverClass: 'active',
    drop : function(event, ui){
    var current = ui.draggable; // on récupère l'élément étant déplacé
    var path = current.attr('src'); // récupération du chemin de l'image déplacée
    var list = $('#liste'); // on stock l'identifiant de la liste qui contiendra nos images
    }
  });
  
  $('.preferance').droppable({
    accept : '#images img',
    activeClass: 'hover',
    hoverClass: 'active',
    drop : function(event, ui){
      var current = ui.draggable; // on récupère l'élément étant déplacé
      var path = current.attr('src'); // récupération du chemin de l'image déplacée
      var list = $('#liste'); // on stock l'identifiant de la liste qui contiendra nos images
      current.fadeOut(function(){ // nouvelles fonction de callback, qui s'exécutera une fois l'effet terminé
      current.parent().remove(); // élimination de l'élément courant
      list.append('<li><img src="' + path + '" /></li>'); // et enfin, ajout de l'image dans la liste des images préférées
      });
    }
  });
  
  $('.ui-icon-trash').click(function(){ // utilisation de l'évènement click sur l'icône
    var current = $(this); // on récupère l'élément courant
    var li = current.parent(); // on va chercher le parent de ce dernier, c'est-à-dire l'élément de liste contenant l'image
    var image = li.find('img'); // on récupère celle-ci grâce à la fonction find de jQuery
    var path = image.attr('src'); // et enfin, on stock le chemin menant à l'image
    li.fadeOut(function(){ // même chose que précédemment
    $('#listeSuppr').append('<li><img src="' + path + '" /></li>');
    });
  });
  
  $('#listeSuppr').selectable({
    stop : function(){
    }
  });
  
  $('#listeSuppr').selectable({
    stop : function(){
      $('.ui-selected', this).each(function(){ // tous les éléments sélectionnés sont traités
        $(this).remove(); // puis supprimés
      });
    }
  });
  
});