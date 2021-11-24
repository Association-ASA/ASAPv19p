//%attributes = {"publishedWeb":true}
  // AgranditRatatinePhoto
C_LONGINT:C283(BouZoom)
GET MOUSE:C468(PositionSourisX;PositionSourisY;$Souris)
$G:=PG
$H:=PH
$D:=PD
$B:=PB
$Ha:=$B-$H
$La:=$D-$G
$HQ:=$Ha/4
$LQ:=$La/4
If (JAiGrandit)
	JAiGrandit:=False:C215
	OBJECT MOVE:C664(VarImage;PG;PH;PD;PB;*)
	OBJECT SET VISIBLE:C603(*;"B@";True:C214)
	OBJECT MOVE:C664(BouZoom;PG;PH;PD;PB;*)
	DiaReplaceLesFleches 
Else 
	  // remise à zéro pour éviter les zoom successifs
	  // faut-il monter des zones qui seraient cachées ??
	Case of 
		: (LesFlechesSontLà)
			DiaReplaceLesFleches 
			LesFlechesSontLà:=False:C215
			OBJECT SET TITLE:C194(BouPlaceF;"Placer les explications")
			
			  //: (LesOrientationsSontLà)
			  //ReplaceLesOrientations
			  //LesOrientationsSontLà:=Faux
			  //OBJET FIXER TITRE(BouPlaceO;"Placer les orientations")
			
			  //: (LesDiagnosesSontLà)
			  //ReplaceLesFlechesDiagnose
			  //LesDiagnosesSontLà:=Faux
			  //OBJET FIXER TITRE(BouPlaceD;"Placer la diagnose")
	End case 
	Case of 
		: (PositionSourisY<=$HQ)
			$DB:=0
			$EntX:=Int:C8(PositionSourisX*4/$La)
			$DH:=(Num:C11($EntX=3)*$La)+(Num:C11($EntX#3)*Num:C11(PositionSourisX>$LQ)*2*(PositionSourisX-$LQ))
			
		: (PositionSourisY<=(3*$HQ))
			$EntY:=Int:C8(PositionSourisY*4/$Ha)
			$DB:=(Num:C11($EntY=3)*$Ha)+(Num:C11($EntY#3)*Num:C11(PositionSourisY>$HQ)*2*(PositionSourisY-$HQ))
			$EntX:=Int:C8(PositionSourisX*4/$La)
			$DH:=(Num:C11($EntX=3)*$La)+(Num:C11($EntX#3)*Num:C11(PositionSourisX>$LQ)*2*(PositionSourisX-$LQ))
			
		Else 
			$DB:=$Ha
			$EntX:=Int:C8(PositionSourisX*4/$La)
			$DH:=(Num:C11($EntX=3)*$La)+(Num:C11($EntX#3)*Num:C11(PositionSourisX>$LQ)*2*(PositionSourisX-$LQ))
	End case 
	OBJECT MOVE:C664(VarImage;-$DH+DepH;-$DB;$La;$Ha)
	OBJECT MOVE:C664(BouZoom;-$DH+DepH;-$DB;$La;$Ha)
	JAiGrandit:=True:C214
	
End if 