//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSql":false,"published4DMobile":{"scope":"none"},"executedOnServer":false}
#DECLARE($title : Text)->$html : Text

var $col : Collection

$col:=New collection:C1472
$col.push("<html>")
$col.push("<head>")
$col.push("<script src=\"js/jquery-1.8.2.min.js\" Type=\"text/javascript\"></script>")
$col.push("<script src=\"js/jquery.easing.js\" Type=\"text/javascript\"></script>")
$col.push("<script src=\"js/jqueryFileTree.js\" Type=\"text/javascript\"></script>")
$col.push("<link rel=\"stylesheet\" Type=\"text/css\" href=\"css/QS_toolbox.css\"/>")

$col.push("<script type=\"text/javascript\">")
$col.push("$(document).ready(function(){")
$col.push("$('#TreeMethods').fileTree(function(file){")
$col.push("alert(file);")
$col.push("});")
$col.push("});")
$col.push("</script>")

$col.push("<title>"+$title+"</title>")
$col.push("</head>")
$col.push("<body onload=\"addEvents();\">")
$col.push("<div class=\"header\">"+$title+"</div>")
$col.push("<div class=\"navigation\">"+$title+"<p>")
$col.push("<div id=\"TreeMethods\"class=\"Insider\">")

$col.push("\r")
$html:=$col.join("\r")
