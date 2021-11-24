
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 29/03/16, 13:19:03
  // ----------------------------------------------------
  // Méthode : DlgTraductions.PUMTraduc
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
OBJECT SET VISIBLE:C603(*;"TradText@";(PUMTraduc=5))
Case of 
		
		  // les lésions
	: (PUMTraduc=1)  // "Nom de la lésion"
		COPY ARRAY:C226(<>TbNLF;Colonne1)
		COPY ARRAY:C226(<>TbNLE;Colonne2)
		COPY ARRAY:C226(<>TbNLR;Colonne3)
		COPY ARRAY:C226(<>TbNumLesN;Colonne3N)
		PtTb1:=-><>TbNLF
		PtTb2:=-><>TbNLE
		PtTb3:=->Colonne3N
		PtTb4:=-><>TbNLR
		COPY ARRAY:C226(<>TbNLF;Colonne4)
		
	: (PUMTraduc=2)  // "Description de la lésion"
		COPY ARRAY:C226(<>TbDMF;Colonne1)
		COPY ARRAY:C226(<>TbDME;Colonne2)
		COPY ARRAY:C226(<>TbDMR;Colonne3)
		COPY ARRAY:C226(<>TbNumLesN;Colonne3N)
		PtTb1:=-><>TbDMF
		PtTb2:=-><>TbDME
		PtTb3:=->Colonne3N
		PtTb4:=-><>TbDMR
		COPY ARRAY:C226(<>TbDMF;Colonne4)
		
	: (PUMTraduc=3)  // "Fiche réflexe de la lésion"
		COPY ARRAY:C226(<>TbFRF;Colonne1)
		COPY ARRAY:C226(<>TbFRE;Colonne2)
		COPY ARRAY:C226(<>TbFRR;Colonne3)
		COPY ARRAY:C226(TbNumLesN;Colonne3N)
		PtTb1:=-><>TbFRF
		PtTb2:=-><>TbFRE
		PtTb3:=->Colonne3N
		PtTb4:=-><>TbFRR
		COPY ARRAY:C226(<>TbFRF;Colonne4)
		
		  // Les diapos
	: (PUMTraduc=4)  // "Diapositives"
		ARRAY OBJECT:C1221($TbObjectDia;0)
		COPY ARRAY:C226(<>TbDiaposComF;Colonne1)
		COPY ARRAY:C226(<>TbDiaposComA;Colonne2)
		COPY ARRAY:C226(<>TbDiaposComR;Colonne3)
		COPY ARRAY:C226(<>TbDiaposNumOrdreDiapos;Colonne3N)
		SORT ARRAY:C229(Colonne3N;Colonne1;Colonne2;Colonne3;>)
		COPY ARRAY:C226(<>TbDiaposComF;Colonne4)
		
		  // Les textes
	: (PUMTraduc=5)  // textes
		COPY ARRAY:C226(<>TbTexteF;Colonne1)
		COPY ARRAY:C226(<>TbTexteA;Colonne2)
		COPY ARRAY:C226(<>TbTexteR;Colonne3)
		COPY ARRAY:C226(<>TbRefTexte;Colonne4)
		ARRAY LONGINT:C221(Colonne3N;Size of array:C274(Colonne1))
		PtTb1:=-><>TbTexteF
		PtTb2:=-><>TbTexteF
		PtTb3:=->Colonne3N
		PtTb4:=-><>TbTexteR
		PtTb5:=-><>TbRefTexte
		
End case 
VarNbLignes:=Size of array:C274(Colonne1)