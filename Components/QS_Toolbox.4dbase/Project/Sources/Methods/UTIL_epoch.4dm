//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  //================================================================================
  //@4ddoc-start en
  //@name DAT_epoch
  //@scope public
  //@deprecated no
  //@description This function returns the epoch timestamp value(number of seconds since 1970-01-01 UTC)
  //@parameter[0-OUT-epoch-TEXT] epoch
  //@notes:
  //@example DAT_epoch
  //@see:
  //@version 1.00.00
  //@author Bruno LEGAY(BLE)- Copyrights A&C Consulting- 2008
  //@history CREATION Bruno LEGAY(BLE)- 20/07/2017, 091244- v1.00.00
  //@4ddoc-end
  //================================================================================
  // http://forums.4d.com/Post/FR/19709356/1/19709644#19709357

C_LONGINT:C283($0;$vl_epoch)

C_DATE:C307($vd_date)
C_TIME:C306($vh_time)

If (Count parameters:C259=0)
	$vd_date:=Current date:C33
	$vh_time:=Current time:C178
Else 
	ASSERT:C1129(Count parameters:C259=2;Current method name:C684+" expect 2 parameters (Date;Time)")
	C_DATE:C307($1)
	C_TIME:C306($2)
	$vd_date:=$1
	$vh_time:=$2
End if 

C_TEXT:C284($vt_timestampUtc)
$vt_timestampUtc:=String:C10($vd_date;ISO date GMT:K1:10;$vh_time)
  //"2017-03-26T18:07:16Z" at 200716 french time zone(just moved to summer time on 26th march 2017)

  //"2017-03-26T18:07:16Z" at 200716 french time zone(just moved to summer time on 26th march 2017)
  // NOTE in v12, v13, v14 there is a bug on 26/03/2017(day when the daylight shift changes) it returns 190716Z when it should return 180716Z. Ok for subsequent days...
  // seems ok in v15- tested on Mac OS 10.8

$vt_timestampUtc:=Substring:C12($vt_timestampUtc;1;19)  //remove the"Z"

  // XML DECODE will convert"2017-03-26T18:07:16" into!2017-03-26! date and?180716? time
  // works ok in 4D v12+ great trick from Miyako to parse a timestamp;-)
C_DATE:C307($vd_dateUtc)
C_TIME:C306($vh_timeUtc)
XML DECODE:C1091($vt_timestampUtc;$vd_dateUtc)
XML DECODE:C1091($vt_timestampUtc;$vh_timeUtc)

$vl_epoch:=(($vd_dateUtc-!1980-01-01!)*86400)+$vh_timeUtc

$0:=$vl_epoch