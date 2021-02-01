with p_esiut; use p_esiut;
with p_virus; use p_virus; use p_virus.p_piece_io;
with interface_CL; use interface_CL;
<<<<<<< HEAD
use p_virus.p_dir_io;
use p_virus.p_coul_io;
=======
with Ada.Text_IO;
with Interfaces.C;

>>>>>>> 072ce9c340beb2cb83f220cd602400c29793aa28
procedure testjeu is
  numdef : integer;
  Grille : TV_Grille;
  Pieces :TV_Pieces;
  f : p_piece_io.file_type;
  nombre : boolean:=false;
  rejouer : string(1..2);
  stop : boolean :=false;
<<<<<<< HEAD
  possibilite : boolean;
  dir : T_direction;
  couleur : T_coul;
  compteur_mouvement:integer:=0;
=======

-----------------
  package C renames Interfaces.C;
   use type C.int;

   function system (command : C.char_array) return C.int
     with Import, Convention => C;

   command : aliased constant C.char_array :=
     C.To_C ("mv README.md README.txt");

   result : C.int;
-------------------------
>>>>>>> 072ce9c340beb2cb83f220cd602400c29793aa28
begin
  ----
    result := system ("firefox https://www.youtube.com/watch?v=dQw4w9WgXcQ");
  ---
    open(f, in_file, "Defis.bin");
    InitPartie(Grille, Pieces);

    while not nombre loop
      ecrire_ligne("entrez un numéro de défi entre 1 et 20:");
      lire(numdef);
      if numdef<1 or numdef>20 then
        ecrire_ligne("mettre un nombre entre 1 et 20");
      else
        nombre:=true;
      end if;
    end loop;

    Configurer(f, numdef, Grille, Pieces);
    AfficheGrille(grille);

    for coul in T_coul'range loop
      if coul/=vide then
        pospiece(grille,coul);
      end if;
    end loop;

    loop
      ecrire_ligne("Vous voulez bouger dans quelle direction? Tapez (bg, hg, bd ou hd)");
      lire(dir);
      ecrire_ligne("quel couleur?");
      lire(couleur);
      if couleur=blanc then
        ecrire_ligne("on ne peut pas bouger les blancs");
      end if;
      if possible(grille, couleur, dir) then
        MajGrille(Grille, couleur, Dir);
        AfficheGrille(grille);
        compteur_mouvement := compteur_mouvement + 1;
      else
        ecrire("vous ne pouvez pas bouer vers ");
        ecrire(dir);ecrire(" ! ");a_la_ligne;
        ecrire(" ressayez une autre direction");
        AfficheGrille(grille);
      end if;
      exit when guerison(grille);
    end loop;
  
    if Guerison(grille) then
      ecrire_ligne("TU AS GAGNE GG !! veux-tu rejouer? (y ou n)");
      lire(rejouer);
      if rejouer="y" then
        ecrire_ligne("c'est reparti");
      elsif rejouer="n" then
        ecrire_ligne("j'espère que tu reviendra bientôt");
        stop:=true;
      else
        ecrire_ligne("écris 'y' si tu veux rejouer ou 'n' si tu ne veux pas");
      end if;
    end if;
end testjeu;
