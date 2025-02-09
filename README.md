
# 2 - Boucing ENSEA logo 

## 2-1) Contôleur HDMI

### 2-1-1) Écriture du composant 

Les signaux h_res et v_res correspondent à la résolution horizontale et verticale de l'image.

h_sync permet la synchronisation horizontale. 
Les signaux h_fp et h_bp permette de déplacer le faisceau en haut à gauche.


v_sync permet la synchronisation verticale.
Les signaux v_fp et v_bp permettent de déplacer le faisceau en haut à gauche. 

Après avoir fait le programme pour la synchronisation, nous avons fait le test bench puis on passe à la simulation sur modelsim pour vérifier que tous nos signaux sont correcte.
on fait le ca  lcul : 32 + 61 + 58 + 18 - 1 = 168 On retrouve bien le total lorsque qu'on fait la simulation sur modelesim.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/tamerelepeliquanc.png" width="600" /></p> 

Pour le signal de synchronisation il est à 0 jusqu'à h_count = 89 cel   correspond à h_res (=32) + h_fp (=58) -1. Il respasse bien à 1 au momoent du "back porch" donc à h_count = 151.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/tamerelepeliquan3.png" width="600" /></p> 

Pour V_count, on compte bien jusqu'à 67 car v_res est à 24. v_count est incrémenté de 1 à chaque fois que h_count a terminé de compter et quand v_count arrive au max alors il recommence à compter.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/tamerelepeliquan4.png" width="600" /></p> 

### 2-1-2) Implémentation sur le FPGA

Dans cette partie nous avons pour but de tester la sortie HDMI du FPGA. Pour cela nous avons relié la sortie HDMI du FPGA à l'ordinateur pour pouvoir envoyer une image et la visualiser grâce à VLC.

Pour cela, nous avons connecter les signaux **o_x_counter** et **o_y_counter** aux canaux de couleurs vert et rouge pour obtenir l'image si dessous.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/image_vert_et_rouge.png" width="600" /></p> 

## 2-2 Bouncing ENSEA logo

Après avoir tester la sortie HDMI du FPGA nous avons récupérer un fichier contenant les valeurs en niveau de gris des pixels pour pouvoir afficher le logo de l'ENSEA. Nous avons d'abord fait en sorte de l'afficher en haut à gauche de l'écran avant de le faire bouger.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/Affichage_logo_ensea_statique.png" width="600" /></p> 

Après avoir réussis à l'afficher correctement nous avons commencer à le faire bouger pour comprendre comment cela fonctionne. 
Nous avons donc commencer par le faire bouger de gauche à droite comme ci-dessous.

<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/Logo_bouge_en_ligne.gif" width="600" /></p> 

Une fois le logo correctement mis en mouvement nous avons tenter de le faire rebondir contre l'écran comme demandé dans le sujet mais nous avons eu des soucis. En effet le cadre entourant le logo se déplace dans toutes les directions et rebnondis correctement contre les bords, mais le logo bouge lui même dans le cadre. Nous n'avons donc pas une image fixe du logo comme on peut le voir dans la vidéo si-dessous.


<p align="center"><img src="https://github.com/JolanTho/2425_ESE_FPGA_WEIDLE_THOMASSET/blob/main/Pictures/Bouncing_logo.gif" width="600" /></p> 
