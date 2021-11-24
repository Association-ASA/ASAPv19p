$evt:=Form event code:C388
Case of 
	: ($evt=Sur après frappe clavier:K2:26)
		[PersonnesAdresses:11]Pays:8:=YSaisieAssiste (-><>TbNomPays;1;False:C215)
		$L:=Find in array:C230(<>TbNomPays;[PersonnesAdresses:11]Pays:8)
		If ($L>0)
			VarCodePays:=<>TbCodeIsoASA{$L}
		Else 
			VarCodePays:=""
		End if 
	: ($evt=Sur données modifiées:K2:15)
		CaCOutreMer:=0
		Case of 
			: ([PersonnesAdresses:11]Pays:8="France")
				OB SET:C1220([Personnes:12]Arguments:7;"FacturationPays";"France")
				
			: ([PersonnesAdresses:11]Pays:8="@Guadeloupe@") | ([PersonnesAdresses:11]Pays:8="@Reunion@") | ([PersonnesAdresses:11]Pays:8="@Calédonie@") | ([PersonnesAdresses:11]Pays:8="@Polynésie@") | ([PersonnesAdresses:11]Pays:8="@Miquelon@") | ([PersonnesAdresses:11]Pays:8="@Martinique@")
				OB SET:C1220([Personnes:12]Arguments:7;"FacturationPays";"Outre Mer")
				CaCOutreMer:=1
				
			: ([PersonnesAdresses:11]Pays:8="@Saint-Barthélemy@") | ([PersonnesAdresses:11]Pays:8="@Saint-Martin@") | ([PersonnesAdresses:11]Pays:8="@Wallis-et-Futuna@") | ([PersonnesAdresses:11]Pays:8="@Mayotte@")
				OB SET:C1220([Personnes:12]Arguments:7;"FacturationPays";"Outre Mer")
				CaCOutreMer:=1
				
			: ([PersonnesAdresses:11]Pays:8#"France")
				OB SET:C1220([Personnes:12]Arguments:7;"FacturationPays";"Etrangers")
		End case 
End case 
