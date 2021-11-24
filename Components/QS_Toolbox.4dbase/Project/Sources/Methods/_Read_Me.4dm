//%attributes = {"shared":true,"invisible":false,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent","published4DMobile":{"scope":"none"}}
/*

How to start QT_Toolbox (QST)?
- by using the Macro menu or shortcut in method editor
- by using 4D Pop or ogPop
- by inserting the following code:

 ARRAY TEXT($tTxt_Components;0)
 COMPONENT LIST($tTxt_Components)
 If (Not(Is compiled mode))
 If (Find in array($tTxt_Components;"QS_Toolbox@")>0)
 C_POINTER($ptr)
 EXECUTE METHOD("qs_toolbox";*;$ptr)
 End if
 End if


For all methods to execute QS_Toolbox, if you want to speed up the first start, add these code lines in you "on startup" method:
ARRAY TEXT($tTxt_Components;0)
COMPONENT LIST($tTxt_Components)
If (Find in array($tTxt_Components;"QS_Toolbox@")>0)
EXECUTE METHOD("QS_TOOLBOX_init")
End if 

 ----------------------------------------------------
 association QualiSoft
 www.association-qualisoft.eu

 Please, just tell us what do you think about QS_ToolBox
 info@association-qualisoft.eu
 ----------------------------------------------------

*/