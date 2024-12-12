### Je suis un super README.md qui n'est pas rédigé

# 2 - Boucing ENSEA logo 

## 2-1) Contôleur HDMI
Les signaux h_res et v_res correspondent à la résolution horizontale et verticale de l'image.

h_sync permet la synchronisation horizontale. 
Les signaux h_fp et h_bp permette de déplacer le faisceau à gauche.


v_sync permet la synchronisation verticale.
Les signaux v_fp et v_bp permettent de déplacer le faisceau en haut à gauche. 

Après avoir fait le programme pour lla synchronisation, nous avons fait le test bench puis on passe à la simulation pour vérifier que tous nos signaux sont correcte.
on fait le ca  lcul : 32 + 61 + 58 + 18 - 1 = 168 On retrouve bien le total lorsque qu'on fait la simulation sur modèle sim.

Pour le signal de synchronisation il est à 0 jusqu'à h_count = 89 cel   correspond à h_res (=32) + h_fp (=58) -1. Il respasse bien à 1 au momoent du "back porch" donc à h_count = 151.
