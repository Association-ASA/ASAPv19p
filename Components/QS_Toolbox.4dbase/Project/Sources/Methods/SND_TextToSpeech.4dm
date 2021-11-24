//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/06/18, 06:57:45
  // ----------------------------------------------------
  // Paramètres
  // $1 = Text to be sounded
  // ----------------------------------------------------
  // Méthode : SND_TextToSpeech
  // Description
  // http://kb.4d.com/assetid=78019
  // SND_TextToSpeech("Wow, it actually works!")

C_TEXT:C284($1;$cmd;$in;$out;$err)
C_TEXT:C284($textToSpeech)

If (Count parameters:C259=1)
	$textToSpeech:=$1
	If (Folder separator:K24:12=":")
		  // mac
		$cmd:="say "+$textToSpeech
	Else 
		  //windows
		$cmd:="PowerShell -Command \"Add-Type –AssemblyName System.Speech;(New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('"+$textToSpeech+"');\""
	End if 
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"false")
	LAUNCH EXTERNAL PROCESS:C811($cmd;$in;$out;$err)
End if 