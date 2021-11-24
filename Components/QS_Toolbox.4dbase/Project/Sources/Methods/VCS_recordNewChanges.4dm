//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_BOOLEAN:C305($result)
CALL FORM:C1391(Current form window:C827;"VCS_CreateStampPoint")
CALL FORM:C1391(Current form window:C827;"VCS_Refresh")
CALL FORM:C1391(Current form window:C827;"displayInfo";"Methods export finished.")
Form:C1466.currentVersion:=""
Form:C1466.oldVersion:=""
WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_VCS";"insertInEditor";$result;"mergeleft";$currentVersion)
PROCESS_sleep (5)
WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_VCS";"insertInEditor";$result;"mergeright";$old)