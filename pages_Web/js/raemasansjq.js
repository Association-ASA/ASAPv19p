/*function flipflop(arg1,arg2)
{
 document.getElementById(arg2.substring(3)).hidden = (arg1.substring(0,1) !== " ") 
  if (arg1.substring(0,1) == " ") {
    document.getElementById(arg2.substring(3)).focus();
  }
}
  */


function CACFlipFlop(id)
{
  var idchamp="Champ"+id.substring(0,4);
  var status= !(document.getElementById(id).checked);
   document.getElementById(idchamp).hidden = status;
   
  if (status==false) {
    document.getElementById(idchamp).focus();
  }
  else
  {
    document.getElementById(idchamp).value="";
  }
}


function flipflop(val,nom)  
{
var requete = choixNavigateur();
var doc = "flipflop"+val+","+nom;
requete.open("post",doc,false);
requete.send(null);
// alert(requete.responseText);
var reponse = requete.responseText;
var pos = reponse.indexOf(",");
var champ = reponse.substring(0,pos);
var statut = false;
var statutalpha = reponse.substring(pos+1)
if (statutalpha==="0"){
var statut = true;
}

// var reponse = requete.responseText;

var monchamp = document.getElementById(champ);
monchamp.hidden = statut;
if (status==false) {
 document.getElementById(champ).focus();
}
}



function choixNavigateur() 
{
if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
return new ActiveXObject('Microsoft.XMLHTTP');
else
return new XMLHttpRequest();  
}
 
  
function Copperfield(nb,vchoix)
{
  var nb_v = nb.value;
  var rang1 = nb_v.substring(0,2);
  var rang2 = vchoix.substring(0,2);
 
  // testons le remplissage
  for (var i=1;i<=8;i=i+1) 
    {
      var nomid = "david" + i
      document.getElementById(nomid).hidden = (rang1<11);
    
    }
}
     
function Schiffer(nb,vchoix)
{
  var nb_v = nb.value;
  var rang1 = nb_v.substring(0,2);
  var rang2 = vchoix.substring(0,2);
 
  // testons le remplissage
  for (var i=1;i<=17;i=i+1) 
    {
      var nomid = "claudia" + i;
      document.getElementById(nomid).hidden = (rang1<10);
    
    }
}

function initpage()
{
 Copperfield(document.getElementById("PUM1001"),'11 - NF V 08-013 (ISO 6579)');
 Schiffer(document.getElementById("PUM1101"),'11 - NF V 08-013 (ISO 6579)');
  
}

function ctrl_champ(champ){
  var monchamp = champ.value;
  monchamp = replaceAll(monchamp, "\t","  ");
  monchamp = replaceAll(monchamp, "\r","  ");
  champ.value = monchamp;
}


function replaceAll(str, find, replace) {
  return str.replace(new RegExp(find, 'g'), replace);
}

function ctrl_ech(nb)
  {
    var ok = 1;
    var nb_v = nb.value;
    // testons le remplissage
    if(nb_v!="") {
    
    // c'est rempli, vidons les espaces vides...
      do {
        ancnb=nb_v;
        nb_v=nb_v.replace(" ","");
      }
      while  (ancnb!=nb_v);
    
    //le reste est-il un nombre ???
      if(isNaN(nb_v)) {
        var mess="j'attendais un nombre entier strictement positif ou 0.1 dans un champ concernant le résultat";
        alert(mess);
        nb.value="";
        ok = 0;
      }
    // si oui, est-il valide (entier positif ou nul ou 0.1)
      else {
        if(((Math.floor(nb_v)!=nb_v) && (nb_v!=0.1))||(nb_v<=0))
        {
          var mess2="j'attendais un nombre entier strictement positif ou 0.1 dans un champ concernant le résultat";
          alert(mess2);
          nb.value="";
          ok = 0;        }
      }
    }
    if (ok == 0) {
      erreur(nb)
    }
    else{
      nb.style.backgroundColor = "#ffffff"; 
      // le nombre est bon
      var val_format=nb_v+"";
      var nbf=val_format.length;
      for (var i=1;i<4;i++) {
        if (nb_v>=Math.pow(10,(3*i))) {
          val_format=val_format.substring(0,nbf-(3*i))+" "+val_format.substring(nbf-(3*i));
        }
      }
      nb.value=val_format
    }
  }

function ctrl_nb(nb) 
	{
    var nbre = nb.value.replace(',','.');
    if ((nbre!="") && (parseFloat(nbre)!=nbre)) {
      alert("j'attendais un nombre dans ce champ");
      erreur(nb);
    }
    else{
     nb.style.backgroundColor = "#ffffff"; 
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
  }
  
function TestEch(nb) {
    var mp_c = nb.value;
    var lgmdp = mp_c.length;
    var guil="'";
    var mess="";
    if ((mp_c!="") && (lgmdp!=6)) {
    mess="Le code comporte 6 CHIFFRES et non"+lgmdp;
    alert(mess);
    erreur(nb);
    }
    else{
     nb.style.backgroundColor = "#ffffff"; 
    }
  }

 // erreur
  function erreur(champ){
    champ.style.backgroundColor = "#fba";
    champ.value="";
    setTimeout(function(){champ.focus()},0); 
  }
  