#!/bin/bash
# indique au système que l'argument qui suit est le programme utilisé pour exécuter ce fichier.
# En cas général les "#" servent à faire des commentaires comme ici
echo "Decompression de fichier open office..."
unzip presentation.odp
echo "Exécution du script PHP..."
php transform.php
 
exit 0