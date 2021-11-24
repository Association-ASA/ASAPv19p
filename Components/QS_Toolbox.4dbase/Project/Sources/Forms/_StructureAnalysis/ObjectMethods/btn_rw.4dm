
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 22/05/18, 08:17:40
  // ----------------------------------------------------
  // Paramètres 
  // ----------------------------------------------------
  // Méthode : METHODS_ReadWrite
  // Description
  //  

If (Form event code:C388=On Clicked:K2:4)
	
	  //$Read:=Form.readAndWrite
	  //$ReadOnly:=($Read=True)
	  //Form.readAndWrite:=Not(Form.readAndWrite)
	  //OBJECT SET ENTERABLE(*;"Attr@";Not($ReadOnly))
	  //OBJECT SET VISIBLE(*;"ReadOnly";$ReadOnly)
	  //OBJECT SET VISIBLE(*;"ReadWrite";Not($ReadOnly))
	
	C_BOOLEAN:C305($is_rw)
	$is_rw:=(x_btn_toggleToggle (Self:C308;2)=1)
	Form:C1466.readAndWrite:=$is_rw
	OBJECT SET ENTERABLE:C238(*;"Attr@";$is_rw)
	
	
End if 

