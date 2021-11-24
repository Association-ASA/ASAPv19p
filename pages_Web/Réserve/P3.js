	function ctrl_ech(nb) {
var nb_v = nb.value;
// testons le remplissage
if(nb_v!="") {

// c'est rempli, vidons les espaces vides...
do {
  ancnb=nb_v
  nb_v=nb_v.replace(" ","");
}
while  (ancnb!=nb_v);

//le reste est-il un nombre ???
if(isNaN(nb_v)) {
	var mess="j'attendais un nombre dans un champ concernant le resutlat";
alert(mess);
nb.value="";
return false;
			}
// si oui, est-il valide (entier positif ou nul ou 0.1)
else {
if(((Math.floor(nb_v)!=nb_v) && (nb_v!=0.1))||(nb_v<0))
				{
var mess="j'attendais un nombre entier positif ou 0.1 dans un champ concernant le resutlat";
alert(mess);
nb.value="";
return false;
				}
			}
		}
// le nombre est bon

var val_format=nb_v+"";
	var nbf=val_format.length;
	for (var i=1;i<4;i++) {
		if (nb_v>=Math.pow(10,(3*i))) {
			val_format=val_format.substring(0,nbf-(3*i))+" "+val_format.substring(nbf-(3*i));
		}
	}
nb.value=val_format
return true;
	}

function ctrl_nb(nb) {
var nb_v = nb.value;
// testons le remplissage
if((nb_v!="") && (isNaN(nb_v))) {
	var mess="j'attendais un nombre dans ce champ";
alert(mess);
nb.value="";
return false;
		}
	}

function ctrl_date(d) {
      // Cette fonction vérifie le format JJ/MM/AAAA saisi et la validité de la date.
      // Le séparateur est défini dans la variable separateur
      var d_v = d.value;
      if(d_v!="") {
var amin=2007; // année mini
      var amax=2010; // année maxi
      var separateur="/"; // separateur entre jour/mois/annee
      var j=(d_v.substring(0,2));
      var m=(d_v.substring(3,5));
      var a=(d_v.substring(6));
      var ok=1;
      if ( ((isNaN(j))||(j<1)||(j>31)) && (ok==1) ) {
         alert("Le jour n'est pas correct."); ok=0;
         d.value="";
      }
      if ( ((isNaN(m))||(m<1)||(m>12)) && (ok==1) ) {
         alert("Le mois n'est pas correct."); ok=0;
         d.value="";
      }
      if ( ((isNaN(a))||(a<amin)||(a>amax)) && (ok==1) ) {
         alert("L'année n'est pas correcte."); ok=0;
         d.value="";
      }
      if ( ((d.substring(2,3)!=separateur)||(d.substring(5,6)!=separateur)) && (ok==1) ) {
         alert("Les séparateurs doivent être des "+separateur); ok=0;
         d.value="";
         
      }
      if (ok==1) {
         var d2=new Date(a,m-1,j);
         j2=d2.getDate();
         m2=d2.getMonth()+1;
         a2=d2.getFullYear();
         if (a2<=100) {a2=1900+a2}
         if ( (j!=j2)||(m!=m2)||(a!=a2) ) {
            alert("La date "+d+" n'existe pas !");
            ok=0;
            d.value="";
         }
      }
      return ok;
      }
   }
