//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 24/12/16, 09:06:37
  // ----------------------------------------------------
  // description
  // original method name: IMG_Template_Export_Library
  // the method code must be copied into a "temporary method" of the host database
  // then, it must be executed and method's content will be cleared
  // the method create into the host will have this name : __QS_TOOLBOX_temporary_method
  //
  // source
  // http://kb.4d.com/assetid=76775
  // updated for QS_Toolbox component
  // ----------------------------------------------------


C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684

  // ===================== Declare Variables ==================================
  // method_parameters_declarations
  // --------------------------------------------------------------------------------
  // method_wide_constants_declarations
  // --------------------------------------------------------------------------------
  // local_variable_declarations

C_LONGINT:C283($Ndx;$SOA;$PictRef_L)
C_TEXT:C284($PictName_T)
C_PICTURE:C286($Pict_G)
C_POINTER:C301($Pict_P)
C_BOOLEAN:C305($Destroy;$toOverWrite)


  // ====================== Initialize and Setup ================================

ARRAY LONGINT:C221($PictRef_aL;0x0000)
ARRAY TEXT:C222($PictName_aT;0x0000)
$toOverWrite:=True:C214

  // NOT YET
  // CONFIRM("Do you want to clear all picture exported ?")

If (ok=1)
	$Destroy:=True:C214
End if 

  // *** TO REMOVE if confirmation is activated
$Destroy:=False:C215
  // ***

PICTURE LIBRARY LIST:C564($PictRef_aL;$PictName_aT)
$SOA:=Size of array:C274($PictRef_aL)

  // ======================== Method Actions ==================================

If ($SOA>0)
	
	$path_t:=Get 4D folder:C485(Current resources folder:K5:16;*)+Replace string:C233("QS_Toolbox_export_library/";"/";Folder separator:K24:12)
	
	For ($Ndx;1;$SOA)  // for each picture
		
		$PictRef_L:=$PictRef_aL{$Ndx}
		$PictName_T:=$PictName_aT{$Ndx}
		
		If ($PictName_T#"")
			
			GET PICTURE FROM LIBRARY:C565($PictRef_aL{$Ndx};$Pict_G)
			$Pict_P:=->$Pict_G  // passage of a pointer
			$Filename:=$path_t+$PictName_T+".png"
			CONVERT PICTURE:C1002($Pict_G;".png")  // conversion to png
			TRANSFORM PICTURE:C988($Pict_G;Transparency:K61:11;0x00FFFFFF)
			
			If ((Test path name:C476($Filename)=Is a document:K24:1) & (Not:C34($toOverWrite)))
				
				CONFIRM:C162("A picture file already exist.\nDo you want to overwrite for all of them ?")
				
				If (OK=0)  // clic on No
					$toOverWrite:=False:C215
				End if 
				
			End if 
			
			If ($toOverWrite)
				WRITE PICTURE FILE:C680($Filename;$Pict_G;"PNGf")
			End if 
			
			$Pict_G:=$Pict_G*0
			
			  //If ((Get document size($Filename)>0) & ($Destroy))
			  //REMOVE PICTURE FROM LIBRARY($PictRef_L)
			  //End if 
			
		End if 
	End for 
	
	SHOW ON DISK:C922($path_t)  // display the folder
	
Else 
	
	ALERT:C41("The picture library is already empty.")
	
End if 
