//%attributes = {"invisible":true,"preemptive":"capable"}
PROCESS_sleep(60)
OB_windowNumberToStorage("floatwindow"; 0)
KILL WORKER:C1390("QST__follower")
KILL WORKER:C1390("QST_debug")

