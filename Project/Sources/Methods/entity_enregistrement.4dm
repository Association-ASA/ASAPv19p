//%attributes = {}
// ----------------------------------------------------
// Méthode : ORDA_UpdateFicheSelonDataForm
// ----------------------------------------------------
// Paramètres
// $1 = DataClass (nom de table) dans lequel on met à jour un enregistrement
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 08/07/18, 12:46:52
// Description
//  

C_OBJECT:C1216($Data; $statusLock; $status; $statusUnLock)
C_BOOLEAN:C305($flSavedOK; $flMustMerge; $flJustShow)
C_TEXT:C284($1; $DataClass; $PKiD)

$DataClass:=$1
$status:=Form:C1466.overview.save(dk auto merge:K85:24)  // Sauvegarde l'entité même si des modifs ont été réalisées, tant que pas sur le même champ

// #TODO 
// Gestion du conflit d'enregistrement ici

$flSavedOK:=False:C215
$flJustShow:=False:C215
$flMustMerge:=False:C215

Case of 
		//: ($status.success & $status.autoMerged)  //Saved & automerged
		//$flSavedOK:=True
		//$flJustShow:=True
		
	: ($status.success)  //Saved normally
		$flSavedOK:=True:C214
		
	: ($status.status=dk status automerge failed:K85:25)  //Automerge failed,
		$flMustMerge:=True:C214
		
	: ($status.status=dk status locked:K85:21)
		ALERT:C41("This Record is presently in use, please retry later!")
		$flSavedOK:=False:C215
		
	: ($status.status=dk status stamp has changed:K85:20)  //Means that the record has been modified
		$flMustMerge:=True:C214
		
	: ($status.status=dk status wrong permission:K85:19)
		//Nothing to do :-( You don't have the right to save it, period!
		
		//: ($status.status=dk status entity does not exist anymore)
		//$entity2Save:=$formData.zeDataClass.new()  // This case cannot happen with a new entity
		//For each ($attribute;$entity)  //We cannot use .clone(), for the copy will be too perfect ;-)
		//$entity2Save[$attribute]:=$entity[$attribute]
		//End for each 
		//$entity2Save.save()
		
		//: ($status.status=dk status serious error)
		//  //Here 4D has already displayed an error message.
		//  //You can trap it through an ON ERR CALL which must be BEFORE the .save()
		
	: ($status.status=dk status success:K85:18)
		//This has already been handled by the .save()
		
	Else 
		//Handle other possible errors
End case 

//$flReconcile:=$flMustMerge | $flJustShow
//If ($flReconcile)
//$flGoOn:=True
//$dialogData:=New object
//$entityOnDisk:=$formData.zeDataClass.get($entity.getKey())

//Case of 
//: ($flMustMerge)
//$lockStatus:=$entityOnDisk.lock()  //This will be a pessimistic locking. It's done just to simplfy the reconciliation. 
//  //It is also possible to do it without the .lock(), and retry as many times as necessary.

//$flNoWay:=Not($lockStatus.success)  // Lock has not been successful
//  //So we will tell the user to retry later
//If ($flNoWay)
//ALERT("This Record is presently in use, please retry later!")
//$flSavedOK:=False
//$flGoOn:=False
//Else 
//$entityEdited:=$entity.clone()
//$text:="Please merge the 2 records"
//$dialogData.entityEdited:=$entityEdited

//End if 

//: ($flJustShow)
//$text:="Your record has been merged with the disk record, this is the final result"
//$dialogData.entityEdited:=$entity

//End case 
//If ($flGoOn)
//$colTouched:=$entity.touchedAttributes()
//$colDiffs:=$entity.diff($entityOnDisk;$colTouched)  //List of different fields
//$dialogData.differences:=$colDiffs
//$dialogData.entityOnDisk:=$entityOnDisk
//$dialogData.fl_Merge:=$flMustMerge
//$dialogData.title:=$text

//$w:=Open form window("Reconcile_Entities";Movable form dialog box;Horizontally centered;Vertically centered;*)
//DIALOG("Reconcile_Entities";$dialogData)
//CLOSE WINDOW($w)

//If (OK=1)
//If ($flMustMerge)
//For ($i;0;$dialogData.reconcile.length-1)
//If ($dialogData.differences.query("attributeName = :1";$dialogData.reconcile[$i].name).length>0)
//$entityOnDisk[$dialogData.reconcile[$i].name]:=$dialogData.reconcile[$i].valFinal
//End if 
//End for 
//$status:=$entityOnDisk.save()  //dk auto merge is useless, for the entity is already locked.
//$flSavedOK:=$status.success
//If ($flSavedOK)
//$status:=$entityOnDisk.unlock()
//$flSavedOK:=$status.success
//End if 
//Else 
//$flSavedOK:=True
//End if 
//Else 
//$flSavedOK:=$flJustShow
//End if 
//End if 
//End if 
//If ($flSavedOK)
//If (Not($formData.zeSelection.contains($entity)))
//$formData.zeSelection.add($entity)
//End if 
//ALERT("Entity saved successfully!")
//End if 

//  //$status:=$entity.reload()
//  //If ($status.success)
//  //For each ($attribute;$entity)  //Reloaded, then new stamp, we will copy the values
//  //$entity[$attribute]:=$entityEdited[$attribute]
//  //End for each 
//  //$sel:=Gen_SaveEntity ("SAVE";$formData;$entityEdited;$options)
//  //Else 
//  //  //Tell the user the bad news...
//  //End if 
//  //Reload ?

//$statusUnLock:=Form.overview.unlock()  // Unlock entity