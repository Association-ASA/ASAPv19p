// JAVASCRIPT du schéma du RAEMA : règle le manchon
// en fonction de la date du jour (valeur dans le champ caché id="champcache")
$(function(){    // Début du jQuery : attente du DOM
  
   /*
  $('#printpage').click(function(){
   window.print();
    alert("gasp");
  });
  */
  
 var intervalle = $('#champcache').val();
 $('.Manchon').css('left',intervalle);
 
 
 $('.imprime').click(function(){
    window.print();
 });
 
});