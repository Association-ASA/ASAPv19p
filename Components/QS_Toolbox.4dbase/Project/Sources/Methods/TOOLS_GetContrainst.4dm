//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 25/06/17, 08:36:57
  // ----------------------------------------------------
  // méthode : TOOLS_GetContrainst
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

  // http://forums.4d.fr/Post/FR/19597033/1/19597034#19597034
  // ce code lit les contraintes de suppression (cascade et restrict), élimine les restrict
  // arnaud DE MONTARD

ARRAY LONGINT:C221($TableID_al;0x0000)
ARRAY LONGINT:C221($columnID_al;0x0000)
ARRAY TEXT:C222($deleteRule_at;0x0000)

Begin SQL
	SELECT _USER_CONS_COLUMNS.Table_ID, _USER_CONS_COLUMNS.COLUMN_ID,  _USER_CONSTRAINTS.DELETE_RULE
	FROM _USER_CONS_COLUMNS
	LEFT JOIN _USER_CONSTRAINTS
	ON _USER_CONSTRAINTS.CONSTRAINT_ID=_USER_CONS_COLUMNS.CONSTRAINT_ID
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE='4DR'
	INTO :$TableID_al, :$columnID_al, :$deleteRule_at;
	
End SQL

For ($i_l;Size of array:C274($deleteRule_at);1;-1)
	
	If ($deleteRule_at{$i_l}="restrict")  // "cascade"
		
		DELETE FROM ARRAY:C228($TableID_al;$i_l)
		DELETE FROM ARRAY:C228($columnID_al;$i_l)
		DELETE FROM ARRAY:C228($deleteRule_at;$i_l)
		
	End if 
End for 

$rapport_t:=""

For ($i_l;1;Size of array:C274($deleteRule_at))
	
	$rapport_t:=$rapport_t+Table name:C256($TableID_al{$i_l})
	$rapport_t:=$rapport_t+"."
	$rapport_t:=$rapport_t+Field name:C257($TableID_al{$i_l};$columnID_al{$i_l})
	$rapport_t:=$rapport_t+" * "+$deleteRule_at{$i_l}
	$rapport_t:=$rapport_t+"\r"
	
End for 

If ($rapport_t="")
	$rapport_t:="No contrainst found."
End if 

SET TEXT TO PASTEBOARD:C523($rapport_t)
