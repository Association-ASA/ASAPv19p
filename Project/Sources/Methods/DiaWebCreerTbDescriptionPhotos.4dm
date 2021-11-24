//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 23/01/16, 13:07:06
// ----------------------------------------------------
// Méthode : WebCreerTbDescriptionPhotos
// Description
// Permet de créer en mémoire au lancement
// le tableau de correspondance entre le n° de la diapos
// et les élements nécessaires à son afficage sur le Web
// ----------------------------------------------------

ARRAY LONGINT:C221(<>TbNumDia; 0)
ARRAY TEXT:C222(<>TbOrgane; 0)
ARRAY TEXT:C222(<>TbEspece; 0)
ARRAY TEXT:C222(<>TbNomLes; 0)
ARRAY BOOLEAN:C223(<>TbOrientationH; 0)  // Modifié par : cgm (24/02/2019)
ARRAY TEXT:C222(<>TbMotif; 0)
ALL RECORDS:C47([Diapositives:40])
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; <>TbNumDia; \
[Diapositives:40]Organe:2; <>TbOrgane; \
[Diapositives:40]Espece:3; <>TbEspece; \
[Diapositives:40]NomLesion:4; <>TbNomLes; \
[Diapositives:40]OrientationPhotoH:30; <>TbOrientationH; \
[Diapositives:40]MotifSaisieDGAL:23; <>TbMotif)
