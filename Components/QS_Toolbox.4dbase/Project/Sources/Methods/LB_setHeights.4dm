//%attributes = {"invisible":true}
/*
Resize Headers & Rows of the listbox

Values in number of lines

$1: Listbox
$2: height for Headers
$3: height for Rows
*/

#DECLARE($Listbox_Name : Text; $headHight : Integer; $rowHeight : Integer)

LISTBOX SET HEADERS HEIGHT:C1143(*; $Listbox_Name; $headHight; lk lines:K53:23)
LISTBOX SET ROWS HEIGHT:C835(*; $Listbox_Name; $rowHeight; lk lines:K53:23)