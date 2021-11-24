//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 12/02/21, 16:01:28
  // ----------------------------------------------------
  // Méthode : ASAPAdhAfficheCaducs
  // Description
  // Affiche les labos caducs dans la partie adhérents
  // ----------------------------------------------------
QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Individu";*)
QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=True:C214)
ASAPPerFabriqueTb (True:C214)
ZFenetreActualiseTitre 