$NumLabo:=ASAPTrouveNumeroLaboParUUID ([CampagneParticipations:17]UUIDPersonne:2)
$Histoire:=Timestamp:C1445+" : "+<>ZQuiCode+" a supprimé la participation à la campagne n°"+[CampagneParticipations:17]NumCampagne:3+" du labo "+$NumLabo
READ WRITE:C146([XHistoriques:6])
QUERY:C277([XHistoriques:6];[XHistoriques:6]InitialesUtilisateur:2=<>ZQuiCode)
[XHistoriques:6]Histoire:3:=$Histoire+<>ZCR+[XHistoriques:6]Histoire:3
SAVE RECORD:C53([XHistoriques:6])
ZAmnistiePartielle (->[XHistoriques:6])
