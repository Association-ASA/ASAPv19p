// 4DInfo_report

If (Get 4D folder:C485(Database folder:K5:14; *)=Get 4D folder:C485(Database folder:K5:14)) & (Application type:C494#4D Server:K5:6) & (QST_minimalVersion)
	C_POINTER:C301($Pt)
	QS_Init($Pt; False:C215)
	ON EVENT CALL:C190("_onEvent")
	mQST_MNU_Start
End if 
