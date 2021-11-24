//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // =========================================== 
  // PROJECT METHOD: Dropbox_UploadFile 

  // PARAMETERS: $0 = results object 
  // $1 = dropbox access token 
  // $2 = dropbox path 
  // $3 = file path 

  // DESCRIPTION: Uploads a file to Dropbox using the v2 API 
  // Max upload size in a single transfer is 150MB. 

  // https://www.dropbox.com/developers/documentation/http/documentation

  // CREATED BY: Tim Nevels, Innovative Solutions ©2019 
  // DATE: 3/8/19 
  // LAST MODIFIED: 
  // ============================================ 

C_OBJECT:C1216($0;$results_o)
C_TEXT:C284($1;$dropboxAccessToken_t)
C_TEXT:C284($2;$dropboxPath_t)
C_TEXT:C284($3;$filePath_t)
$dropboxAccessToken_t:=$1
$dropboxPath_t:=$2
$filePath_t:=$3

  // declare local variables 
C_TEXT:C284($headerValue_t;$requestURL_t;$response_t)
C_LONGINT:C283($statusCode_l)
C_BLOB:C604($content_x)
C_OBJECT:C1216($headerValue_o;$response_o)
ARRAY TEXT:C222($headerName_at;0)
ARRAY TEXT:C222($headerValue_at;0)

  // setup http header 
APPEND TO ARRAY:C911($headerName_at;"Authorization")
APPEND TO ARRAY:C911($headerValue_at;"Bearer "+$dropboxAccessToken_t)

  // set upload header values 
APPEND TO ARRAY:C911($headerName_at;"Content-Type")
APPEND TO ARRAY:C911($headerValue_at;"application/octet-stream")

APPEND TO ARRAY:C911($headerName_at;"Dropbox-API-Arg")
$headerValue_o:=New object:C1471(\
"path";$dropboxPath_t;\
"mode";"add";\
"autorename";False:C215)  // overwrite any existing file 
$headerValue_t:=JSON Stringify:C1217($headerValue_o)
APPEND TO ARRAY:C911($headerValue_at;$headerValue_t)

  // set url 
$requestURL_t:="https://content.dropboxapi.com/2/files/upload"

  // load the file 
DOCUMENT TO BLOB:C525($filePath_t;$content_x)

  // check file size 
If (BLOB size:C605($content_x)>(1024*1024*149))  // over 149MB, too close to limit to try 
	$results_o:=New object:C1471(\
		"success";False:C215;\
		"statusCode";408;\
		"errorMessage";"File is to large to upload in one piece")
Else 
	  // upload the file 
	HTTP SET OPTION:C1160(HTTP compression:K71:15;1)  // do compression 
	HTTP SET OPTION:C1160(HTTP timeout:K71:10;60*10)  // 10 minute timeout 
	$statusCode_l:=HTTP Request:C1158(HTTP POST method:K71:2;$requestURL_t;$content_x;$response_t;$headerName_at;$headerValue_at)
	
	  // build results object 
	Case of 
		: ($statusCode_l=200)  // upload was a success 
			$results_o:=New object:C1471(\
				"success";True:C214;\
				"statusCode";$statusCode_l;\
				"errorMessage";"File upload was successful")
			
		: ($statusCode_l=409)  // endpoint specific problem 
			$response_o:=JSON Parse:C1218($response_t)
			$results_o:=New object:C1471(\
				"success";False:C215;\
				"statusCode";$statusCode_l;\
				"errorMessage";$response_o.error_summary)
			
		Else   // other problem 
			$results_o:=New object:C1471(\
				"success";False:C215;\
				"statusCode";$statusCode_l;\
				"errorMessage";"HTTP Request failed"+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
				$response_t)
	End case 
End if 

  // return results 
$0:=$results_o