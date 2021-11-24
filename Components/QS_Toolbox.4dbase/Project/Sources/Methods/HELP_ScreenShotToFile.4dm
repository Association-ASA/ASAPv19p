//%attributes = {"invisible":true,"shared":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent","lang":"en"}
// ===========================================
// PROJECT METHOD: HELP_ScreenshotToFile
// PARAMETERS: $0 = path to file containing screenshot
// DESCRIPTION: Take a screenshot in PNG format of the screen where the frontmost
// window is located and returns the path to the file containing it.
// macOS support for multiple screens. On Windows you get all screens.

// CREATED BY: Tim Nevels, Innovative Solutions ©2018
// DATE: 1/5/18
// LAST MODIFIED:
// By Association QualiSoft
// ============================================
// http://4d.1045681.n5.nabble.com/ScreenshotToFile-Method-td5756240.html
// see also: http://www.nirsoft.net/utils/nircmd.html
// see also: http://dailymactips.com/take-screenshots-on-your-mac-using-the-terminal-application/


C_TEXT:C284($0; $filePath; $1)
C_TEXT:C284($fileName; $screenRectOption_t; $commandName; $inputStream; $outputStream; $errorStream_t)
C_LONGINT:C283($left; $top; $right; $bottom)

$Soft:=Storage:C1525.QS_TBX_SHARED_DATA.SoftName

// create temporary file path
$fileName:="Screenshot "+String:C10(Current date:C33; ISO date:K1:8; Current time:C178)+".png"
//$fileName:=Replace string($fileName; "/"; "-")  // replace slashes with dashes in file name
//$fileName:=Replace string($fileName; ":"; ".")  // replace colons with periods in file name
TOOL_trimCharacters(->$fileName)
$filePath:=Get 4D folder:C485(Logs folder:K5:19; *)+$fileName

// Add the possibility to define your own folder to receive screenshots
If (Count parameters:C259=1)
	If (Test path name:C476($1)=Is a folder:K24:2)
		$filePath:=$1+$fileName
	End if 
End if 

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")

If (Is macOS:C1572)  // Mac
	
/*
Options available with ScreenCapture command line
	
All Of The Flags You Can Use With The Screencapture Command
Below is a list of all of the flags that you can use in conjunction with the scr
	
usage: screencapture [-icMPmwsWxSCUtoa] [files]
-c force screen capture to go to the clipboard
-C capture the cursor as well as the screen. only in non-interactive modes
-d display errors to the user graphically
-i capture screen interactively, by selection or window
control key – causes screen shot to go to clipboard
space key – toggle between mouse selection and
window selection modes
escape key – cancels interactive screen shot
-m only capture the main monitor, undefined if-i is set
-M screen capture output will go to a new Mail message
-o in window capture mode, do not capture the shadow of the window
-P screen capture output will open in Preview
-s only allow mouse selection mode
-S in window capture mode, capture the screen not the window
-t image format to create, default is png(other options include pdf, jpg, tiff and other formats)
-T Take the picture after a delay of , default is 5
-w only allow window selection mode
-W start interaction in window selection mode
-x do not play sounds
-a do not include windows attached to selected windows
-r do not add dpi meta data to image
-l capture this windowsid
-R capture screen rect
*/
	
	// get screen coordinates
	SCREEN COORDINATES:C438($left; $top; $right; $bottom; Menu bar screen:C441)
	$screenRectOption_t:="-R"+String:C10($left)+","+String:C10($top)+","+String:C10($right)+","+String:C10($bottom)
	
	// get screenshot
	$commandName:="screencapture "+$screenRectOption_t+" '"+Convert path system to POSIX:C1106($filePath)+"'"
	LAUNCH EXTERNAL PROCESS:C811($commandName; $inputStream; $outputStream; $errorStream_t)
	
Else   // Windows
	
	// All these syntaxes provide the same result
	//$Path:=Get 4D folder(Current resources folder)+"nircmd"+Folder separator+"nircmdc.exe"
	//$Path:=Folder(fk resources folder).folder("nircmd").file("nircmdc.exe").platformPath
	//$Path:=Folder(fk resources folder).file("nircmd/nircmdc.exe").platformPath
	
	$Path:=Folder:C1567(fk resources folder:K87:11).file("nircmd/nircmdc.exe")
	//If (Test path name($Path)=Is a document)
	If ($Path.exists) & ($Path.isFile)
		
		// get screenshot
		//$commandName:=Get 4D folder(Current resources folder)+"nircmd"+Folder separator+"nircmdc.exe savescreenshotfull "+Char(Double quote)+$filePath+Char(Double quote)
		$commandName:=$Path.platformPath+" savescreenshotfull "+Char:C90(Double quote:K15:41)+$filePath+Char:C90(Double quote:K15:41)
		LAUNCH EXTERNAL PROCESS:C811($commandName; $inputStream; $outputStream; $errorStream_t)
		
		If ($errorStream_t#"")
			ALERT:C41("Nircmdc.exe screen capture problem.\n"+$errorStream_t; "Error")
		End if 
		
	Else 
		ALERT:C41("Nircmdc.exe program is missing. Install it into the Ressources folder from "+$Soft+" in the folder: 'nircmd'.\\You can download the programm from www.nirsoft.net")
	End if 
End if 

// return file path
$0:=$filePath