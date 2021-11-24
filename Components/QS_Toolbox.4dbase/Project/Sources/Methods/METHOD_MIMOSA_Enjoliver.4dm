//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// MIMOSA_EnjoliverMethod ( "methode" ; { bidon } ) -> "methode enjolivée"

// d'après Vincent de Lachaux par Mimosa le 5 juillet 2017 à ChiangMai
// NOTE : créer une méthode de test vide comme bac à sable pour comparer les résultats et mettre son nom en ligne 60
// vous pouvez mettre le nom d'une méthode par défaut en ligne 32
// Il y a un garde-fou pour ne pas enjoliver cette méthode à cause des cas spéciaux §§ et racine carrée
// 1 paramétre = appel depuis une macro
// Aucun paramétre : méthode appelée en direct depuis la base
// Code à placer dans votre fichier de macro :

// <macro name="Enjoliver la méthode/9"in_menu="true"type_ahead="false"Version="2">
// <text><method>MIMOSA_EnjoliverMethod ("<method_path/>")</method></text>
// </macro>

C_TEXT:C284($0; $1)
C_BOOLEAN:C305($2)  // paramétre bidon servant à distinguer le mode d'appel : diret ou via macro

C_BOOLEAN:C305($ligneApresControleDeFin; $lignePrecedeeParUnCommentaire; $longCommentaire; $ligneVide; $finDeBloc; $debutDeBloc; $ligneSeparatriceDejaPresente; $ligneDeCommentaires)
C_BOOLEAN:C305($estUneMacro; $lignesScindees; $insererLigneBlancheAvant; $scinderLesTests; $langageUS; $ligneTiretsAuSeinDesAuCasOu; $premiereInstructionBloc)
C_BOOLEAN:C305($espacerAvantBloc; $espacerApresBloc; $espacerAvantCommentaire; $isolerLesCas; $regrouperLesFins; $insererLigneDeTirets; $espaceAvantRemarque; $finCodeNormal)
C_BOOLEAN:C305($obsolescenceActiverBouton; $elaguerAvantMethode; $elaguerApresMethode; $elaguerZonesBlanches; $ligneDeCas; $lignePrecedeeParTestCas)
C_LONGINT:C283($indice; $erreur; $i; $natureTirets; $n; $options; $LARGEUR_LIGNE_SEPARATRICE; $SEUIL_COMPACTAGE)
C_TEXT:C284($regex; $contenuLigne; $texteMethode; $regexMotif; $remplacement; $langage)
C_TIME:C306($heureDebut)

$langage:=Config_getLanguage
$LARGEUR_LIGNE_SEPARATRICE:=30  // à paramétrer selon vos désirs
$SEUIL_COMPACTAGE:=2  // nombre de lignes en dessous duquel on compacte les blocs Boucle et Si (mettre 1 ou 2)

If (Count parameters:C259=0)  // sans paramétre = initialisation du mode direct
	
	ARRAY TEXT:C222($lesMethodes; 0x0000)
	$cible:=Request:C163("Start of method name to 'Beautifier':"; "Default_method_name"; "Search")
	
	If (OK=1) & ($cible#"")
		
		$cible:=$cible+"@"
		METHOD GET NAMES:C1166($lesMethodes; $cible)
		$n:=Size of array:C274($lesMethodes)
		
		Case of 
			: ($n=0)
				ALERT:C41("No method found with "+$cible+"@ as start!")
				
			: ($n=1)
				
				If ($lesMethodes{1}=Current method name:C684)
					
					ALERT:C41("You can't Beautifier this method by itself!")
					
				Else 
					
					METHOD GET CODE:C1190($lesMethodes{1}; $texteMethode; *)  // depuis composant
					$texteMethode:=METHOD_MIMOSA_Enjoliver($texteMethode; False:C215)
					
					If (Macintosh option down:C545)
						// on modifie directement la méthode voulue
					Else 
						ARRAY TEXT:C222($lesMethodes; 0x0000)
						METHOD GET NAMES:C1166($lesMethodes; "__enjoliver")  // méthode test pour voir le résultat"
					End if 
					
					UPDT_WriteMethod($lesMethodes{1}; $texteMethode)
					METHOD OPEN PATH:C1213($lesMethodes{1})  // et on l'affiche
				End if 
				
			Else   // plusieurs méthodes à traiter
				
				$indice:=Find in array:C230($lesMethodes; Current method name:C684)
				
				If ($indice#No current record:K29:2)
					DELETE FROM ARRAY:C228($lesMethodes; $indice)  // on retire l'enjoliveur de la liste des méthodes à traiter
				End if 
				
				$indice:=Find in array:C230($lesMethodes; "REGEX_@")
				
				While ($indice#No current record:K29:2)
					DELETE FROM ARRAY:C228($lesMethodes; $indice)  // on doit aussi retirer les méthodes utilisées par l'enjoliveur
					$indice:=Find in array:C230($lesMethodes; "REGEX_@")
				End while 
				
				SORT ARRAY:C229($lesMethodes)
				$n:=Size of array:C274($lesMethodes)
				
				CONFIRM:C162("Before continuing, check that all methods are closed...\rBeautifier "+String:C10($n)+" methods ?"; "Beautifier")
				
				If (OK=1)
					$heureDebut:=Current time:C178
					
					For ($i; 1; $n)
						METHOD GET CODE:C1190($lesMethodes{$i}; $texteMethode; *)  // depuis composant
						$texteMethode:=METHOD_MIMOSA_Enjoliver($texteMethode; False:C215)
						UPDT_WriteMethod($lesMethodes{$i}; $texteMethode)
						
					End for 
					
					ALERT:C41(String:C10($n)+" methods treated in "+String:C10((Current time:C178-$heureDebut)\60)+" mn")
				End if 
		End case 
	End if 
	
Else 
	
	$estUneMacro:=(Count parameters:C259=1)  // si 2 paramétres, on vient du mode direct
	
	If ($estUneMacro)
		GET MACRO PARAMETER:C997(Full method text:K5:17; $texteMethode)
	Else 
		$texteMethode:=$1  // contenu de la méthode en mode direct
	End if 
	
	If (Length:C16($texteMethode)#0)
		
		$options:=0  // 32 options possibles sur les bits des 4 octets de l'entier long
		
		$options:=$options ?+ 0  // retire les lignes vides en début de méthode
		$options:=$options ?+ 1  // retire les lignes vides en fin de méthode
		$options:=$options ?+ 2  // ligne blanche avant les blocs
		$options:=$options ?+ 3  // ligne blanche après blocs
		$options:=$options ?- 4  // Insérer une ligne de séparatrice de tirets avant les branchements des Au Cas Ou
		$options:=$options ?+ 5  // compacter les micro-blocs ne comportant que peu de lignes d'instruction (seuil réglable)
		$options:=$options ?- 6  // une clé par ligne NON TRAITÉ
		$options:=$options ?- 7  // ajoute le pas d'incrément dans l'instruction boucle ($i;1;$n;pas)
		$options:=$options ?+ 8  // colle ensemble en fin de méthode les instructions de fin de bloc (fin de si, fin de cas, fin de boucle, fin tant que, jusque)
		$options:=$options ?+ 9  // escamote les lignes blanches excédentaires (max= 1 ligne blanche entre les blocs)
		$options:=$options ?+ 10  // une ligne de commentaire isolée doit être précédée par une ligne blanche
		$options:=$options ?- 11  // scinde les tests & ou | NON TRAITÉ
		$options:=$options ?- 12  // remplace les tests sur une chaîne vide par un test sur sa longueur nulle
		$options:=$options ?+ 13  // remplace les test "Si (test) var:=x Sinon var:=y Fin de si" par "var:=Choisir (test;x;y)" INACTIVÉ SI LANCÉ EN DEHORS D'UNE MACRO
		$options:=$options ?+ 14  // remplace les commandes obsoletes
		$options:=$options ?- 15  // remplace aussi les ACTIVER BOUTON et INACTIVER BOUTON
		$options:=$options ?- 16  // Dans les blocs 'Au cas ou', ajouter une ligne blanche après les branchements
		$options:=$options ?+ 17  //Remarque -> // remarque
		
		// pour la lisibilité du code en aval :
		
		$scinderLesTests:=False:C215  //($options ?? 11) car cassé
		$elaguerAvantMethode:=($options ?? 0)
		$elaguerApresMethode:=($options ?? 1)
		$espacerAvantBloc:=($options ?? 2)
		$espacerApresBloc:=($options ?? 3)
		$ligneTiretsAuSeinDesAuCasOu:=($options ?? 4)
		$CompacterMicroBlocs:=($options ?? 5)
		$regrouperLesFins:=($options ?? 8)
		$elaguerZonesBlanches:=($options ?? 9)
		$espacerAvantCommentaire:=($options ?? 10)
		$obsolescenceActiverBouton:=($options ?? 15)
		$isolerLesCas:=($options ?? 16)
		$espaceAvantRemarque:=($options ?? 17)
		
		$natureTirets:=0
		ARRAY TEXT:C222($ligneTirets; 0x0000)  // gadget pour offrir plusieurs types de tirets possibles
		
		APPEND TO ARRAY:C911($ligneTirets; "__")
		APPEND TO ARRAY:C911($ligneTirets; "--")
		APPEND TO ARRAY:C911($ligneTirets; "..")
		APPEND TO ARRAY:C911($ligneTirets; "…")
		APPEND TO ARRAY:C911($ligneTirets; "!!")
		APPEND TO ARRAY:C911($ligneTirets; "::")
		ARRAY LONGINT:C221($pileLIFOblocs; 0x0000)  // pile LIFO pour mémoriser l'imbrication des blocs dans la méthode
		ARRAY TEXT:C222($lesLignes; 0x0000)  // la méthode sera décomposée en lignes
		
		$langageUS:=($langage="en")  // 'Somme' en français, première commande historique de 4D
		ARRAY TEXT:C222($lesControles; 15)
		
		If ($langageUS)
			
			$lesControles{1}:="If"
			$lesControles{2}:="Else"
			$lesControles{3}:="End if"
			$lesControles{4}:="Case of"
			$lesControles{5}:="End case"
			$lesControles{6}:="While"
			$lesControles{7}:="End while"
			$lesControles{8}:="For each"
			$lesControles{9}:="End for each"
			$lesControles{10}:="For"
			$lesControles{11}:="End for"
			$lesControles{12}:="Repeat"
			$lesControles{13}:="Until"
			$lesControles{14}:="Use"
			$lesControles{15}:="End use"
			
		Else 
			
			$lesControles{1}:="Si"
			$lesControles{2}:="Sinon"
			$lesControles{3}:="Fin de si"
			$lesControles{4}:="Au cas ou"
			$lesControles{5}:="Fin de cas"
			$lesControles{6}:="Tant que"
			$lesControles{7}:="Fin tant que"
			$lesControles{8}:="Pour chaque"
			$lesControles{9}:="Fin de chaque"
			$lesControles{10}:="Boucle"
			$lesControles{11}:="Fin de boucle"
			$lesControles{12}:="Repeter"
			$lesControles{13}:="Jusque"
			$lesControles{14}:="Utiliser"
			$lesControles{15}:="Fin utiliser"
		End if 
		
		
		If ($options ?? 12)  // remplace les tests sur une chaîne nulle par un test sur sa longueur
			
			ARRAY TEXT:C222($tableau2D; 0; 0)
			
			$regexMotif:="(?mi-s)(\\(|;)([^)#=;]*)(#|=)\"\"\\)"  // (longueur(xxxx)=0) -> (xxx) (=)
			
			If (REGEX_ExtractText($regexMotif; $texteMethode; "0 1 2 3"; ->$tableau2D; 0)=0)
				
				For ($i; 1; Size of array:C274($tableau2D))
					$remplacement:=$tableau2D{$i}{2}+Command name:C538(16)+"("+$tableau2D{$i}{3}+")"+$tableau2D{$i}{4}+"0)"
					$texteMethode:=Replace string:C233($texteMethode; $tableau2D{$i}{1}; $remplacement)
				End for 
				
			End if 
		End if 
		
		//If ($options ?? 13) & $estUneMacro  // remplace les tests "Si (test) var:=x Sinon var:=y Fin de si" par "var:=Choisir(test;x;y) // commentaires "
		
		//  // NOTE : trop dangereux dans le cas d'un traitement global de méthode : vous devez VOIR le résultat obtenu pour le valider
		
		//$regexMotif:="(?im)"+Choose($langageUS;"If";"Si")+"\\s\\(([^\r]*\\)*)\\)(?://.*)*\\r\\s*(.*):=(?!.*\\$\\d)([^\r]*?)(//.*)*\\r\\s*"+Choose($langageUS;"Else";"Sinon")+".*\\s*\\2:=([^\r]*?)(//.*)*\\r\\s*"+Choose($langageUS;"End if";"Fin de si")																								
		//$remplacement:="\\2:="+Command name(955)+"(\\1;\\3;\\5) \\4 \\6"  // 4 et 6 sont les commentaires
		
		//$texteMethode:=Replace string($texteMethode;"\\";"§§")
		//$erreur:=REGEX_SubstituteText ($regexMotif;$remplacement;->$texteMethode;0)
		//$texteMethode:=Replace string($texteMethode;"§§";"\\")
		//End if 
		
		//If ($options ?? 14)  // Remplacement des commandes obsolétes
		
		
		If (False:C215)  // rien compris..., ne semble pas agir
			
			$regexMotif:="("+$lesControles{1}+" \\([^\\r]*\\r)\\r*"  // si
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			$regexMotif:="("+$lesControles{4}+"[^\\r]*\\r)\\r*"  // au cas ou
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			$regexMotif:="("+$lesControles{6}+" \\([^\\r]*\\r)\\r*"  // repeter
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			$regexMotif:="("+$lesControles{8}+" \\([^\\r]*\\r)\\r*"  // boucle
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			$regexMotif:="("+$lesControles{10}+"[^\\r]*\\r)\\r*"  // repéter
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			$regexMotif:="\\r*(\\r"+$lesControles{2}+"[^\\r]*\\r)\\r*"  // sinon
			$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			
			If ($regrouperLesFins)  // regroupement des contrôles de fin
				
				$regexMotif:="\\r*(\\r"+$lesControles{3}+"[^\\r]*\\r)\\r*"  // fin de si
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
				
				$regexMotif:="\\r*(\\r"+$lesControles{5}+"[^\\r]*\\r)\\r*"  // fin de cas
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
				
				$regexMotif:="\\r*(\\r"+$lesControles{7}+"[^\\r]*\\r)\\r*"  // jusque
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
				
				$regexMotif:="\\r*(\\r"+$lesControles{9}+"[^\\r]*\\r)\\r*"  // fin de boucle
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
				
				$regexMotif:="\\r*(\\r"+$lesControles{11}+" \\([^\\r]*\\r)\\r*"  // jusque
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
				
				$regexMotif:="\\r*(\\r: \\([^\\r]*\\r)\\r*"  // les cas
				$erreur:=REGEX_SubstituteText($regexMotif; "\\1"; ->$texteMethode)
			End if 
		End if 
		
		// DÉCOUPAGE DE LA MÉTHODE EN LIGNES 
		
		$premiereInstructionBloc:=False:C215
		$ligneApresControleDeFin:=False:C215
		$lignePrecedeeParUnCommentaire:=False:C215
		$ligneSeparatriceDejaPresente:=False:C215
		$longCommentaire:=False:C215
		$finCodeNormal:=False:C215
		
		If (REGEX_SplitText("\\r\\n|\\r|\\n"; $texteMethode; ->$lesLignes; 0 ?+ 11)=0)  // découpage de la méthode en ligne avec élimination des espaces et tab en début et fin
			
			$n:=Size of array:C274($lesLignes)  // NOTE : pourra augmenter au fil de l'analyse
			$i:=1
			
			Repeat 
				
				$contenuLigne:=$lesLignes{$i}
				
				$ligneVide:=(Length:C16($contenuLigne)=0)
				
				$insererLigneBlancheAvant:=False:C215
				$insererLigneDeTirets:=False:C215
				$ligneDeCas:=False:C215
				$lignePrecedeeParTestCas:=False:C215
				
				$pileLIFOblocs:=Size of array:C274($pileLIFOblocs)  // pointe le dernier élément de bloc ajouté à la pile LIFO
				$pileLIFOblocs{0}:=$pileLIFOblocs{$pileLIFOblocs}
				
				$ligneDeCommentaires:=(Position:C15("//"; $contenuLigne)=1)  // c'est une ligne de commentaire
				
				// teste s'il s'agit d'une instruction délimitant un bloc : (?<!//) sans les capturer : (?:
				
				$regexMotif:="(?<!//)(?:"+$lesControles{1}+"|"+$lesControles{4}+"|"+$lesControles{6}+"|"+$lesControles{8}+"|"+$lesControles{10}+"|"+$lesControles{2}+")\\b"
				$debutDeBloc:=(REGEX_MatchText($regexMotif; $contenuLigne)=0)  // teste si la ligne est un début de bloc (on inclue le 'Sinon' également dans ces cas)
				
				If ($debutDeBloc)
					
					$finDeBloc:=False:C215
					
				Else   // test pour voir si c'est une fin de bloc
					
					$regexMotif:="(?<!//)(?:"+$lesControles{3}+"|"+$lesControles{5}+"|"+$lesControles{7}+"|"+$lesControles{9}+"|"+$lesControles{11}+")\\b"
					$finDeBloc:=(REGEX_MatchText($regexMotif; $contenuLigne)=0)  // teste si la ligne est une fin de bloc
				End if 
				
				$insererLigneBlancheAvant:=(($espacerAvantBloc & $debutDeBloc) | ($espacerApresBloc & $finDeBloc))
				
				Case of 
						
					: ($ligneVide)
						
					: ($ligneDeCommentaires)
						
						$insererLigneBlancheAvant:=$espacerAvantCommentaire & Not:C34($lignePrecedeeParUnCommentaire)
						
						If ($ligneSeparatriceDejaPresente)
							
							$ligneSeparatriceDejaPresente:=False:C215  // on reset le flag à 0
							
						Else   // on regarde si on est en présence d'une ligne séparatrice
							
							$ligneSeparatriceDejaPresente:=(REGEX_MatchText("//(.)\\1{4,}"; $contenuLigne)=0)  // une ligne séparatrice comporte au moins 5 fois un caractère identique
							
							If (False:C215)
								If (Not:C34($lignePrecedeeParUnCommentaire))  //multilignes
									
									$insererLigneBlancheAvant:=Choose:C955($i>=2; ($options ?? 10); False:C215) & ($contenuLigne#("//}")) & ($contenuLigne#("//]")) & ($contenuLigne#("//)"))
								End if 
							End if 
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{1}+"\\b"; $contenuLigne)=0)  // 'Si' (hors d'un commentaire)
						
						If ($scinderLesTests)
							$erreur:=REGEX_SubstituteText("(\\) (&|\\|) \\()"; ")\\\r\\2("; ->$contenuLigne)
						End if 
						
						If (Replace string:C233($contenuLigne; Char:C90(Space:K15:42); "")=($lesControles{1}+"("+Command name:C538(215)+")@"))  // "Si (Faux) ..."
							APPEND TO ARRAY:C911($pileLIFOblocs; -1)  // Un faux 'Si' utilisé comme bloc de commentaires
						Else 
							APPEND TO ARRAY:C911($pileLIFOblocs; 1)  // c'est un vrai 'Si'
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{2}+"\\b"; $contenuLigne)=0)  // 'Sinon'(hors d'un commentaire)
						
						If ($pileLIFOblocs{$pileLIFOblocs}=4)  // c'est le 'Sinon' d'un 'Au cas ou'
							$insererLigneDeTirets:=$ligneTiretsAuSeinDesAuCasOu
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{3}+"\\b"; $contenuLigne)=0)  // 'Fin de si' (hors d'un commentaire)
						
						If (Abs:C99($pileLIFOblocs{$pileLIFOblocs})=1)
							DELETE FROM ARRAY:C228($pileLIFOblocs; $pileLIFOblocs)  // dépile le 'Si' courant ou le 'Si (Faux)'
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{4}+"\\b"; $contenuLigne)=0)  // 'Au cas ou' (hors d'un commentaire)
						
						$natureTirets:=$natureTirets+1
						APPEND TO ARRAY:C911($pileLIFOblocs; 4)  // empile le bloc
						
						// CAS DES BRANCHEMENTS DANS UN BLOC 'Au cas ou'
						
					: (Position:C15(": ("; $contenuLigne)=1)  // ': (' directive de branchement dans un 'Au cas ou'
						
						$insererLigneBlancheAvant:=$espacerAvantBloc
						$ligneDeCas:=True:C214
						
						If ($ligneSeparatriceDejaPresente)
							$ligneSeparatriceDejaPresente:=False:C215  // on reset le flag à 0
						Else 
							$insererLigneDeTirets:=$ligneTiretsAuSeinDesAuCasOu
						End if 
						
						If ($scinderLesTests)
							$erreur:=REGEX_SubstituteText("(\\) (&|\\|) \\()"; ")\\\r\\2("; ->$contenuLigne)
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{5}+"\\b"; $contenuLigne)=0)  // 'Fin de cas' (hors d'un commentaire)
						
						If ($pileLIFOblocs{$pileLIFOblocs}=4)
							DELETE FROM ARRAY:C228($pileLIFOblocs; $pileLIFOblocs)  // dépile le bloc
						End if 
						
						$pileLIFOblocs{0}:=-5  // reset du niveau de tirets
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{6}+"\\b"; $contenuLigne)=0)  // 'Tant que' (hors d'un commentaire)
						
						If ($scinderLesTests)
							$erreur:=REGEX_SubstituteText("(\\) (&|\\|) \\()"; ")\\\r\\2("; ->$contenuLigne)
						End if 
						
						APPEND TO ARRAY:C911($pileLIFOblocs; 6)  // empile le bloc
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{7}+"\\b"; $contenuLigne)=0)  // 'Fin tant que'
						
						If ($pileLIFOblocs{$pileLIFOblocs}=6)
							DELETE FROM ARRAY:C228($pileLIFOblocs; $pileLIFOblocs)  // dépile le bloc
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{8}+"\\b"; $contenuLigne)=0)  // 'Boucle'
						
						If ($options ?? 7)  // ajout du pas d'incrément dans les boucles
							
							$regexMotif:="\\(([^;]*;[^;]*;[^;]*)(.*?)?\\).*$"  // NOTE : ajout à la fin de .* pour tenir compte du cas où la ligne est commentée
							ARRAY TEXT:C222($lesResultats; 0x0000)
							
							If (REGEX_MatchText($regexMotif; $contenuLigne; ->$lesResultats)=0)
								
								If (Length:C16($lesResultats{2})=0)
									$contenuLigne:=Replace string:C233($contenuLigne; $lesResultats{1}; $lesResultats{1}+";1")  // pas de 1 ajouté
								End if 
							End if 
						End if 
						
						APPEND TO ARRAY:C911($pileLIFOblocs; 8)  // empile le bloc
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{9}+"\\b"; $contenuLigne)=0)  // 'Fin de boucle'
						
						If ($pileLIFOblocs{$pileLIFOblocs}=8)
							DELETE FROM ARRAY:C228($pileLIFOblocs; $pileLIFOblocs)  // dépile le bloc
						End if 
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{10}+"\\b"; $contenuLigne)=0)  // 'Répéter'
						
						APPEND TO ARRAY:C911($pileLIFOblocs; 10)  // empile le bloc
						
					: (REGEX_MatchText("(?<!//)"+$lesControles{11}+"\\b"; $contenuLigne)=0)  // 'Jusque'
						
						If ($scinderLesTests)
							$erreur:=REGEX_SubstituteText("(\\) (&|\\|) \\()"; ")\\\r\\2("; ->$contenuLigne)
						End if 
						
						If ($pileLIFOblocs{$pileLIFOblocs}=10)
							DELETE FROM ARRAY:C228($pileLIFOblocs; $pileLIFOblocs)  // dépile le bloc
						End if 
						
					: (Position:C15(Command name:C538(948); $contenuLigne)=1)  // début SQL
						$insererLigneBlancheAvant:=$espacerAvantBloc
						
					: (Position:C15(Command name:C538(949); $contenuLigne)=1)  // fin SQL
						$insererLigneBlancheAvant:=$espacerApresBloc
						
					Else   // toutes les autres lignes d'instruction
						
						$insererLigneBlancheAvant:=($longCommentaire | ($espacerApresBloc & $ligneApresControleDeFin) | ($espacerAvantBloc & $premiereInstructionBloc) | ($isolerLesCas & $lignePrecedeeParTestCas))
						$longCommentaire:=False:C215
				End case 
				
				If ($ligneVide)
					
				Else 
					
					If (True:C214)  // pour accoler TOUTES les fins, il suffit de valider le code suivant
						
						If ($regrouperLesFins & $finDeBloc & $ligneApresControleDeFin & $insererLigneBlancheAvant)
							$insererLigneBlancheAvant:=False:C215  //regroupement des lignes de fin de bloc qui se suivent (en fin de méthode notamment)
						End if 
						
					Else   // on garde un blanc après la dernière ligne de code normal dans cette option (invalidée ici)
						
						If ($regrouperLesFins & $finDeBloc)
							If ($ligneApresControleDeFin)
								
								If ($finCodeNormal)  // gère une exception : on conserve la ligne blanche après la dernière instruction de fin suivant du code normal
									
									$finCodeNormal:=False:C215
									
								Else   // puis on colle toutes les fin de bloc ensemble
									
									If ($insererLigneBlancheAvant)
										$insererLigneBlancheAvant:=False:C215  //regroupement des lignes de fin de bloc qui se suivent (en fin de méthode notamment)
									End if 
								End if 
								
							Else 
								$finCodeNormal:=True:C214  // indique qu'il s'agit de la PREMIÈRE fin d'un bloc de code comportant des instructions
							End if 
						End if 
					End if 
					
					$ligneApresControleDeFin:=$finDeBloc  // sera utilisé plus tard lors du traitement de la ligne suivante
					$premiereInstructionBloc:=$debutDeBloc  // idem
					
					If ($ligneDeCommentaires)
						$longCommentaire:=$lignePrecedeeParUnCommentaire
					End if 
					
					$lignePrecedeeParUnCommentaire:=$ligneDeCommentaires  // idem
					$lignePrecedeeParTestCas:=$ligneDeCas
					
					If (Not:C34($lignesScindees))
						
						If ($insererLigneDeTirets & Not:C34($ligneSeparatriceDejaPresente))
							
							// on s'assure de tomber dans une valeur possible de tirets (ben oui, il peuvent changer de forme !!)
							
							$natureTirets:=Choose:C955($natureTirets>Size of array:C274($ligneTirets); Size of array:C274($ligneTirets); $natureTirets)
							$natureTirets:=Choose:C955($natureTirets<=0; 1; $natureTirets)
							
							INSERT IN ARRAY:C227($lesLignes; $i+1)  // on décale la ligne prévue dans la méthode
							$lesLignes{$i+1}:=$contenuLigne
							
							$contenuLigne:="//"+($ligneTirets{$natureTirets}*$LARGEUR_LIGNE_SEPARATRICE)  // la ligne courante est assignée à une ligne de tirets
							
							If ($pileLIFOblocs{0}=-5)  // convention pour changer le type de tirets
								$natureTirets:=$natureTirets-1
							End if 
							
							$ligneSeparatriceDejaPresente:=True:C214
						End if 
					End if 
				End if 
				
				Case of 
					: (Not:C34($insererLigneBlancheAvant))
					: ($i=1)  // ligne invisible spécifique à 4D
					: ($ligneVide)
					: ($ligneSeparatriceDejaPresente)
					: (Not:C34($espacerAvantBloc))
						
					Else 
						$contenuLigne:="\r"+$contenuLigne  // insertion d'une ligne blanche avant la ligne courante
				End case 
				
				If (False:C215)
					$lignesScindees:=($contenuLigne="@\\")  // la présence d'un \ dans la ligne implique qu'elle est scindée
					
					$regex:="(?mi-s)^[^/]*{command}\\(.*\\)(?:\\s*//[^$]*)?$"
					
					Case of 
						: ($lignesScindees) | (Not:C34($options ?? 6))  // une clé par ligne
							
						: (REGEX_MatchText(Replace string:C233($regex; "{command}"; Command name:C538(1220)); $contenuLigne)=0)  // OB SET
							
							//$ligneMethode:=beautifier_Split_key_value($ligneMethode;1220)
							
						: (REGEX_MatchText(Replace string:C233($regex; "{command}"; Command name:C538(1055)); $contenuLigne)=0)  // SVG SET ATTRIBUTE
							
							//$ligneMethode:=beautifier_Split_key_value($ligneMethode;1055)
							
						: (REGEX_MatchText(Replace string:C233($regex; "{command}"; Command name:C538(865)); $contenuLigne)=0)  // DOM Create XML element
							
							//$ligneMethode:=beautifier_Split_key_value($ligneMethode;865)
							
						: (REGEX_MatchText(Replace string:C233($regex; "{command}"; Command name:C538(866)); $contenuLigne)=0)  // DOM SET XML ATTRIBUTE
							
							//$ligneMethode:=beautifier_Split_key_value($ligneMethode;866)
							
						: (REGEX_MatchText(Replace string:C233($regex; "{command}"; Command name:C538(1093)); $contenuLigne)=0)  // ST SET ATTRIBUTES 
							
							//$ligneMethode:=beautifier_Split_key_value($ligneMethode;1093)
					End case 
				End if 
				
				If ($regrouperLesFins & $ligneVide & $ligneApresControleDeFin)
					DELETE FROM ARRAY:C228($lesLignes; $i)  // on supprime de force les lignes vides dans les controles de fin accumulés
					$n:=$n-1
				Else 
					$lesLignes{$i}:=$contenuLigne
					$i:=$i+1  // passer à la ligne suivante
				End if 
				
			Until ($i>$n)
		End if 
		
		
		$n:=Size of array:C274($lesLignes)
		$texteMethode:=""
		
		For ($i; 1; $n)
			$texteMethode:=$texteMethode+$lesLignes{$i}+"\r"  // première version de la méthode enjolivée
		End for 
		
		// NOTE : le dernier retour-ligne à la fin de la méthode sert de 'sentinelle' pour éviter les débordements en fin de tableau
		
		// RE-BOUCLAGE SUR TOUTES LES LIGNES
		
		If (REGEX_SplitText("\\r\\n|\\r|\\n"; $texteMethode; ->$lesLignes; 0 ?+ 11)=0)  // découpage de la méthode en ligne avec élimination des espaces et tab en début et fin
			
			// NOTE : ici aucune ligne ne débute par un retour chariot 
			
			$texteMethode:=""
			$debutBoucle:=No current record:K29:2
			$lignesCodes:=0
			$debutSi:=No current record:K29:2
			$lignesCodesAvantSinon:=0
			$lignesCodesApresSinon:=0
			
			$n:=Size of array:C274($lesLignes)
			$i:=2  // NOTE : la ligne 1 est réservée à 4D
			
			Repeat 
				
				$contenuLigne:=$lesLignes{$i}
				
				// AJOUT D'UN ESPACE JUSTE APRÈS L'OUVERTURE D'UN COMMENTAIRE
				
				If ($espaceAvantRemarque)  // traitement des remarques
					
					$contenuLigne:=Replace string:C233($contenuLigne; "$"; "√")
					
					ARRAY TEXT:C222($lesResultats; 0x0000)
					$regexMotif:="(?mi-s)^(.*//)\\s*([^$]*)$"
					
					If (REGEX_MatchText($regexMotif; $contenuLigne; ->$lesResultats)=0)
						
						Case of 
							: (Length:C16($lesResultats{2})=0)  // on a un commentaire vide !!
								
								If ($lesResultats{1}="//")
									// c'est fait délibérément, on le laisse
								Else 
									$contenuLigne:=Replace string:C233($contenuLigne; "//"; "")  // on le supprime
								End if 
								
							: (Position:C15("://"; $contenuLigne)>0)  // sans doute une chaîne "http://", ne pas remplacer
								
							: (Length:C16($lesResultats{2})=1)  // une seule lettre en commentaire
								
								$contenuLigne:=$lesResultats{1}+Char:C90(Space:K15:42)+$lesResultats{2}
								
							Else   // au moins deux caractères dans le commentaire
								
								If (Character code:C91(Lowercase:C14($lesResultats{2}[[2]]; *))=Character code:C91($lesResultats{2}[[2]]))  // seconde lettre en minuscules
									$lesResultats{2}[[1]]:=Lowercase:C14($lesResultats{2}[[1]]; *)  // on peut passer la première lettre en minuscules
								End if 
								
								$contenuLigne:=$lesResultats{1}+Char:C90(Space:K15:42)+$lesResultats{2}
						End case 
					End if 
					
					$contenuLigne:=Replace string:C233($contenuLigne; "√"; "$")
				End if 
				
				// COMPACTAGE DES Si..Fin de si et des Boucle..Fin de boucle SI LIMITÉS À UNE OU DEUX INSTRUCTION (seuil paramétrable)
				C_LONGINT:C283($p; $debutSi; $sinon; $finSi; $debutBoucle; $finBoucle; $lignesCodes; $lignesCodesAvantSinon; $lignesCodesApresSinon)
				C_BOOLEAN:C305($compacter)
				
				If ($CompacterMicroBlocs)
					
					Case of 
						: (Length:C16($contenuLigne)=0)  // ligne vide, pas d'analyse à faire
							
						: (Position:C15("//"; $contenuLigne)=1)  // ligne de commentaire, idem
							
						: (REGEX_MatchText("(?<!//)"+$lesControles{1}+"\\b"; $contenuLigne)=0)  // 'Si' 
							
							$debutSi:=$i  // mémorise la ligne du 'Si'
							
							// reset des compteurs :
							$lignesCodesAvantSinon:=0
							$lignesCodesApresSinon:=0
							$finBoucle:=No current record:K29:2
							$sinon:=No current record:K29:2
							
						: (REGEX_MatchText("(?<!//)"+$lesControles{8}+"\\b"; $contenuLigne)=0)  // 'Boucle'
							
							$debutBoucle:=$i
							$lignesCodes:=0
							
						: (REGEX_MatchText("(?<!//)"+$lesControles{9}+"\\b"; $contenuLigne)=0)  // 'Fin de boucle'
							
							Case of 
								: ($debutBoucle=No current record:K29:2)  // pas de bloc 'Boucle' en cours d'analyse
									
								: ($lignesCodes=0)  // aucune ligne, on laisse tel quel
									
								: ($lignesCodes>$SEUIL_COMPACTAGE)  // trop de lignes dans le bloc, on ne compacte pas
									
								Else   // tout est OK, peu de lignes de code, on peut supprimer les lignes blanches au dessus et au dessous
									
									// compactage du micro-bloc 'Boucle' :
									
									$finBoucle:=$i
									$p:=$debutBoucle+1  // à partir de la ligne suivant l'instruction 'Boucle'
									
									Repeat   // si la ligne est vide, on la supprime, sinon on la saute (instruction)
										
										If (Length:C16($lesLignes{$p})=0)
											DELETE FROM ARRAY:C228($lesLignes; $p)
											$finBoucle:=$finBoucle-1
										Else 
											$p:=$p+1
											$i:=$p
										End if 
										
									Until ($p>=$finBoucle)  // jusqu'à atteindre la fin du bloc
									
									// on imposte une ligne blanche après le 'Fin de boucle' de ce micro-bloc :
									
									$i:=$finBoucle+1
									$contenuLigne:=""
									
									If (Length:C16($lesLignes{$i})=0)
										// c'est déjà le cas, rien à faire
									Else 
										INSERT IN ARRAY:C227($lesLignes; $i)
									End if 
									
									$n:=Size of array:C274($lesLignes)  // nouvelle longueur de la méthode
									$debutBoucle:=No current record:K29:2  // indique que le bloc a été traité
							End case 
							
							
						: (REGEX_MatchText("(?<!//)"+$lesControles{2}+"\\b"; $contenuLigne)=0)  // 'Sinon'
							$sinon:=$i
							
						: (REGEX_MatchText("(?<!//)"+$lesControles{3}+"\\b"; $contenuLigne)=0)  // 'Fin de si'
							
							Case of 
								: ($debutSi=No current record:K29:2)  // pas de bloc en cours d'analyse
									$compacter:=False:C215
									
								: (($sinon<=0) & ($lignesCodesAvantSinon<=$SEUIL_COMPACTAGE))  // pas de 'Sinon' et une seule ligne d'instruction, OK pour compacter
									$compacter:=True:C214
									
								: ($sinon>0) & ($lignesCodesAvantSinon<=$SEUIL_COMPACTAGE) & ($lignesCodesApresSinon<=$SEUIL_COMPACTAGE)  // 'Sinon' présent, micro-bloc ?
									$compacter:=True:C214  // peu de lignes, on peut compacter
									
								Else 
									$compacter:=False:C215  // garde-fou
							End case 
							
							If ($compacter)  // compactage du micro bloc 'Si' :
								
								$finSi:=$i
								$p:=$debutSi+1  // à partir de la ligne suivant le 'Si'
								
								Repeat   // si la ligne est vide, on la supprime, sinon on la saute (instruction)
									
									If (Length:C16($lesLignes{$p})=0)
										DELETE FROM ARRAY:C228($lesLignes; $p)
										$finSi:=$finSi-1
									Else 
										$p:=$p+1
										$i:=$p
									End if 
									
								Until ($p>=$finSi)  // jusqu'à atteindre la fin du bloc
								
								// on impose une ligne blanche après le 'Fin de si' de ce micro bloc :
								
								$i:=$finSi+1
								$contenuLigne:=""
								
								If (Length:C16($lesLignes{$i})=0)
									// c'est déjà le cas, rien à faire
								Else 
									INSERT IN ARRAY:C227($lesLignes; $i)
								End if 
								
								$n:=Size of array:C274($lesLignes)  // nouvelle longueur de la méthode
								$debutSi:=No current record:K29:2  // indique que le bloc a été traité
							End if 
							
							
						Else   // la ligne courante est une ligne d'instruction
							
							$lignesCodes:=$lignesCodes+1  // compte le nombre de lignes de codes au sein de ce bloc
							
							If ($sinon=No current record:K29:2)
								$lignesCodesAvantSinon:=$lignesCodesAvantSinon+1  // nombre d'instructions avant le 'Sinon'
							Else 
								$lignesCodesApresSinon:=$lignesCodesApresSinon+1  // et après le 'Sinon'
							End if 
							
					End case 
				End if 
				
				$lesLignes{$i}:=$contenuLigne
				$i:=$i+1
			Until ($i>$n)
			
		End if 
		
		$n:=Size of array:C274($lesLignes)
		$texteMethode:=""
		
		For ($i; 1; $n)
			$texteMethode:=$texteMethode+$lesLignes{$i}+"\r"  // seconde version de la méthode enjolivée
		End for 
		
		// DERNIERS DÉTAILS
		
		If ($elaguerAvantMethode)
			$erreur:=REGEX_SubstituteText("^(\\r*)"; ""; ->$texteMethode)  // retire les lignes vides en début de méthode
		End if 
		
		If ($elaguerApresMethode)
			$erreur:=REGEX_SubstituteText("(\\r*)$"; ""; ->$texteMethode)  // retire les lignes vides en fin de méthode
		End if 
		
		If ($elaguerZonesBlanches)  // élimination des lignes blanches excédentaires
			$erreur:=REGEX_SubstituteText("[\\r\\n]{2,}"; "\r\r"; ->$texteMethode)
		End if 
		
		$regexMotif:="(?mi-s)\\r\\r.*(//%W\\+\\d{1,}\\.\\d{1,})\\r"
		$erreur:=REGEX_SubstituteText($regexMotif; "\r\\1\r"; ->$texteMethode)  // retire le retour ligne si nécessaire avant la fermeture d'une directive de compilation
		
		$texteMethode:=$texteMethode+"\r"
	End if 
	
	If ($estUneMacro)
		SET MACRO PARAMETER:C998(Full method text:K5:17; $texteMethode+"<caret/>")
	End if 
	
End if 

$0:=$texteMethode  // retourne la méthode enjolivée