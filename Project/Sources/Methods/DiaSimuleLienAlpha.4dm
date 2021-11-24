//%attributes = {"publishedWeb":true}
  //  ZSimuleLienAlpha 6.0 du 19/8/98
  // $1=Pt champ ref  doit être indexé unique
  //  $2=Pt champ (ou Var) de saisie
  // $3: si  vrai création automatique de la fiche
  // si $4 ="" et $3 faux pas de création directe
  // sinon présentation d'un formulaire $4 à l'écran
  // {$5} = pointeur sur champ affiché si différent de $1
  //  {$6} = pointeur sur champ renvoyé si différent de $1

C_TEXT:C284($ChaineTestée)
C_TEXT:C284($4)
C_LONGINT:C283($NumTable)
ARRAY TEXT:C222(ZTab;0)

$NumTable:=Table:C252($1)
$PtTabRef:=Table:C252($NumTable)
$ChaineTestée:=$2->
If ($ChaineTestée#"")  //  le réceptacle n'est pas vide
	  // remettons à vide le champ ou la variable
	If (Is a variable:C294($2))
		$2->:=""
	Else 
		$2->:=Old:C35($2->)
	End if 
	QUERY:C277($PtTabRef->;$1->=$ChaineTestée+"@")
	Case of 
		: (Records in selection:C76($PtTabRef->)=0)
			If ($4="") & (Not:C34($3))
				ALERT:C41("Désolé, aucun enregistrement de "+Table name:C256($PtTabRef)+" n'a été trouvé...")
				GOTO OBJECT:C206($2->)
			Else   // stockons les droits courants
				$aj:=ZAjout
				$ac:=ZAccès
				$mod:=ZModif
				$sup:=ZSupprime
				$imp:=ZImprimer
				$Val:=Zvalide
				  // ZMAJPrivilèges ($PtTabRef)
				If (ZAjout)  // a t'on le droit d'ajouter un enregistrement référence ?
					CONFIRM:C162("CREER l'enregistrement de "+$ChaineTestée+"…?";"D'accord";"Ah, non!")
					If (OK=1)
						If ($3=True:C214)
							CREATE RECORD:C68($PtTabRef->)
							$2->:=$ChaineTestée
							SAVE RECORD:C53($PtTabRef->)
						Else 
							FORM SET INPUT:C55($PtTabRef->;$4)
							ZVarNomChoisi:=$ChaineTestée
							  //  suppose donc qu'au chargement du format $4 on initialise cette variable
							ADD RECORD:C56($PtTabRef->;*)
						End if 
					Else 
						GOTO OBJECT:C206($2->)
					End if 
				Else 
					$Mess:="Désolé, aucun enregistrement de "+Table name:C256($PtTabRef)+" ne commence par "+$ChaineTestée
					ALERT:C41($Mess)
					GOTO OBJECT:C206($2->)
				End if 
				
				
				ZAjout:=$aj  // restitution des droits
				ZAccès:=$ac
				ZModif:=$mod
				ZSupprime:=$sup
				ZImprimer:=$imp
				Zvalide:=$Val
				
			End if 
			
		: (Records in selection:C76($PtTabRef->)=1)
			$2->:=$1->
			$ChaineTestée:=$1->
			
		Else 
			MESSAGES OFF:C175
			If (Count parameters:C259>4)
				DISTINCT VALUES:C339($5->;ZTab)
			Else 
				ORDER BY:C49($PtTabRef->;$1->;>)
				SELECTION TO ARRAY:C260($1->;ZTab)
			End if 
			If (Size of array:C274(ZTab)=1)
				If (Count parameters:C259=6)  //  la valeur retournée n'est pas celle choisie
					GOTO SELECTED RECORD:C245($PtTabRef->;ZTab)
					$2->:=$6->
				Else 
					$2->:=ZTab{1}
				End if 
			Else 
				
				ZFenetreModaleAuCentre (450;250)
				DIALOG:C40([XData:1];"DlgTbProd")
				CLOSE WINDOW:C154
				If (ZBouAnnule=1)
					GOTO OBJECT:C206($2->)
				Else 
					GOTO SELECTED RECORD:C245($PtTabRef->;ZTab)
					$ChaineTestée:=$1->
					If (Count parameters:C259=6)  //  la valeur retournée n'est pas celle choisie
						$2->:=$6->
					Else 
						$2->:=ZTab{ZTab}
					End if 
				End if 
			End if 
			MESSAGES ON:C181
	End case 
	QUERY:C277($PtTabRef->;$1->=$ChaineTestée)
End if 