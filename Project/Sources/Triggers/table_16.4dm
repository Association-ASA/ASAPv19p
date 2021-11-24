$Histoire:=Timestamp:C1445+" : "+<>ZQuiCode+" a supprimé la vente de la facture n°"+[Ventes:16]NumFacture:2
READ WRITE:C146([XHistoriques:6])
QUERY:C277([XHistoriques:6];[XHistoriques:6]InitialesUtilisateur:2=<>ZQuiCode)
[XHistoriques:6]Histoire:3:=$Histoire+<>ZCR+[XHistoriques:6]Histoire:3
SAVE RECORD:C53([XHistoriques:6])
ZAmnistiePartielle (->[XHistoriques:6])
