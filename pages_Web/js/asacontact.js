/*   AsaContact  */

function choixNavigateur() 
 {
   if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
   return new ActiveXObject('Microsoft.XMLHTTP');
   else
   return new XMLHttpRequest();  
 }
 
 
$(function(){    // attente du DOM pour jQuery
  $('#ac').click(function(){
    varnumasacontact = $('#ac').text();
    varnumasacontact = varnumasacontact.substring(11);
    var doc = "asacontact"+varnumasacontact;
        var requete = choixNavigateur();
        requete.open("post",doc,false);
        requete.send(null);
    
  });
 
 $('[id^="Cache"]').hide();
  $('[type="radio"]').prop('checked',false);
  $('#Q1R1').change(function(){
    if ($('#Q1R1').is(':checked')===true){
      $('[id^="CacheQ1R1"]').show('slow');
      $('[id^="CacheQ1R2"]').hide('slow');
    }
  });    
  $('#Q1R2').change(function(){
      if ($('#Q1R2').is(':checked')===true){
        $('[id^="CacheQ1R2"]').show('slow');
        $('[id^="CacheQ1R1"]').hide('slow');
      }
  });
 $('#Q4R2').change(function(){
      if ($('#Q4R2').is(':checked')===true){
        $('[id^="CacheQ4R2"]').show('slow');
      }
  });
 $('#Q4R1').change(function(){
      if ($('#Q4R1').is(':checked')===true){
        $('[id^="CacheQ4R2"]').hide('slow');
      }
  });
 
 $('#Q5R1').change(function(){
      if ($('#Q5R1').is(':checked')===true){
        $('[id^="CacheQ5R1"]').show('slow');
      }
  });
 $('#Q5R2').change(function(){
      if ($('#Q5R2').is(':checked')===true){
        $('[id^="CacheQ5R1"]').hide('slow');
      }
  });
 
 
 $('#Q8R1').change(function(){
      if ($('#Q8R1').is(':checked')===true){
        $('[id^="CacheQ8R1"]').show('slow');
      }
  });
 $('#Q8R2').change(function(){
      if ($('#Q8R2').is(':checked')===true){
        $('[id^="CacheQ8R1"]').hide('slow');
      }
  });
 
});