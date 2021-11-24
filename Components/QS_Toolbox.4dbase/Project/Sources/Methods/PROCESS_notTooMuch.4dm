//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($max)
  //$nbCores:=Storage.sysInfo.cores

  //Case of 

  //: ($nbCores<4)
  //$max:=50

  //: ($nbCores=6)
  //$max:=70

  //: ($nbCores=8)
  //$max:=100

  //: ($nbCores=10)
  //$max:=120

  //: ($nbCores>=12)
  //$max:=180

  //End case 
$max:=20

While (Count user processes:C343>$max)
	Case of 
		: (Count parameters:C259=1)
			PROCESS_sleep ($1)
			
		: (Count parameters:C259=2)
			PROCESS_sleep ($1;$2)
			
		Else 
			PROCESS_sleep 
	End case 
End while 
