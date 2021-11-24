//%attributes = {"invisible":true,"preemptive":"capable"}
  //Doa_controlFlows -> coll
C_COLLECTION:C1488($0;$controlFlow_c)
$controlFlow_c:=New collection:C1472
$controlFlow_c.push(New object:C1471("FR";"Fin de si";"EN";"End if"))
$controlFlow_c.push(New object:C1471("FR";"Si (";"EN";"If ("))
$controlFlow_c.push(New object:C1471("FR";"Au cas ou";"EN";"Case of"))
$controlFlow_c.push(New object:C1471("FR";"Fin de cas";"EN";"End Case"))
$controlFlow_c.push(New object:C1471("FR";"Fin de chaque";"EN";"End for each"))
$controlFlow_c.push(New object:C1471("FR";"Pour chaque (";"EN";"For each ("))
$controlFlow_c.push(New object:C1471("FR";"Fin de boucle";"EN";"End for"))
$controlFlow_c.push(New object:C1471("FR";"Boucle (";"EN";"For ("))
$controlFlow_c.push(New object:C1471("FR";"Fin tant que";"EN";"End while"))
$controlFlow_c.push(New object:C1471("FR";"Tant que (";"EN";"While ("))
$controlFlow_c.push(New object:C1471("FR";"Repeter";"EN";"Repeat"))
$controlFlow_c.push(New object:C1471("FR";"Jusque (";"EN";"Until ("))
$controlFlow_c.push(New object:C1471("FR";"Debut SQL";"EN";"Begin SQL"))
$controlFlow_c.push(New object:C1471("FR";"Fin SQL";"EN";"End SQL"))
$controlFlow_c.push(New object:C1471("FR";"Sinon";"EN";"Else"))
$controlFlow_c.push(New object:C1471("FR";"Fin utiliser";"EN";"End use"))
$controlFlow_c.push(New object:C1471("FR";"utiliser (";"EN";"Use ("))
$0:=$controlFlow_c