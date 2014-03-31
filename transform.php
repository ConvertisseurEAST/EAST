<?php

	$xslDoc = new DOMDocument();
	//Import du Fichier de transformation 
	$xslDoc->load( 'convertor.xsl' );

	$xmlDoc = new DOMDocument();
	//Import du Fichier à transormer 
	$xmlDoc->load( 'content.xml' );

	$proc = new XSLTProcessor();
	$proc->importStylesheet( $xslDoc );
	$xmlEast = $proc->transformToXML( $xmlDoc );
	$head = '<?xml version="1.0" encoding="ISO-8859-1"?>
			<?xml-stylesheet type="text/xsl" href="EAST.xsl"?><EAST transition="burst" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xsi:noNamespaceSchemaLocation="EAST.xsd">
			<PREFERENCES>
				<AFFICHAGE>
					<POLICE_TEXTE font="Comic Sans MS"/>
				</AFFICHAGE>
			</PREFERENCES>
			<LOGO_GAUCHE fichier="media/image1.png" hauteur_SVG="100" largeur_SVG="100"/>';

	$filename = 'east.xml';

	if (!$file = fopen( $filename, 'w' )) {
		echo "Impossible d'ouvrir le fichier ($filename)";
		exit;
	} else {
		// Ecrivons quelque chose dans notre fichier.
		if (fwrite($file, $xmlEast."</EAST>") === FALSE) {
			echo "Impossible d'écrire dans le fichier ($filename)";
			exit;
		}

		fclose($file);

		$contenu = file_get_contents($filename);
		$explode = explode("\n",$contenu);
		unset($explode[0]);
		//unset($explode[0]);
		$nouveau_contenu = implode("\n",$explode);


		if (!$file = fopen( $filename, 'w' )) {
		echo "Impossible d'ouvrir le fichier ($filename)";
		exit;
		} else {
			// Ecrivons quelque chose dans notre fichier.
			if (fwrite($file, $head.$nouveau_contenu) === FALSE) {
				echo "Impossible d'écrire dans le fichier ($filename)";
				exit;
			}

		}

		echo "L'écriture de ($somecontent) dans le fichier ($filename) a réussi";
	}


?>
