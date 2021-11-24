//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  //  // ----------------------------------------------------
  //  // Nom utilisateur (OS) : Association QualiSoft
  //  // Date et heure : 21/11/17, 17:59:53
  //  // Date et heure : 03/06/18, 12:03:04
  //  // ----------------------------------------------------
  //  // Paramètres
  //  // $1 = Pointer to Forms array
  //  // $2 : ID number of the table (0 in case of project table)
  //  // ----------------------------------------------------
  //  // Méthode : PHP_Export_Forms
  //  // Description
  //  //  

  //C_REAL($pas;$Progression)
  //C_LONGINT($IDbarbier;$IDbarbier2;$PageNum)
  //C_TIME($PhpCode)
  //ARRAY TEXT($TbScreenShot;0x0000)
  //ARRAY TEXT($tab_formObjects;0x0000)
  //ARRAY POINTER($tPtr_var;0x0000)
  //ARRAY LONGINT($listPages;0x0000)
  //C_OBJECT($e)

  //C_POINTER($1;$Tbforms;$pt)
  //C_LONGINT($2;$tableNumber)

  //C_OBJECT($WP)
  //$WP:=WP New

  //$Txt_CurrentMethodError:=Method called on error
  //ON ERR CALL("BASE_noERROR")
  //OK:=1
  //$File:=""
  //$Tbforms:=$1
  //$tableNumber:=$2
  //$Project:=($2=0)  // It is a project form if $tableNumber = 0

  //SORT ARRAY($TbForms->;>)
  //$tableNumberListSize:=Size of array($TbForms->)
  //$Progression:=0
  //$pas:=1/($tableNumberListSize+1)

  //C_OBJECT($param)
  //$param:=New object("title";"Database: "+Storage.QS_TBX_SHARED_DATA.QS_TBX_DBName;"icon";"btn_phpword.png";"type";0)
  //$param:=QST_progress_start ($param)
  //$startTime:=Current time

  //For ($NbForm;1;$tableNumberListSize)  // For each Form

  //  //If (Not(Progress Stopped ($IDbarbier)))

  //$formName:=$TbForms->{$NbForm}
  //If ($tableNumber=0)
  //$title:=$formName
  //$outName:="Project Form"
  //$pictName:="Project form - "+$formName
  //Else 
  //$title:="["+Table name($tableNumber)+"]"+$formName
  //$outName:="Table Form - "+Table name($tableNumber)
  //$pictName:=Table name($tableNumber)+" - "+$formName
  //End if 

  //$currentT:=Current time
  //$delta:=$currentT-$startTime
  //$timeNeededEvaluated:=String(Time(($tableNumberListSize-$NbForm)*($delta/$NbForm));HH MM SS)
  //$info:=$timeNeededEvaluated+" estimated time to finish - "+$title
  //$Progression:=$Progression+$pas
  //  //Progress SET PROGRESS ($IDbarbier;$Progression;$info;True)

  //$param.value:=$Progression
  //$param.content:=$info
  //CALL FORM(Storage.windows.progress;"progressBar_update";$param)
  //  // ****

  //$PhpCode:=PHPWord_CreateNewFile 
  //$script_t:=PHPWord_DefineStyleTable 
  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)

  //  // -- For each form -> FORM LOAD is inside FORM_Get_ObjectsAndMethods
  //FE_getObjectsAndMethods ($tableNumber;$formName;->$tab_formObjects;->$tPtr_var;->$listPages)

  //FE_formLoad ($tableNumber;$formName)

  //FORM GET OBJECTS($tab_formObjects;$tPtr_var;$listPages;Form all pages+Form inherited)

  //If ($Project)
  //PAGE SETUP($formName)
  //Else 
  //$pt:=Table($tableNumber)
  //PAGE SETUP($pt->;$formName)
  //End if 

  //  // Get form properties and write them into the php file

  //If (Not($FormProject))
  //C_POINTER($pt)
  //$pt:=Table($table)
  //FORM GET PROPERTIES($pt->;$formName;$width;$height;$nbPages;$widthFixe;$heightFixe;$title)

  //Else 

  //Case of 
  //: (Storage.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode)
  //FORM GET PROPERTIES($formName;$width;$height;$nbPages;$widthFixe;$heightFixe;$title)
  //Else 
  //C_OBJECT($MyObject)
  //$MyObject:=New object
  //$MyObject.formName:=$formName
  //$MyObject.tableNum:=$table
  //$MyObject:=FE_getFormAttributes ($MyObject)
  //$width:=Num($MyObject.largeur)
  //$height:=Num($MyObject.hauteur)
  //$NbPages:=Num($MyObject.nbpages)
  //$widthFixe:=$MyObject.largeurfixe
  //$heightFixe:=$MyObject.hauteurfixe
  //$title:=$MyObject.titre

  //End case 

  //End if 

  //If ($title="")
  //$title:="{No form title defined}"
  //End if 

  //GET PRINT OPTION(Orientation option;$N)


  //  // Form Event
  //ARRAY LONGINT($tabEvenement;0x0000)
  //OBJECT GET EVENTS(*;"";$tabEvenement)

  //$script_t:=PHPWord_AddTitle ("1";"Form Events")
  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //If (Size of array($tabEvenement)>0)

  //For ($page;1;Size of array($tabEvenement))
  //$newEvent:=Konstant_getName (2;$tabEvenement{$page})
  //$script_t:=$script_t+PHPWord_AddText ($newEvent)
  //End for 
  //Else 
  //$script_t:=$script_t+PHPWord_AddText ("No event defined for '"+$formName+"'.")
  //End if 
  //$script_t:=$script_t+PHPWord_AddTextBreak ("2")
  //$script_t:=$script_t+PHPWord_AddTitle ("1";"Page Screenshot")
  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)  // UTF-8 conversion

  //$nbPages:=Max($listPages)  // -- All pages, included Page 0
  //C_OBJECT($param2)
  //$param2:=New object("pageNum";0;"table";$tableNumber;"project";$project;"formName";$formName)
  //For ($PageNum;0;$nbPages)
  //$param2.pageNum:=$PageNum
  //PHPWord_FormScreenShot ($PhpCode;$param2;->$TbScreenShot)
  //End for 

  //  // Work now on object sorted by page and name
  //MULTI SORT ARRAY($listPages;>;$tab_formObjects;>;$tPtr_var;>)
  //$script_t:=PHPWord_AddPageBreak 
  //$script_t:=$script_t+PHPWord_AddTitle ("1";"From widget description")
  //$script_t:=$script_t+PHPWord_AddTextBreak ("2")
  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)  // UTF-8 conversion

  //  // Include also data for graphviz relations
  //$name:=Str_GetTableOrProjectForm ($tableNumber)+$formName

  //  // *** Form Widget information
  //For ($currentPage;1;Size of array($listPages))

  //  // *** Form Widget properties
  //$mycoll:=FE_GetObjectDetails ($tab_formObjects{$currentPage})
  //$script_t:=PHPWord_AddTitle ("2";"Form Widget: "+$tab_formObjects{$currentPage})
  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //$script_t:=$script_t+PHPWord_AddText ("Page : "+String($listPages{$currentPage}))
  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //$script_t:=$script_t+PHPWord_AddTable 
  //$script_t:=$script_t+PHPWord_AddRow 
  //$script_t:=$script_t+PHPWord_AddCell ("3000";"Properties")
  //$script_t:=$script_t+PHPWord_AddCell ("2500";"Value")

  //For each ($e;$mycoll)
  //$script_t:=$script_t+PHPWord_AddRow 
  //$e.properties:=Replace string($e.properties;"/";"-")
  //$script_t:=$script_t+PHPWord_AddCell ("3000";$e.properties)
  //$script_t:=$script_t+PHPWord_AddCell ("2500";$e.value)
  //End for each 

  //$script_t:=$script_t+PHPWord_AddTextBreak ("2")
  //$script_t:=$script_t+PHPWord_AddPageBreak 
  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)  // UTF-8 conversion
  //End for 

  //  // At this step, we don't need anymore to have to form in memory
  //FORM UNLOAD

  //  //  // **** Add the screenshot of obejct linked --> will be use later
  //  //$chemin:=Storage.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Forms"+Folder separator
  //  //$Extension:=".jpg"
  //  //C_OBJECT($param)
  //  //$param:=New object
  //  //OB SET ARRAY($param;"objects";$tab_formObjects)
  //  //OB SET ARRAY($param;"pages";$listPages)
  //  //$param.dotContent:=""
  //  //$param.name:=$name
  //  //$param.table:=$tableNumber
  //  //FORM_createDOTfile (->$param;->$tPtr_var)
  //  //$dot_Content:=$param.dotContent
  //  //UTIL_CheckFileName (->$name)
  //  //$File:=$chemin+$Name
  //  //TEXT TO DOCUMENT($File;$DOT_Content)
  //  //$vt_path:=Convert path system to POSIX($File)
  //  //EXE_Graphviz (->$vt_path;->$Extension)
  //  //READ PICTURE FILE($vt_path+$Extension;$ScreenShot;*)
  //  //PICTURE PROPERTIES($ScreenShot;$largeurImg;$hauteurImg)
  //  //$Width:=500
  //  //$ratio:=$hauteurImg/Num($Width)
  //  //If ($ratio>1)
  //  //$hauteurImg:=(Round($hauteurImg/$ratio;0))
  //  //$largeurImg:=(Round($largeurImg/$ratio;0))
  //  //End if 
  //  //  // Integration of the picture created into the word document
  //  //$script_t:=PHPWord_AddSection ("landscape")
  //  //$script_t:=$script_t+PHPWord_AddTitle ("1";"Relation between form widgets")
  //  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //  //  //$script_t:=$script_t+"$section->addImage('"+Convert path system to POSIX($file+$Extension)+"', array('width'=>"+String($largeurImg)+", 'height'=>"+String($hauteurImg)+", 'align'=>'center'));\r\r"
  //  //$script_t:=$script_t+"$section->addImage('"+Convert path system to POSIX($file+$Extension)+"', array('width'=>"+String($largeurImg)+", 'height'=>"+String($hauteurImg)+", 'align'=>'center'));\r\r"
  //  //  // $script_t:=$script_t+PHPWord_AddPageBreak 
  //  //$script_t:=$script_t+PHPWord_AddSection ("portrait")
  //  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)  // UTF-8 conversion


  //  // **** Add Methods used by widgets & Formular ***
  //ARRAY TEXT($tabChemins;0x0000)
  //C_TEXT($code)
  //C_LONGINT($NumChemin)

  //If ($tableNumber=0)
  //METHOD GET PATHS FORM($tabChemins;$formName;*)
  //Else 
  //$pt:=Table($tableNumber)
  //METHOD GET PATHS FORM($pt->;$tabChemins;$formName;*)
  //End if 

  //If (Size of array($tabChemins)>0)
  //$script_t:=PHPWord_AddTitle ("1";"Code used in Form and Form widgets")
  //$script_t:=$script_t+PHPWord_AddTextBreak ("1")
  //FILE_SendPacket_UTF8 ($PhpCode;$script_t)

  //For ($NumChemin;1;Size of array($tabChemins))
  //$code:=$tabChemins{$NumChemin}
  //$n:=PHPWord_ExportMethod (->$code)
  //FILE_SendPacket_UTF8 ($PhpCode;$code)
  //End for 
  //End if 

  //  // *******************
  //PHPWord_ExportFile ($PhpCode;$outName;" - "+$formName+".")

  //  // We don't need anymore the dot command file
  //If (Test path name($File)=Is a document)
  //DELETE DOCUMENT($File)
  //End if 

  //  //Else 

  //  //$stop:=True
  //  //$NbForm:=$tableNumberListSize+1
  //  //CLOSE DOCUMENT($PhpCode)

  //  //End if 
  //End for 

  //$param.value:=1
  //$param.content:="Cleaning."
  //CALL FORM(Storage.windows.progress;"progressBar_update";$param)
  //PROCESS_sleep (10)


  //$cheminSortie:=Get 4D folder(Current resources folder)

  //ARRAY TEXT($tbChemin;0x0000)
  //DOCUMENT LIST($cheminSortie;$tbChemin;Absolute path)

  //For ($currentPage;1;Size of array($tbChemin))
  //DELETE DOCUMENT($tbChemin{$currentPage})
  //End for 

  //For ($currentPage;1;Size of array($TbScreenShot))
  //If (Test path name($TbScreenShot{$currentPage})=Is a document)
  //DELETE DOCUMENT($TbScreenShot{$currentPage})
  //End if 
  //End for 

  //KILL WORKER("QST_Progress")
  //ON ERR CALL($Txt_CurrentMethodError)