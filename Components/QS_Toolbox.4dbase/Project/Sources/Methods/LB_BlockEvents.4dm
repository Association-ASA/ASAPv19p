//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 11/11/17, 11:43:13
// ----------------------------------------------------
// Méthode : LB_BlockEvents
// Description
//  Disable all events for a listbox
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($1)
ARRAY LONGINT:C221($MyEventsOnLB; 0x0000)
OBJECT SET EVENTS:C1239(*; $1; $MyEventsOnLB; Enable events disable others:K42:37)