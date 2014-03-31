<?php

   $xslDoc = new DOMDocument();
   //Import du Fichier de transformation 
   $xslDoc->load("convertor.xsl");

   $xmlDoc = new DOMDocument();
   //Import du Fichier à transormer 
   $xmlDoc->load("content.xml");

   $proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);
   echo $proc->transformToXML($xmlDoc);

$document = new DomDocument();


?>

