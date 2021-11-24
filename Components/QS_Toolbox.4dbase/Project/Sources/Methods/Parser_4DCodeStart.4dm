//%attributes = {"invisible":true,"shared":true}
// PM: "startParser4DCode"

openWebAreaForm

Repeat 
	DELAY PROCESS:C323(Current process:C322; 2)
Until ((Process state:C330(Storage:C1525.windows.parseProcess)<Executing:K13:4)\
 | (Process state:C330(Storage:C1525.windows.parseProcess)=Waiting for user event:K13:9)\
 | Process aborted:C672)

// - EOF -