with p_esiut; use p_esiut;
with p_virus; use p_virus;
use p_virus.p_piece_io;
with p_vuetxt; use p_vuetxt;
use p_virus.p_dir_io;
use p_virus.p_coul_io;

procedure testjeu is
  numdef             : Integer;
  Grille             : TV_Grille;
  Pieces             : TV_Pieces;
  f                  : p_piece_io.File_Type;
  nombre             : Boolean := False;
  rejouer            : Character;
  stop               : Boolean := False;
  dir                : T_Direction;
  couleur            : T_Coul;
  compteur_mouvement : Integer := 0;

begin

  Open (f, In_File, "Defis.bin");
  while not stop loop
    nombre             := False;
    compteur_mouvement := 0;
    InitPartie (Grille, Pieces);

    while not nombre loop
      ECRIRE_LIGNE ("entrez un numéro de défi entre 1 et 20:");
      LIRE (numdef);
      if numdef < 1 or numdef > 20 then
        ECRIRE_LIGNE ("mettre un nombre entre 1 et 20");
      else
        nombre := True;
      end if;
    end loop;

    Configurer (f, numdef, Grille, Pieces);
    AfficheGrille (Grille);

    for coul in T_Coul'Range loop
      if coul /= vide then
        PosPiece (Grille, coul);
      end if;
    end loop;

    loop
      loop
        ECRIRE_LIGNE ("quel couleur veux- tu bouger?");
        LIRE (couleur);
        if couleur = blanc then
          ECRIRE_LIGNE ("on ne peut pas bouger les blancs");
        elsif not couleurPresente (Grille, couleur) then
          ECRIRE_LIGNE
           ("tu essais de jouer avec une couleur pas en jeu essai une autre couleur");
        else
          exit;
        end if;
      end loop;
      loop
        ECRIRE_LIGNE
         ("Vous voulez bouger dans quelle direction? Tapez (bg, hg, bd ou hd)");
        LIRE (dir);
        if Possible (Grille, couleur, dir) then
          ECRIRE_LIGNE ("déplacement effectué");
          MajGrille (Grille, couleur, dir);
          AfficheGrille (Grille);
          compteur_mouvement := compteur_mouvement + 1;
          exit;
        else
          ECRIRE ("vous ne pouvez pas bouger vers ");
          ECRIRE (dir);
          ECRIRE (" ! ");
          A_LA_LIGNE;
          ECRIRE_LIGNE (" ressayez une autre direction");
          AfficheGrille (Grille);
        end if;
      end loop;
      exit when Guerison (Grille);
    end loop;

    loop
      if Guerison (Grille) then
        ECRIRE_LIGNE
         ("TU AS GAGNE en" & IMAGE (compteur_mouvement) &
          " GG !! veux-tu rejouer? (y ou n)");
        LIRE (rejouer);
        if rejouer = 'y' then
          ECRIRE_LIGNE ("c'est reparti");
          exit;
        elsif rejouer = 'n' then
          ECRIRE_LIGNE ("j'espère que tu reviendra bientôt");
          stop := True;
          exit;
        else
          ECRIRE_LIGNE
           ("écris 'y' si tu veux rejouer ou 'n' si tu ne veux pas");
        end if;
      end if;
    end loop;
  end loop;
end testjeu;
