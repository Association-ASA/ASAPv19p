//%attributes = {"invisible":true}
// Project Method: LH_collapseLevel
//
// Parameter Type Description
//
//
// Description:
// Expand all the levels <= level of a list
// Collapse highers
//
// Date        Init  Description
// ===================================================================
// 12/11/2021   OG   Initial version.

C_LONGINT:C283($1; $vL_list)
C_LONGINT:C283($2; $3; $vL_level)
C_POINTER:C301($4; $5; $6; $7)

$vL_list:=$1
$vL_level:=$2

C_LONGINT:C283($vL_itemRef; $vL_asublist)
C_TEXT:C284($vT_itemText)
C_BOOLEAN:C305($is_aexpanded)

$is_recursive:=(Count parameters:C259=7)
If ($is_recursive)
	C_LONGINT:C283($vL_level_current)
	C_POINTER:C301($ptr_aL_itemRef; $ptr_aL_sublists; $ptr_aT_labels; $ptr_aB_is_expand)
	$vL_level_current:=$3
	$ptr_aL_itemRef:=$4
	$ptr_aL_sublists:=$5
	$ptr_aT_labels:=$6
	$ptr_aB_is_expand:=$7
Else 
	$vL_level_current:=1
	ARRAY LONGINT:C221($aL_itemRef; 0)
	ARRAY LONGINT:C221($aL_sublists; 0)
	ARRAY TEXT:C222($aT_labels; 0)
	ARRAY BOOLEAN:C223($aB_is_expand; 0)
	$ptr_aL_itemRef:=->$aL_itemRef
	$ptr_aL_sublists:=->$aL_sublists
	$ptr_aT_labels:=->$aT_labels
	$ptr_aB_is_expand:=->$aB_is_expand
	
End if 

For ($i; 1; Count list items:C380($vL_list; *))
	GET LIST ITEM:C378($vL_list; $i; $vL_itemRef; $vT_itemText; $vL_asublist; $is_aexpanded)
	If (Is a list:C621($vL_asublist))
		LH_collapseLevel($vL_asublist; $vL_level; $vL_level_current+1; $ptr_aL_itemRef; $ptr_aL_sublists; $ptr_aT_labels; $ptr_aB_is_expand)
		$is_expand_l:=($vL_level>=$vL_level_current)
		If ($is_expand_l#$is_aexpanded)
			//If (Not($is_expand))  //& ($aexpanded)
			APPEND TO ARRAY:C911($ptr_aL_itemRef->; $vL_itemRef)
			APPEND TO ARRAY:C911($ptr_aL_sublists->; $vL_asublist)
			APPEND TO ARRAY:C911($ptr_aT_labels->; $vT_itemText)
			APPEND TO ARRAY:C911($ptr_aB_is_expand->; $is_expand_l)
		End if 
	End if 
End for 

// At the end, update all
If (Not:C34($is_recursive))
	For ($i; 1; Size of array:C274($aL_itemRef))
		$vL_itemRef:=$aL_itemRef{$i}
		$vL_asublist:=$aL_sublists{$i}
		$vT_itemText:=$aT_labels{$i}
		$is_expand_l:=$aB_is_expand{$i}
		SET LIST ITEM:C385($vL_list; $vL_itemRef; $vT_itemText; $vL_itemRef; $vL_asublist; $is_expand_l)
	End for 
End if 