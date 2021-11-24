//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/01/19, 10:42:38
  // ----------------------------------------------------
  // Paramètre $1= message HTML
  // ----------------------------------------------------
  // Méthode : ASAPcourrielsAttachement
  // Description
  // Ecrit les PJ en mime

  //C_ENTIER LONG($Salé;$FT)
  //$message:=$1
  //$FT:=Taille tableau(TbCourrielsCDPJ)
  //Boucle ($Salé;1;$FT)
  //$path:=Créer objet
  //$chemin:=TbCourrielsCDPJ{$Salé}
  //DOCUMENT VERS BLOB($chemin;$blob)
  //$path:=Chemin vers objet($chemin)
  //$type:=Sous chaîne($path.extension;2)

  //Au cas ou   // https://developer.mozilla.org/fr/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types
  //  // Liste des types MIME communs

  //: ($path.extension=".arc")
  //$typeMIME:="application/octet-stream"

  //: ($path.extension=".aac")
  //$typeMIME:="audio/aac"

  //: ($path.extension=".avi")
  //$typeMIME:="video/x-msvideo"

  //: ($path.extension=".azw")
  //$typeMIME:="application/vnd.amazon.ebook"

  //: ($path.extension=".bin")
  //$typeMIME:="application/octet-stream"

  //: ($path.extension=".bz")
  //$typeMIME:="application/x-bzip"

  //: ($path.extension=".bz2")
  //$typeMIME:="application/x-bzip2"

  //: ($path.extension=".css")
  //$typeMIME:="text/css"

  //: ($path.extension=".csv")
  //$typeMIME:="text/csv"

  //: ($path.extension=".doc")
  //$typeMIME:="application/msword"

  //: ($path.extension=".docx")
  //$typeMIME:="application/vnd.openxmlformats-officedocument.wordprocessingml.document"

  //: ($path.extension=".eot")
  //$typeMIME:="application/vnd.ms-fontobject"

  //: ($path.extension=".epub")
  //$typeMIME:="application/epub+zip"

  //: ($path.extension=".htm") | ($path.extension=".html")
  //Si ($path.extension=".htm")
  //$type:="html"
  //Fin de si 
  //$typeMIME:="text/html"

  //: ($path.extension=".ico")
  //$typeMIME:="image/x-icon"

  //: ($path.extension=".ics")
  //$typeMIME:="text/calendar"

  //: ($path.extension=".jar")
  //$typeMIME:="application/java-archive"

  //: ($path.extension=".jpg") | ($path.extension=".jpeg") | ($path.extension=".gif") | ($path.extension=".png")
  //Si ($path.extension=".jpg")
  //$type:="jpeg"
  //Fin de si 
  //$typeMIME:="image/"+$type;

  //: ($path.extension=".js")
  //$typeMIME:="application/javascript"

  //: ($path.extension=".json")
  //$typeMIME:="application/json"

  //: ($path.extension=".mid") | ($path.extension=".midi")
  //Si ($path.extension=".mid")
  //$type:="midi"
  //Fin de si 
  //$typeMIME:="audio/midi"

  //: ($path.extension=".mpeg")
  //$typeMIME:="video/mpeg"

  //: ($path.extension=".mpkg")
  //$typeMIME:="application/vnd.apple.installer+xml"

  //: ($path.extension=".odp")
  //$typeMIME:="application/vnd.oasis.opendocument.presentation"

  //: ($path.extension=".ods")
  //$typeMIME:="application/vnd.oasis.opendocument.spreadsheet"

  //: ($path.extension=".odt")
  //$typeMIME:="application/vnd.oasis.opendocument.text"

  //: ($path.extension=".oga")
  //$typeMIME:="audio/ogg"

  //: ($path.extension=".pgv")
  //$typeMIME:="video/ogg"

  //: ($path.extension=".ogx")
  //$typeMIME:="application/ogg"

  //: ($path.extension=".otf")
  //$typeMIME:="font/otf"

  //: ($path.extension=".pdf")
  //$typeMIME:="application/pdf"

  //: ($path.extension=".mpeg")
  //$typeMIME:="video/mpeg"

  //: ($path.extension=".ppt")
  //$typeMIME:="application/vnd.ms-powerpoint"

  //: ($path.extension=".pptx")
  //$typeMIME:="application/vnd.openxmlformats-officedocument.presentationml.presentation"

  //: ($path.extension=".rar")
  //$typeMIME:="application/x-rar-compressed"

  //: ($path.extension=".rtf")
  //$typeMIME:="application/rtf"

  //: ($path.extension=".sh")
  //$typeMIME:="application/x-sh"

  //: ($path.extension=".svg")
  //$typeMIME:="image/svg+xml"

  //: ($path.extension=".swf")
  //$typeMIME:="application/x-shockwave-flash"

  //: ($path.extension=".tar")
  //$typeMIME:="application/x-tar"

  //: ($path.extension=".tif") | ($path.extension=".tiff")
  //$typeMIME:="image/tiff"

  //: ($path.extension=".ts")
  //$typeMIME:="application/typescript"

  //: ($path.extension=".yyf")
  //$typeMIME:="font/ttf"

  //: ($path.extension=".vsd")
  //$typeMIME:="application/vnd.visio"

  //: ($path.extension=".wav")
  //$typeMIME:="audio/x-wav"

  //: ($path.extension=".weba")
  //$typeMIME:="audio/webm"

  //: ($path.extension=".webm")
  //$typeMIME:="video/webm"

  //: ($path.extension=".webp")
  //$typeMIME:="image/webp"

  //: ($path.extension=".woff")
  //$typeMIME:="font/woff"

  //: ($path.extension=".woff2")
  //$typeMIME:="font/woff2"

  //: ($path.extension=".xhtml")
  //$typeMIME:="application/xhtml+xml"

  //: ($path.extension=".xls")
  //$typeMIME:="application/vnd.ms-excel"

  //: ($path.extension=".xlsx")
  //$typeMIME:="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

  //: ($path.extension=".xml")
  //$typeMIME:="application/xml"

  //: ($path.extension=".xul")
  //$typeMIME:="application/vnd.mozilla.xul+xml"

  //: ($path.extension=".zip")
  //$typeMIME:="application/zip"

  //: ($path.extension=".7z")
  //$typeMIME:="application/x-7z-compressed"

  //Fin de cas 

  //MIME_ADD_PART ($message;->$blob;$path.name+$path.extension;$typeMIME;"utf-8";$type+Chaîne($Salé);"attachment")

  //Fin de boucle 
  //$0:=$message
