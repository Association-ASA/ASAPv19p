//%attributes = {"publishedWeb":true}
  //  DiaMAJDéclareVar 6.0 du 27/8/98
  //   sert à placer les déclaration des variables crées hors standard

DiaWebCreerTbDescriptionPhotos 
ZAcces:=True:C214
ZAjout:=True:C214
ZModif:=True:C214
Zimprimer:=True:C214
ZSupprime:=True:C214

C_DATE:C307(<>DateRef)
<>DateRef:=!2009-06-03!
QUERY:C277([DiaData:45];[DiaData:45]XNom:1="Aide plein écran";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="Aid")
If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XNom:1:="Aide plein écran"
	[DiaData:45]XType:5:="Aid"
End if 
<>AidePleinEcran:=[DiaData:45]XBool:9

ARRAY TEXT:C222(PUMAlinea;0)  // menu local de réglementation européenne

QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]TypeListe:8="A")
ORDER BY:C49([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]Ordre:10;>)
ARRAY TEXT:C222(PUMMotifDGAL;0)
SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;PUMMotifDGAL)
COPY ARRAY:C226(PUMMotifDGAL;<>TbMotifRetrait)

PermRetrait:=False:C215  // booléen qui privilégie le nom des retraits par rapport aux lésions
JAiGrandit:=False:C215  // boléen de zoom sur une photo
LesFlechesSontLà:=False:C215  // boléen de présence de fleches sur une photo
LesOrientationsSontLà:=False:C215  // boléen de présence d'orientation sur une photo
LesDiagnosesSontLà:=False:C215  // boléen de présence des diagnoses sur une photo
  //BlancFormulaireEnreg
C_LONGINT:C283($salé;$SFT;$FT;$Fumé;PermPage)
PermPageSD:=0  // page de saisie d'une diapositive
ARRAY TEXT:C222(<>PUMTriplette;0)
ARRAY TEXT:C222(<>PUMLésion;0)
ARRAY TEXT:C222(<>PUMOrgane;0)
ARRAY TEXT:C222(<>PUMEspèce;0)
ARRAY TEXT:C222(<>PUMStatut;0)
ARRAY TEXT:C222(<>PUMStatut1;0)
ARRAY TEXT:C222(<>PUMStatut2;0)
ARRAY TEXT:C222(<>PUMStatut3;0)
ARRAY TEXT:C222(<>PUMStatut4;0)
ARRAY TEXT:C222(<>PUMStatut5;0)
ARRAY TEXT:C222(<>PUMStatut6;0)
VarTypeR1:=""
VarTypeR2:=""
VarTypeR3:=""
VarTypeR4:=""
VarTypeR5:=""
VarTypeR6:=""

VarNS1:=""
VarNS2:=""
VarNS3:=""
VarNS4:=""
VarNS5:=""
VarNS6:=""

VarImageR1:=PermImageGris
VarImageR2:=PermImageGris
VarImageR3:=PermImageGris
VarImageR4:=PermImageGris
VarImageR5:=PermImageGris
VarImageR6:=PermImageGris

VarSel1:=0
VarSel2:=0
VarSel3:=0
VarSel4:=0
VarSel5:=0
VarSel6:=0

VarId1:=0
VarId2:=0
VarId3:=0
VarId4:=0
VarId5:=0
VarId6:=0
LIST TO ARRAY:C288("Espèce";<>PUMEspèce)
LIST TO ARRAY:C288("Organe";<>PUMOrgane)
LIST TO ARRAY:C288("Statut";<>PUMStatut)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut1)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut2)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut3)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut4)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut5)
COPY ARRAY:C226(<>PUMStatut;<>PUMStatut6)

PermPage:=1
VarNbreDélai:=0
VarCDWeb:=""

MESSAGES ON:C181