//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 08:22:39
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : COLOR_RGBToHSL
  // Description
  //  

  //Col_RGBtoHSL(couleurRVB;->Hue;->Saturation;->Luminosity)
  //C_LONGINT($0)
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_LONGINT:C283($blue_l)
C_LONGINT:C283($green_l)
C_LONGINT:C283($hue_l)
C_LONGINT:C283($lum_l)
C_LONGINT:C283($red_l)
C_LONGINT:C283($sat_l)
  //_
  //$0:=0
Case of 
	: (Count parameters:C259<4)
		  // ErrDev(Current method name+" 4 paramètres RVB attendus")
		  //:($1<0)|($1>255)|($2<0)|($2>255)|($3<0)|($3>255) `RVB
		  //xErrDev(Current method name+" RVB hors limites")
	Else 
		
		$red_l:=(($1 & 0x00FF0000) >> 16)*100/255
		$green_l:=(($1 & 0xFF00) >> 8)*100/255
		$blue_l:=($1 & 0x00FF)*100/255
		
		Case of 
				
			: ($red_l>$green_l) & ($green_l=$blue_l)  //0
				$lum_l:=$red_l
				$sat_l:=100*($lum_l-$blue_l)/$lum_l
				$hue_l:=0
				
			: ($red_l>$green_l) & ($green_l>$blue_l)  //1 à 59
				$lum_l:=$red_l
				$sat_l:=100*($lum_l-$blue_l)/$lum_l
				$hue_l:=0+(60*(($green_l-$blue_l)/($red_l-$blue_l)))  //plus le vert croit, plus le HUE croit
				
			: ($green_l=$red_l) & ($red_l>$blue_l)  //60
				$lum_l:=$red_l
				$sat_l:=100*($lum_l-$blue_l)/$lum_l
				$hue_l:=60
				
			: ($green_l>$red_l) & ($red_l>$blue_l)  //61 à 119
				$lum_l:=$green_l
				$sat_l:=100*($lum_l-$blue_l)/$lum_l
				$hue_l:=60+(60*(($green_l-$red_l)/($green_l-$blue_l)))  //plus le Rouge décroit, plus le HUE croit
				
			: ($green_l>$blue_l) & ($blue_l=$red_l)  //120
				$lum_l:=$green_l
				$sat_l:=100*($lum_l-$red_l)/$lum_l
				$hue_l:=120
				
			: ($green_l>$blue_l) & ($blue_l>$red_l)  //121 à 179
				$lum_l:=$green_l
				$sat_l:=100*($lum_l-$red_l)/$lum_l
				$hue_l:=120+(60*(($blue_l-$red_l)/($green_l-$red_l)))  //plus le bleu croit, plus le HUE croit
				
			: ($blue_l=$green_l) & ($green_l>$red_l)  //180
				$lum_l:=$green_l
				$sat_l:=100*($lum_l-$red_l)/$lum_l
				$hue_l:=180  //180
				
			: ($blue_l>$green_l) & ($green_l>$red_l)  //181 à 239
				$lum_l:=$blue_l
				$sat_l:=100*($lum_l-$red_l)/$lum_l
				$hue_l:=180+(60*(($blue_l-$green_l)/($blue_l-$red_l)))  //plus le Vert décroit, plus le HUE croit
				
			: ($blue_l>$red_l) & ($red_l=$green_l)  //240
				$lum_l:=$blue_l
				$sat_l:=100*($lum_l-$green_l)/$lum_l
				$hue_l:=240
				
			: ($blue_l>$red_l) & ($red_l>$green_l)  //241 à 299
				$lum_l:=$blue_l
				$sat_l:=100*($lum_l-$green_l)/$lum_l
				$hue_l:=240+(60*(($red_l-$green_l)/($blue_l-$green_l)))  //plus le rouge croit, plus le HUE croit
				
			: ($red_l=$blue_l) & ($blue_l>$green_l)  //300
				$lum_l:=$blue_l
				$sat_l:=100*($lum_l-$green_l)/$lum_l
				$hue_l:=300
				
			: ($red_l>=$blue_l) & ($blue_l>=$green_l)
				$lum_l:=$red_l
				$sat_l:=100*($lum_l-$green_l)/$lum_l
				$hue_l:=300+(60*(($red_l-$blue_l)/($red_l-$green_l)))  //plus le Bleu décroit, plus le HUE croit
				
			: ($red_l=$blue_l) & ($blue_l=$green_l)
				$lum_l:=$blue_l  //or red or green
				$sat_l:=0
				$hue_l:=0
				
		End case 
		
		If ($hue_l>=0)
			$2->:=$hue_l
			$3->:=$sat_l
			$4->:=$lum_l
		End if 
End case 
  //_