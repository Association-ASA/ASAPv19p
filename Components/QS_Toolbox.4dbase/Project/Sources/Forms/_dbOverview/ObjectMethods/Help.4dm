$action:=False:C215
If (x_io_confirm_yesNo ("This can take a while. Go ahead...";->$action))
	Form:C1466.usedCommand:=New collection:C1472(New object:C1471("command";"Count in progress...";"count";""))
	CALL WORKER:C1389("QST_stats_method_call"+String:C10(Random:C100);"stats_method_call";Current form window:C827;"stats_parseCommand";1)
	CALL WORKER:C1389("QST_debug";"floatWindow_close")
End if 