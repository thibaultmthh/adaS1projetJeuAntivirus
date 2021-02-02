with p_esiut; use p_esiut;
with p_virus; use p_virus; use p_virus.p_piece_io;
with interface_CL; use interface_CL;
use p_virus.p_dir_io;
use p_virus.p_coul_io;


procedure testjeu is
  numdef : integer;
  Grille : TV_Grille;
  Pieces :TV_Pieces;
  f : p_piece_io.file_type;
  nombre : boolean:=false;
  rejouer : string(1..2);
  stop : boolean :=false;
  dir : T_direction;
  couleur : T_coul;
  compteur_mouvement:integer:=0;

begin

    open(f, in_file, "Defis.bin");
  while not stop loop
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
      loop
        ecrire_ligne("quel couleur veux- tu bouger?");
        lire(couleur);
        if couleur=blanc then
          ecrire_ligne("on ne peut pas bouger les blancs");
        elsif not couleurPresente(grille,couleur) then
          ecrire_ligne("tu essais de jouer avec une couleur pas en jeu essai une autre couleur");
        else
          exit;
        end if;
      end loop;
      loop
        ecrire_ligne("Vous voulez bouger dans quelle direction? Tapez (bg, hg, bd ou hd)");
        lire(dir);
        if possible(grille, couleur, dir) then
          ecrire_ligne("déplacement effectué");
          MajGrille(Grille, couleur, Dir);
          AfficheGrille(grille);
          compteur_mouvement := compteur_mouvement + 1;
          exit;
        else
          ecrire("vous ne pouvez pas bouger vers ");
          ecrire(dir);ecrire(" ! ");a_la_ligne;
          ecrire_ligne(" ressayez une autre direction");
          AfficheGrille(grille);
        end if;
      end loop;
      exit when guerison(grille);
    end loop;

    loop
      if Guerison(grille) then
        ecrire_ligne("TU AS GAGNE en" & image(compteur_mouvement) &" GG !! veux-tu rejouer? (y ou n)");
        lire(rejouer);
        if rejouer="y" then
          ecrire_ligne("c'est reparti");
          exit;
        elsif rejouer="n" then
          ecrire_ligne("j'espère que tu reviendra bientôt");
          stop:=true;
          exit;
        else
          ecrire_ligne("écris 'y' si tu veux rejouer ou 'n' si tu ne veux pas");
        end if;
      end if;
    end loop;
  end loop;
end testjeu;
