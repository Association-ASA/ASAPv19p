//%attributes = {"invisible":true}
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(2) - "+Current method name:C684+" -> start")

C_OBJECT:C1216($licence)
$licence:=New object:C1471
$licence.result:=False:C215
$licence:=QST_licence

key_toStorage($licence)

Case of 
	: ($licence.wizard=True:C214)
		__Wizard
		
	: ($licence.result=False:C215) & ($licence.title#"touched")
		ALERT:C41("Licence has expired. QS_Toolbox will not start.")
		
	: ($licence.result=False:C215) & ($licence.title="touched")
		ALERT:C41("Error!!!\nThe licence file has been manually touched."+\
			"\nPlease, restore the initial licence file or remove QS_Toolbox from your application!."+\
			"\n\nThe licence price is not expensive at all."+\
			"\nIt allows us to continue to buy our own 4D Licence and deliver products like QS_Toolbox.")
		
End case 
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(3) - "+Current method name:C684+" -> end")