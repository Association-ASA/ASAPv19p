//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/03/16, 13:37:26
  // ----------------------------------------------------
  // Méthode : WebEcritListelesions              
  // Description
  // Fonction qui écrit le critère de lésion dans la diagnose
  //  Liste DGAL pour la France et Liste ENV les estrangers
  // Paramètres : $1=langue  {$2) existe restreint le tableau affiché à $2->
  // ----------------------------------------------------

$Langue:=$1
C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbNLLC;0)
If ($Langue#"F")
	$PtTbRef:=Get pointer:C304("<>TbNL"+$Langue)
	COPY ARRAY:C226($PtTbRef->;$TbNLLC)
Else 
	If (Count parameters:C259=2)
		C_POINTER:C301($2)
		COPY ARRAY:C226($2->;$TbNLLC)
	Else 
		COPY ARRAY:C226(<>TbMotifLibelleMotifSaisieDGAL;$TbNLLC)
	End if 
End if 

SORT ARRAY:C229($TbNLLC;>)
$THTML:=""
$FT:=Size of array:C274($TbNLLC)
For ($Salé;1;$FT)
	If ($TbNLLC{$Salé}#"")
		$THTML:=$THTML+"            <option class="+<>ZGuil+"changerequete"+<>ZGuil+">"+$TbNLLC{$Salé}+"</option>"+<>ZCR
	End if 
End for 
$0:=$THTML


If (False:C215)
	$THTML:="            <option>Abcès non spécifique à localisation unique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Abcès non spécifiques à localisations multiples</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Abcès omphalophlébitiques</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Abcès par corps étranger</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Abcès pyléphlébitiques</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Abcès pyohémiques</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Actinobacillose/Actinomycose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : moisissures</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : putréfaction profonde (puanteur d'os)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : putréfaction superficielle (limon)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : souillures autres que liées au contenu digestif</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : tiquetage musculaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : tiquetage pulmonaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies : tiquetage rénal </option>"+<>ZCR
	$THTML:=$THTML+"            <option>Altérations et anomalies souillures d'origine digestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Amyotrophie localisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Arthrite unique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Arthrites multiples</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Broncho-pneumonie fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Broncho-pneumonie fibrinocongestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Broncho-pneumonie gangreneuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Broncho-pneumonie mucopurulente</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Brucellose aiguë (Lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cachexie</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Calcinose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Charbon (lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Congestion diffuse de l’intestin </option>"+<>ZCR
	$THTML:=$THTML+"            <option>Congestion généralisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Congestion généralisée avec hémorragies multiples</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Congestion passive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale : anthracose pulmonaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale : céroïdose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale : mélanose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale : ochronose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Couleur anormale : ostéohémochromatose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cysticercose hépatopéritonéale</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cysticercose musculaire généralisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cysticercose musculaire localisée : forme dégénérée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cysticercose musculaire localisée : forme vivante</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Cytostéatonécrose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Dermite non parasitaire (ou lésions de )</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Distomatose avec observation de douves à l’ouverture des canaux biliaires (Lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Distomatose sans observation de douves à l’ouverture des canaux biliaires (Lésions de) </option>"+<>ZCR
	$THTML:=$THTML+"            <option>Echinococcose (Lésions d')</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Emphysème pulmonaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Endocardite fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Endocardite fibrineuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Entérite congestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Entérite fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Entérite hypertrophiante</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Escarres et autres plaies cutanées</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Gale (lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Gangrène</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hémarthrose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hépatite insulaire nécrosante</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hépatite interstitielle fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hépatite toxi-infectieuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hydronéphrose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Hypodermose (ou lésion d')</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Ictère</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Infiltration hémorragique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Infiltration hémorragique liée à une fracture</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Infiltration séreuse du tissu conjonctif</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Kyste</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Lymphadénite caséeuse des petits ruminants</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Lymphadénite généralisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Mammite</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Métrite</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Morve (lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Myosite éosinophilique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Myosite localisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Myosite oedémateuse des jeunes bovins</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Néphrite glomérulo-épithéliale</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Néphrite interstitielle fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Néphrite maculeuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Néphrite thrombo-embolique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Odeur anormale</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Odeur sexuelle prononcée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Oedème</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Ostéodystrophie</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Ostéomyélite</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péricardite congestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péricardite fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péricardite fibrineuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péricardite gangreneuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péricardite purulente</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péritonite congestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péritonite fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péritonite fibrineuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péritonite gangreneuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Péritonite purulente</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Phlegmon</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pleurésie congestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pleurésie fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pleurésie fibrineuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pleurésie purulente</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pneumonie congestive</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pneumonie fibreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Processus tumoral généralisé</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Processus tumoral généralisé : lymphosarcome</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Processus tumoral généralisé : mélanosarcome</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Processus tumoral localisé</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Pyélonéphrite</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Réticulopéritonite stabilisée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Rouget (Lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Sarcosporidiose (Lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Schwannome</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Sclérose hépatique</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Sclérose musculaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Sclérose musculaire iatrogène</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Stéatose</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Stomatite</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Strongylose (Lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Teigne (ou lésions de)</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Télangiectasie maculeuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Tuberculose généralisée (Lésion fortement évocatrice de )</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Tuberculose localisée (Lésion fortement évocatrice de )</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viande à évolution anormale : myopathie exsudative dépigmentaire</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viande à évolution anormale : viande fiévreuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viande à évolution anormale : viande surmenée</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viande immature</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viande saigneuse</option>"+<>ZCR
	$THTML:=$THTML+"            <option>Viandes résultant du parage de la plaie de saignée</option>"+<>ZCR
End if 
