//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // *** From PICT_Convert (JPR) ***
  //$smallStyle:=HTP_Util_GiveStyleTag ("";"";"-")

C_TEXT:C284($1;$2;$3;$color;$style;$size;$result)

$color:=$1
$style:=$2
$size:=$3

$result:="<span style="+Char:C90(Double quote:K15:41)  //"<span style='font-weight:bold; font-style:normal; color:green'>"

Case of 
	: ($color="#@")
		$result:=$result+" color: "+$color+";"
	: ($color="rgb@")
		$result:=$result+" color: "+$color+";"
	: ($color#"")
		$result:=$result+" color: "+$color+";"
	Else 
		
End case 

$fontStyle:=""
Case of 
	: (Position:C15("BB";$style)>0)
		$result:=$result+" font-weight:bolder;"
	: (Position:C15("B";$style)>0)
		$result:=$result+" font-weight:bold;"
	Else 
		  //$result:=$result+" font-weight:normal;"
End case 

Case of 
	: (Position:C15("II";$style)>0)
		$result:=$result+" font-style:oblique;"
	: (Position:C15("I";$style)>0)
		$result:=$result+" font-style:italic;"
	Else 
		  //$result:=$result+" font-style:normal;"
End case 

Case of 
	: ($size="+")
		$result:=$result+" font-size: 120%;"
	: ($size="++")
		$result:=$result+" font-size: 150%;"
	: ($size="+++")
		$result:=$result+" font-size: 200%;"
	: ($size="-")
		$result:=$result+" font-size: 75%;"
	: ($size="--")
		$result:=$result+" font-size: 50%;"
	: ($size="")
	Else 
		$result:=$result+" font-size: "+$size+"%;"
End case 

$result:=$result+Char:C90(Double quote:K15:41)+">"

$0:=$result