// JAVASCRIPT de l'ASA


// Fontion de vérification d'un email
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
}
  
  
function ctrl_date(madate)
	{
    var dat = madate.value;
    var ok = 1;
    if (dat!="") {
     
      if (dat.length==8) {
        var jour = dat.substring(0,2);
        var mois = dat.substring(3,5);
        var annee = dat.substring(6);
        var now = new Date();
        now = now.getFullYear()-2000;
        var amax=now; // année maxi
        var amin=now; // année mini
        if ((jour<1) ||(jour>31)) {
          //code  
          alert( "Le jour n'est pas correct.");
          var ok = 0;
        }
        if ((mois<1) ||(mois>12) && (ok==1)) {
          //code
          alert( "Le mois n'est pas correct.");
          var ok = 0;
        }
        if ( ((isNaN(annee))||(annee<amin)||(annee>amax)) && (ok==1) ) {
          alert( "L'année n'est pas correcte.");
          var ok = 0;
        }
        if ((dat.indexOf("/") != 2 ) || (dat.lastIndexOf("/") != 5) &&  (ok == 1)){
         alert( "Vous n'avez pas mis les séparateurs aux bons endroits.");
          var ok = 0;
        }
        var an = "20"+annee;
        var dt = new Date(an,mois-1,jour);
        if ((dt.getMonth()!=mois-1) &&  (ok == 1)) {
          alert("La date n'existe pas.");
          var ok = 0;
        }
        else{      
        }
      }
      else{
        alert("Vous avez saisi " + dat+". Cela ne correspond pas à une date formatée en jj/mm/aa.");
        var ok = 0;
      }
    }
    if (ok == 0) {
      erreur(madate)
    }
    else{
      madate.style.backgroundColor = "#ffffff"; 
    }
	}
   


 // erreur
  function erreur(champ){
    champ.style.backgroundColor = "#fba";
    champ.value="";
    setTimeout(function(){champ.focus()},0); 
  }
  