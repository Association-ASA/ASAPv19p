//%attributes = {"executedOnServer":true}

EXECUTE ON CLIENT:C651("@"; "wgetObjectFromServerStorage"; $1)
DELAY PROCESS:C323(Current process:C322; 90)
CALL FORM:C1391(Current form window:C827; "wLBpersonnes")
