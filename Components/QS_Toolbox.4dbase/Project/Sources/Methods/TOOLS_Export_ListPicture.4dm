//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // #TO EVALUATE
  // Method TOOLS_Exports_ListPicture
C_TIME:C306($f)
C_LONGINT:C283($p;$i_tbl;$i_a;$i_frm;$n_frm;$i_obj;$i_sub;$typ)
C_TEXT:C284($s;$s_typ;$s_fmt;$s_sub)
$f:=Create document:C266("")

If (ok=1)
	
	ARRAY TEXT:C222($a_frm;0)
	ARRAY LONGINT:C221($a_tbl;0)
	
	For ($i_tbl;0;Get last table number:C254)
		
		ARRAY TEXT:C222($a;0)
		
		Case of 
				
			: ($i_tbl=0)
				FORM GET NAMES:C1167($a;*)
				
			: (Is table number valid:C999($i_tbl))
				FORM GET NAMES:C1167(Table:C252($i_tbl)->;$a;*)
				
		End case 
		
		For ($i_a;1;Size of array:C274($a))
			APPEND TO ARRAY:C911($a_frm;$a{$i_a})
			APPEND TO ARRAY:C911($a_tbl;$i_tbl)
		End for 
		
	End for 
	
	$n_frm:=Size of array:C274($a_frm)
	
	For ($i_frm;1;$n_frm)
		
		If ($a_tbl{$i_frm}=0)
			FORM LOAD:C1103($a_frm{$i_frm};*)
		Else 
			FORM LOAD:C1103(Table:C252($a_tbl{$i_frm})->;$a_frm{$i_frm};*)
		End if 
		
		ARRAY TEXT:C222($a_obj;0)
		FORM GET OBJECTS:C898($a_obj;*)
		$s:=""
		
		For ($i_obj;1;Size of array:C274($a_obj))
			
			$typ:=OBJECT Get type:C1300(*;$a_obj{$i_obj})
			
			Case of 
					
				: ($typ=2)
					$s_typ:="(Image Statique)"
					
				: ($typ=19)
					$s_typ:="(Bouton Image)"
					
				: ($typ=4)
					$s_typ:="(Image Input)"
					
				: ($typ=14)
					$s_typ:="(Image Popup)"
					
				: ($typ=24)
					$s_typ:="(Image BoutonRadio)"
					
				Else 
					
					$s_typ:="(Type "+String:C10($typ)+")"
					
			End case 
			
			$s_fmt:=OBJECT Get format:C894(*;$a_obj{$i_obj})
			
			For ($i_sub;1;3)
				
				$p:=Position:C15(";";$s_fmt)
				
				If ($p>0)
					$s_sub:=Substring:C12($s_fmt;1;$p-1)
					$s_fmt:=Delete string:C232($s_fmt;1;$p)
				Else 
					$s_sub:=$s_fmt
					$s_fmt:=""
				End if 
				
				Case of 
						
					: ($i_sub#3)
						
					: ($s_sub="?@")
						$s_typ:=$s_typ+" [picture in Librairy]"
						
					: ($s_sub="#@")
						$s_typ:=$s_typ+" [picture in Ressources folder]"
						
				End case 
			End for 
			
			If ($s_typ="@[picture in Librairy]@")
				$s:=$s+Table name:C256($a_tbl{$i_frm})+":"+$a_frm{$i_frm}
				$s:=$s+" => "+$a_obj{$i_obj}+" "+$s_typ+Char:C90(13)
			End if 
			
		End for 
		
		FORM UNLOAD:C1299
		SEND PACKET:C103($f;$s)
		
	End for 
	
	CLOSE DOCUMENT:C267($f)
	ALERT:C41("Ready")
	
End if 
