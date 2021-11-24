$NumLabo:=ASAPTrouveNumeroLaboParUUID([Personnes:12]UUID:1)
$Histoire:=Timestamp:C1445+" : "+<>ZQuiCode+" a supprimé la personne "+[Personnes:12]NomLong:2+" numéro "+$NumLabo
READ WRITE:C146([XHistoriques:6])
QUERY:C277([XHistoriques:6]; [XHistoriques:6]InitialesUtilisateur:2=<>ZQuiCode)
[XHistoriques:6]Histoire:3:=$Histoire+<>ZCR+[XHistoriques:6]Histoire:3
SAVE RECORD:C53([XHistoriques:6])
ZAmnistiePartielle(->[XHistoriques:6])
