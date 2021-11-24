$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_TEXT:C284($TbNumEchRaema; 0)
		$TbNumEchRaema:=OB Get:C1224([RAEMACampagnes:20]Arguments:7; "N° des échantillons"; Est un texte:K8:3)
		ZTexteVersTableau($TbNumEchRaema; ->TbNumEchRaema)
		If (Size of array:C274(TbNumEchRaema1)=0)
			RaemaEchFabriqueTbSeries
		End if 
		OBJECT SET VISIBLE:C603(BouImporteNumEch; (Size of array:C274(TbNumEchRaema)=0))
		
End case 
