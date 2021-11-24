$TexteNumEch:=""
$TexteNumEch:=OB Get:C1224([RAEMACampagnes:20]Arguments:7;"N° des échantillons";Est un texte:K8:3)
If (Size of array:C274(TbNumEchRaema)>0) & ($TexteNumEch="")
	ZVerrouAttendre (->[RAEMACampagnes:20])
	OB SET:C1220([RAEMACampagnes:20]Arguments:7;"N° des échantillons";ZTableauVersTexte (->TbNumEchRaema))
	SAVE RECORD:C53([RAEMACampagnes:20])
	ZAmnistiePartielle (->[RAEMACampagnes:20];True:C214)
End if 