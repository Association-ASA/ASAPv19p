//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // Event handler

If ((Modifiers ?? Command key bit:K16:2) & (KeyCode=Period:K15:45))
	FILTER EVENT:C321
	CALL WORKER:C1389("QST_PaletteExplorer";"__MethodsPallet")
End if 
