//%attributes = {}
  //OSmac_darkMode -> bool
  //$0 true si on est en mode sombre sur mac
  //   sous windows c'est toujours False

  //La commande LEP "defaults read -g AppleInterfaceStyle" retourne selon le mode :
  //• sombre $out = "Dark\n"
  //• clair $err_t = "2020-12-24 10:12:13.622 defaults[92752:2648218] \nThe domain/default pair of (kCFPreferencesAnyApplication, AppleInterfaceStyle) does not exist\n"

  //© Arnaud * 24/12/2020 
C_BOOLEAN:C305($0;$out_b)
C_TEXT:C284($command_t;$in_t;$out_t;$err_t)
ARRAY LONGINT:C221($pos_al;0)
ARRAY LONGINT:C221($len_al;0)

$out_b:=False:C215
$sysInfo_o:=Get system info:C1571
If (Match regex:C1019("macOS (\\d{2})\\.(\\d{1,2})\\.\\d{1,2}";$sysInfo_o.osVersion;1;$pos_al;$len_al))
	$main_l:=Num:C11(Substring:C12($sysInfo_o.osVersion;$pos_al{1};$len_al{1}))
	$sub_l:=Num:C11(Substring:C12($sysInfo_o.osVersion;$pos_al{2};$len_al{2}))
	If ($main_l>10) | (($main_l=10) & ($sub_l>=14))  //à partir de Mojave = macOS 10.14.xx, puis big sur 11.xxx
		$command_t:="defaults read -g AppleInterfaceStyle"
		LAUNCH EXTERNAL PROCESS:C811($command_t;$in_t;$out_t;$err_t)
		$out_b:=($out_t="Dark\n")
	End if 
End if 
$0:=$out_b
