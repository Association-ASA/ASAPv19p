//%attributes = {"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSql":false,"invisible":true,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($file)

$file:=Convert path system to POSIX:C1106(File:C1566("/RESOURCES/nopicture/noPicture.html").platformPath)  // -- For Mac comptability
WA OPEN URL:C1020(*;"webZone";"file:///"+$file)
