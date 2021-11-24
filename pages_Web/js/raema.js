// JAVASCRIPT du RAEMA

$(function(){    // Début du jQuery : attente du DOM
  
  
  
  // Gestion des langues dans l'espace client
 /*
  $("#flagA").click(function(e){
    
    var nomimage = $("#flagA").attr('src');
    if(nomimage.indexOf('DrapeauA')>0){
      var doc = "espaceclientA";
      $("#flagA").attr('src','images/DrapeauF.gif');
    }
    else{
      var doc = "espaceclientF";
      $("#flagA").attr('src','images/DrapeauA.gif');
    }
    doc = doc+$('#UUIDLabo').val();
    var requete = choixNavigateur();
    requete.open("post",doc,false);
    requete.send(null);
    e.stopPropagation;
  });
*/
  
function initpage()
  {
    // GESTION DES DISPARITIONS Salmonelles et Listeria

    pumdavid = "PUM1001";
    DavidetClaudia (pumdavid,6);
    
    pumclaudia = "PUM1101";
    DavidetClaudia (pumclaudia,8);

    $('.escamotage').change(function(){
      var valeurclasse = $(this). children("option:selected"). attr("class");
      var selectedoption = $(this). children("option:selected"). val();
      var valeuroption = $(this). children("option:selected"). text();
      var tableclass = '#page'+this.id.substr(3,2)+' tr';
      
      $(tableclass).show();
      $(".tr"+valeurclasse).hide();
      $('.raematbp2').each(function() {
          $('tr[td]:even', this).addClass('lignepaire');
          $('tr[td]:odd', this).addClass('ligneimpaire');
      }); 
      var compte = 0  // Décompte des lignes visibles
      $(tableclass).each(function(index) {
        // Ligne visible = celle où il faut appliquer le pyjama
        if(index >0){
          if ($(this).is(':visible')){  
            compte=compte+1;  // Incrémentation du compteur de ligne visible
            $(this).removeClass('lignepaire');  // On enlève la classe 'lignepaire'
            $(this).removeClass('ligneimpaire');// On enlève la classe 'ligneimpaire'
            // on recupère par une ternaire la nouvelle classe
            var nomclass = (compte%2 === 1)? 'lignepaire' :'ligneimpaire' ;
            $(this).addClass(nomclass); // On l'applique
          }; 
        }
      });
    });
    
    // Gestion de la visibilité des avertissements ZScore
    for (var n=2; n<13 ; n=n+1) { // pour les 12 pages
      var zero = (n<10)? "0":""; // formatage de la page
      var idzscore = "#zscore"+zero+n  // l'ID possible de la ligne (tr) d'averissement
      var classezscore = $(idzscore).attr("class") // permet de tester si l'avertissement existe
      if(classezscore !== undefined){ // seulement s'ile existe
        var idprecedente = $(idzscore).prev().attr("id")  // ID du frère précédent = du tr juste avant = dernier résultat type Ligne0218 
        var idchamp = idprecedente.replace("Ligne","Champ");// ID champ = remplacer Ligne par Champ
        var iddebutchampdep = idchamp.substring(0,7); // Début de l'ID de premier champ de résultat type Champ02
        var idfinchampdep = idchamp.substring(7)-4; // fin de l'ID de premier champ de résultat type 14
        var idchampdep = iddebutchampdep + idfinchampdep; // l'ID du premier champ de résulat
        var lignevisible = false; // On pense qu'il a tout rempli !!!
        for (var i=0;i<=4;i=i+1) { // pour les 5 champs
          var idcourante = "#" + iddebutchampdep + (idfinchampdep + i)// Champ concerné
          if ($(idcourante).val() === "") {// si non rempli
            lignevisible = true;// La ligne sera invisible
            break; // sortons de la boucle
          }
        }
        // Visibilité ou non en fonction de lignevisible
        if (lignevisible) {
           $(idzscore).show(); // On montre
        }
        else {
          $(idzscore).hide();  // On cache
        }
      }
    }
  }
  
  initpage()
  
  
  /*
   
  $('input').keydown(function(event) { //remplacez {id_img} par l'id de votre image
    var event = event || window.event;
    if(event.keyCode==13) {
      if (event.preventDefault) {
        event.preventDefault();
        event.stopPropagation();
      } else {
        event.returnValue = false;
        event.cancelBubble = true;
      }		
    }
  });
  */
  // RAEMA GEL
  
  // Page 2 =  CHOIX DES GERMES
  // on cache par défaut
  // $('[name^="textfield"]').hide();
  
  //Gestion du clic dans une case à cocher
  $('[name^="rgcb"]').change (function(){
    var rang = $(this).attr('name').substring(4);
    var champ = "rgtextfield"+rang;
    if ($(this).is(':checked')==true)
    {
     //  $('[name='+champ+']').show();
      setTimeout(function(){$('[name='+champ+']').focus()},0); 
    }
    else
    {
      //  $('[name='+champ+']').hide();
       $('[name='+champ+']').val("");
    }
  });
  
  // Gestion du champ  : on coche la case correspondante si le champ est rempli
  	
    $('[name^="rgtextfield"]').focusout(function(){
    ctrl_nbrg(this);
    var rang = $(this).attr('name').substring(11);
      var cb = "rgcb"+rang;
      if (this.value!=="")
      {
       $('[name='+cb+']').attr('checked',true);
      }
      else // on décoche la case correspondante si le champ est vide
      {
       $('[name='+cb+']').attr('checked',false);
      }
  });
    
    
  // 
  
  
  // P3
  
  // CONTROLES DE LA VALIDITE DES CHAMPS Colonne 3
  
  // Les dates
    $('.champdate').change(function ()
    {
      var requete = choixNavigateur();
      var doc = "raemadate";
      requete.open("post",doc,false);
      requete.send(null);
      var reponse = requete.responseText;
      ctrl_dateraema(this,reponse)    }
  );
    
    // Les nombres
    $('.champnum').change(function ()
    {
      ctrl_nb(this);
    }
  );
    
    // Les échantillons
    $('.champech').change(function ()
    {
      ctrl_ech(this);
    }
  );
    
    
  // GESTION DES DISPARITIONS Choix PUM autres (other)
    $('.flipflop').change(function ()
    {
      var val = this.value;
      var nom = this.name;
      flipflop(val,nom)
    }
  );
    
  // GESTION DES DISPARITIONS Boites à cocher autres (other)
    $('.CACFlipFlop').change(function ()
    {
      var presence = $(this).is(':checked')?"show":"hide";
      var idcac = this.id;
      /*  var idchamp = (idcac.substring(0,2)=="10")?'#Champ1007':'#Champ1112';*/
      var idchamp = '#Champ'+idcac;
      if (presence=="hide") {
       $(idchamp).hide();
       $(idchamp).val("");
      }
      else{
       $(idchamp).show();
      }
    }
  );
    
 
  
  // Fonction commune à Salmonelles et Listeria
  function DavidetClaudia (pum,rang)
  {
    var rangpum = parseInt($("#"+pum).val()) ;
    var nomdiv = (pum=="PUM1001")? 'david':'claudia';
    var sel = '[id^='+nomdiv+']';
    var selchamp = sel+' input:text';
    var selcase = sel+' input:checkbox';
    var selpum = sel+' select';
    if (rangpum < rang) {
      $(sel).hide();
      // Remise à zéro des valeurs escamotables
      $(selchamp).val("");
      $(selcase).attr('checked',false);
      $(selpum).val('0');
    }
    else
   {
      $(sel).show();
   }
  };
  
  // traitement de David = Salmonelles
  $("#PUM1001").change(function(){
    DavidetClaudia ("PUM1001",6)
  });
  
  // traitement de Claudia = Listeria
  $("#PUM1101").change(function(){
    DavidetClaudia ("PUM1101",8)
  });
 
  $('.escamotage').change(function(){
    var valeurclasse = $(this). children("option:selected"). attr("class");
    var selectedoption = $(this). children("option:selected"). val();
    var valeuroption = $(this). children("option:selected"). text();
    var tableclass = '#page'+this.id.substr(3,2)+' tr';
    
    $(tableclass).show();
    $(".tr"+valeurclasse).hide();
    $('.raematbp2').each(function() {
        $('tr[td]:even', this).addClass('lignepaire');
        $('tr[td]:odd', this).addClass('ligneimpaire');
    }); 
    var compte = 0  // Décompte des lignes visibles
    $(tableclass).each(function(index) {
      // Ligne visible = celle où il faut appliquer le pyjama
      if(index >0){
        if ($(this).is(':visible')){  
          compte=compte+1;  // Incrémentation du compteur de ligne visible
          $(this).removeClass('lignepaire');  // On enlève la classe 'lignepaire'
          $(this).removeClass('ligneimpaire');// On enlève la classe 'ligneimpaire'
          // on recupère par une ternaire la nouvelle classe
          var nomclass = (compte%2 === 1)? 'lignepaire' :'ligneimpaire' ;
          $(this).addClass(nomclass); // On l'applique
        }; 
      }
    });
  });

  
  
  function flipflop(val,nom)  
  {
    var requete = choixNavigateur();
    var doc = "flipflop"+val+","+nom;
    requete.open("post",doc,false);
    requete.send(null);
    var reponse = requete.responseText;
    var pos = reponse.indexOf(",");
    var champ = reponse.substring(0,pos);
    var idchamp = "#"+champ;
	var idprecision = idchamp.replace("Champ","precision")
	var langue = $('[name="langage"]').val();
 	var precision = (langue=="A")? "Please specify":"Merci de préciser";
   if (reponse.substring((pos+1),(pos+2))==="0"){
       $(idchamp).hide();
       $(idchamp).val("");
       $(idprecision).html("")
     }
     else{
       $(idchamp).show();
       $(idprecision).html(precision);
     }
    
    // milieu et fabricant f(méthode)
    var livre =  reponse.indexOf("£");
    if (livre >0) {
      var milfab = reponse.substring(livre+1);
      var pv = milfab.indexOf(";");
      var mil = milfab.substring(0,pv);
      var idpum = "#PUM"+mil.substring(0,4)
      var ligne = mil.substring(4)
      var selecteur = idpum+" option:eq("+ligne+")"
      $(selecteur).prop('selected', true);
      
      var fab = milfab.substring(pv+1);
      var idpum = "#PUM"+fab.substring(0,4)
      var ligne = fab.substring(4)
      var selecteur = idpum+" option:eq("+ligne+")"
      $(selecteur).prop('selected', true);
      
    }
  }

  // Vérification de l'existence des numéros d'échantillon
  $(".raematradcasep1").change(function(){
    var requete = choixNavigateur();
    var doc = "ControleEch"+$(this).val();
    var french =( $('[name="langage"]').val() === "F")
    requete.open("post",doc,false);
    requete.send(null);
    var reponse = requete.responseText;
    var LongueurChaine = doc.length;
    if(LongueurChaine < 17){
      var mess = french ? "Désolé, le numéro d'échantillon doit contenir 6 caractères" : "Sorry, sample number must contain 6 caracters";
      alert(mess);
      erreur(this);
    }
    if(reponse == "N"){
      var mess = french ? "Désolé, le numéro d'échantillon "+$(this).val()+" n'a pas été distribué" : "Sorry, sample number "+$(this).val()+" was not distributed";
      alert(mess);
      erreur(this);
    }
    else
    {
      var requete = choixNavigateur();
      var doc = "ControleSer";
      $(".raematradcasep1").each(function(){
        doc = doc + $(this).val();
      });
      requete.open("post",doc,false);
      requete.send(null);
      var reponse = requete.responseText;
       if(reponse == "N"){
        var mess = french ? "Désolé, les numéros d'échantillon saisis ne sont pas compatibles" : "Sorry, the entered sample numbers are not compatible";
        alert(mess);
        erreur(this);
      }
    }
    });
  
  // Message d'alerte pour parer les laboratoires qui entrent UFC au lieu de concentration
  $(".dilech").change(function(){
    var classe = $(this).attr('class');
    var estcedil =(classe.indexOf("champdil")>=0)? true:false;
    if(estcedil == true){
      var iddil = $(this).attr('id');
      var idalerte = "#" + iddil.replace("Champ","alert");
      var dilution = $(this).val();
      var requete = choixNavigateur();
      var doc ="FileLeTbDeDilution"+dilution 
      requete.open("post",doc,false);
      requete.send(null);
      var reponse = requete.responseText;
      if (reponse=="0") {
        $(this).val("");
        var french =( $('[name="langage"]').val() === "F")
        var textalerte = french ? "Attention ! la dilution '"+dilution+"' que vous avez renseignée n'est pas prévue (voir plus haut) " : "Warning ! the dilution '"+dilution+"' you have reported is not supported (see supra)";
        $(idalerte).html(textalerte);
      }
      else{
        $(this).val(reponse);
        $(idalerte).html("");
      }
      var idufc = iddil.substring(0,7);
      var reste = parseInt(iddil.substring(8))+5;
      var idufc = "#"+idufc + reste;
      var concentration = $(idufc).val();
    }
    else
    {
      $(idalerte).html("");
      var iddil = $(this).attr('id');
      var concentration = $(this).val();
      var idufc = iddil.substring(0,7);
      var reste = parseInt(iddil.substring(7))-5;
      if(reste<10){
        reste= "0"+reste;
      }
      var idufc = "#"+idufc + reste;
      var idalerte = idufc.replace("Champ","alert");
      var dilution = $(idufc).val();
    }
    if ((dilution < -2) && (concentration < 999) && (concentration !="")){
      var french =( $('[name="langage"]').val() === "F")
      var textalerte = french ? "Attention ! Il semble qu'il y ait une incohérence entre la dilution et la concentration que vous avez renseignées" : "Warning ! There appears to be an incoherence between the dilution and the concentration you have reported";
      $(idalerte).html(textalerte);
    }
  });  
  
  
  // Préviens les laboratoires qu'ils doivent rentrer 5 concentrations
 $('.champech').change(function(){
   var idchamp =$(this).attr('id');
   var rang =$(this).attr('rang');
   var iddebutchampdep = idchamp.substring(0,7);
   var idfinchampdep = idchamp.substring(7)-rang+1;
   var idpage = idchamp.substring(5,7);
   var idchampdep = iddebutchampdep + idfinchampdep;
   var lignevisible = false;
   for (var i=0;i<=4;i=i+1) {
      var idcourante = "#" + iddebutchampdep + (idfinchampdep + i)
      if ($(idcourante).val() === "") {
        lignevisible = true;
        break;
      }
   }
    var idzscore = "#zscore"+idpage
    if (lignevisible) {
      $(idzscore).show();
    }
    else {
      $(idzscore).hide();
    }

 });
 


 // Gestion du clic sur un lien de téléchargement du rapport
 
    $('[href^="DR/RI"]').mousedown(function(event){
             
      if(( event.which == 1 ) || ( event.which == 3 )){
        var requete = choixNavigateur();        
        var doc = $(this).attr("href");
        requete.open("post",doc,false);
        requete.send(null);
      };
    });
});   // fin du jQuery 


function choixNavigateur() 
{
if (navigator.userAgent.indexOf('MSIE 6')!=-1) 
return new ActiveXObject('Microsoft.XMLHTTP');
else
return new XMLHttpRequest();  
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
      var french =( $('[name="langage"]').val() === "F")

    //le reste est-il un nombre ???
      if(isNaN(nb_v)) {
        var mess = french ? "j'attendais un nombre entier strictement positif ou 0.1 dans un champ concernant le résultat" : "I was expecting a strictly positive integer or 0.1 in a field concerning the result";
        alert(mess);
        nb.value="";
        ok = 0;
      }
    // si oui, est-il valide (entier positif ou nul ou 0.1)
      else {
        if(((Math.floor(nb_v)!=nb_v) && (nb_v!=0.1))||(nb_v<=0))
        {
          var mess = french ? "j'attendais un nombre entier strictement positif ou 0.1 dans un champ concernant le résultat" : "I was expecting a strictly positive integer or 0.1 in a field concerning the result";
          alert(mess);
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
    var nbre = nbre.replace('+','');
    if ((nbre!="") && (parseFloat(nbre)!=nbre)) {
      var french =( $('[name="langage"]').val() !== "A")
      var mess = french ? "j'attendais un nombre dans ce champ" : "I was expecting a number in this field";
      alert(mess);
      erreur(nb);
    }
    else{
    nb.value = nbre;
     nb.style.backgroundColor = "#ffffff"; 
    }
  }
 // Contrôle des numéros d'échantillon du RAEMA Gel
 function ctrl_nbrg(nb) 
	{
    if ((nb.value!="") && (parseInt(nb.value)!=nb.value)) {
        var mess = "j'attendais un nombre entier dans ce champ";
        alert(mess);
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
      var french =( $('[name="hiddenField"]').val() === "F")
      var messfr = "J'attendais le n° du laboratoire : un nombre entier inférieur à 1000";
      var messen = "I was waiting for the number of the laboratory: an integer less than 1000";
      var mess = french ? messfr : messen;
      alert(mess);
      erreur(nb);
    }
    else{
     nb.style.backgroundColor = "#ffffff"; 
    }
  }
  
  
function ctrl_dateraema(madate,datedep)
	{
    var dat = madate.value;
    var ok = 1;
    var french =( $('[name="langage"]').val() === "F")
    if (dat!="") {
     
      if ((dat.length==8) || (dat.length==10)) {
        
        var jour = dat.substring(0,2);
        var mois = dat.substring(3,5);
        if(dat.length==8){
        var annee = '20'+dat.substring(6);}
        else {
        var annee = dat.substring(6);}
        
        var dt1=fabriquedatejs(dat); // date qui est notée
        /*
        var jourdep =datedep.substring(0,2);
        var moisdep = datedep.substring(3,5);
        var anneedep = datedep.substring(6);
        var dt2=new Date(anneedep, (moisdep-1), jourdep);// date de départ des colis
        */
		var dt2= fabriquedatejs(datedep)
        var now = new Date();
        now = now.getFullYear();
        var amax=now; // année maxi
        var amin=now; // année mini
        if ((jour<1) ||(jour>31)) {
          var mess = french ? "Le jour n'est pas correct." : "The day is not correct.";
          alert(mess);
          var ok = 0;
        }
        if ((mois<1) ||(mois>12) && (ok==1)) {
          //code
          var mess = french ? "Le mois n'est pas correct." : "The month is not correct.";
          alert(mess);
          var ok = 0;
        }
        if ( ((isNaN(annee))||(annee<amin)||(annee>amax)) && (ok==1) ) {
          var mess = french ? "L'année n'est pas correcte." : "The year is not correct.";
          alert(mess);
          var ok = 0;
        }
        if ((dat.indexOf("/") != 2 ) || (dat.lastIndexOf("/") != 5) &&  (ok == 1)){
          var mess = french ? "Vous n'avez pas mis les séparateurs aux bons endroits." : "You did not put the separators in the right places.";
          alert(mess);
          var ok = 0;
        }
        var an = annee;
        var dt = new Date(an,mois-1,jour);
        if ((dt.getMonth()!=mois-1) &&  (ok == 1)) {
          var mess = french ? "La date n'existe pas." : "The date does not exist.";
          alert(mess);
          var ok = 0;
        }
        var dt = new Date(annee,mois-1,jour);
        if ((dt.getMonth()!=mois-1) &&  (ok == 1)) {
          var mess = french ? "La date n'existe pas." : "The date does not exist.";
          alert(mess);
          var ok = 0;
        }
        // Cohérence par rapport à la date d'envoi des échantillons
        if (((dt1 - dt2) > (40*86400000)) &&  (ok == 1)) {
          var typedate = (madate.id="Champ0101") ?  'de réception du colis': 'de début des analyses' ;
          var mess = french ? "La date est trop éloignée de celle d'envoi des échantillons." : "The date is too far from the date of distribution of the samples.";
          alert(mess);
          var ok = 0;
        }
        
        if (((dt1 - dt2) < 0) &&  (ok == 1)) {
          var typedate = (madate.id="Champ0101") ?  'de réception du colis': 'de début des analyses' ;
          var mess = french ? "La date ne peut être avant celle d'envoi des échantillons." : "The date can not be before the date of distribution of the samples";
          alert(mess);
          var ok = 0;
        }
        
        var dateana = $('#Champ0103').val(); // Valeurs alpha des dates d'analyse
        var daterec = $('#Champ0101').val();// Valeurs alpha des dates de reception
        var jourrec =daterec.substring(0,2);
        var moisrec = daterec.substring(3,5);
        if(daterec.substring(6).length==2) {
        var anneerec = "20"+daterec.substring(6); }
        else {
        var anneerec = daterec.substring(6);}
        
        var dt3=fabriquedatejs(daterec); // date de réception
        var dt4=fabriquedatejs(dateana); // date de début des analyses
        // Cohérence entre date courante et date de réception
        if ((dt1-dt3 < 0) && (dateana !== "") && (ok == 1)) {
          var mess = french ? "La date ne peut être avant celle de réception du colis..." : "The date can not be before the receipt of the parcel ...";
          alert(mess);
          var ok = 0;
        }
        // Cohérence entre date de début des analyses et date de réception
        if ((dt4-dt3 < 0) && (dateana !== "") && (daterec !== "") && (ok == 1)) {
          var mess = french ? "La date de début des analyses ne peut être avant celle de réception du colis..." : "The start date of analyzes can not be before the receipt of the parcel ...";
          alert(mess);
          var ok = 0;
        }
      }
      else{
        var mess = french ? "Vous avez saisi " + dat + ". Cela ne correspond pas à une date formatée en jj/mm/aa." : "You have entered" + dat + "This does not correspond to a date formatted in dd / mm / yy.";
        alert(mess);
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
function fabriquedatejs(datealpha) {
  	var jour =datealpha.substring(0,2);
    var mois = datealpha.substring(3,5);
    var annee = datealpha.substring(6);
    if (annee.length == 2) {
    	annee="20"+annee
    	}
    vardatejs = new Date(annee, (mois-1), jour); /*date javascript */
    return vardatejs
	}	
	   
function Verif_mdp(motpasse) 
	{
    var mdp=motpasse.value

      // test du remplissage, de la longueur de motpasse (this)
    if ((mdp !== "") && (mdp.length !== 10) ){
      var french =( $('[name="hiddenField"]').val() === "F")
      var messfr = "Le mot de passe doit comporter 10 lettres alors que vous proposez '"+mdp+"' qui n'en comporte que "+mdp.length+". Merci de le rectifier";
      var messen = "The password must contain 10 letters when you propose '"+mdp+"' that it contains only " + mdp.length + ". Please correct it";
      var mess = french ? messfr : messen;
      alert(mess);
       erreur(motpasse);
       }
    else{
     motpasse.style.backgroundColor = "#ffffff"; 
    }
  }
  
  
 // erreur
  function erreur(champ){
    champ.style.backgroundColor = "#fba";
    champ.value="";
    setTimeout(function(){champ.focus()},0); 
  }
  
  
