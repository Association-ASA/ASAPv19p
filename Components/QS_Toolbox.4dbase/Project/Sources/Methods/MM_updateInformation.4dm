//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  //To reload listbox
Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed
$txt:=String:C10(Form:C1466.listboxDisplayed.length)+" method"+("s"*Num:C11(Form:C1466.listboxDisplayed.length>1))+" found."
CALL FORM:C1391(Current form window:C827;"displayInfo";$txt;"Blue")