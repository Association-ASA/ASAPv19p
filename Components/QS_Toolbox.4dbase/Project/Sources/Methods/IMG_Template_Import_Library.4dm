//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 24/12/16, 09:06:37
  // ----------------------------------------------------
  // IMG_Template_Import_Library
  // description
  // replace picture library from a folfer. It is based on picture name and filename
  //
  // ----------------------------------------------------

C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684

  // ===================== Declare Variables ==================================
  // method_parameters_declarations
  // --------------------------------------------------------------------------------
  // method_wide_constants_declarations
  // --------------------------------------------------------------------------------
  // local_variable_declarations

C_LONGINT:C283($SOA;$p_L;$Pos_L;$count)
C_TEXT:C284($folder;$filename)
C_PICTURE:C286($Pict_G)

  // ====================== Initialize and Setup ================================

ARRAY LONGINT:C221($PictRef_aL;0x0000)
ARRAY TEXT:C222($PictName_aT;0x0000)
ARRAY TEXT:C222($TbFilenames;0x0000)

PICTURE LIBRARY LIST:C564($PictRef_aL;$PictName_aT)
SORT ARRAY:C229($PictName_aT;$PictRef_aL;>)
$SOA:=Size of array:C274($PictRef_aL)

$folder:=Select folder:C670(Get 4D folder:C485(Current resources folder:K5:16))

If ($folder#"")
	
	DOCUMENT LIST:C474($folder;$TbFilenames;Ignore invisible:K24:16)
	SORT ARRAY:C229($TbFilenames;>)
	$TbSize:=Size of array:C274($TbFilenames)
	
End if 

  // ======================== Method Actions ==================================

If ($TbSize>0)  // there is at least ONE file
	
	For ($a;1;Size of array:C274($TbFilenames))
		
		$filename:=$folder+$TbFilenames{$a}
		$P_L:=Position:C15(".";$TbFilenames{$a})
		$NoExtention:=Substring:C12($TbFilenames{$a};1;$P_L-1)
		
		If (Find in sorted array:C1333($PictName_aT;$NoExtention;>;$Pos_L))
			
			If (Is picture file:C1113($filename))  // do the job only for a picture
				
				READ PICTURE FILE:C678($filename;$Pict_G)
				CONVERT PICTURE:C1002($Pict_G;".png")  // in case of it is not a PNG format
				SET PICTURE TO LIBRARY:C566($Pict_G;$PictRef_aL{$Pos_L};$PictName_aT{$Pos_L})
				$Pict_G:=$Pict_G*0
				$count:=$count+1
				
			End if 
		End if 
	End for 
	
	ALERT:C41(String:C10($count)+" pictures have been imported successfully into the picture library.")
	
Else 
	
	ALERT:C41("The folder is empty.")
	
End if 