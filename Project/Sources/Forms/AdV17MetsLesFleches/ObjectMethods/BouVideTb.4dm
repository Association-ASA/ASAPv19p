CONFIRM:C162("Désirez-vous supprimer toutes les explications ????";"Oui c'est bien ça";"Mais, non")
If (OK=1)
	CONFIRM:C162("Désirez-vous VRAIMENT supprimer toutes les explications ????";"Mais, non";"Oui c'est bien ça")
	If (OK=0)
		DiaVideTbEtCommentaires 
		ZVariableVersBlob (->[Diapositives:40]BlobFleches:21;->TbTb;->TbLHT;->TbTCa)
		[Diapositives:40]DiapoCommentaire:26:=(BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
		SAVE RECORD:C53([Diapositives:40])
	End if 
End if 