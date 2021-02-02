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
  cancel             : Boolean;

begin

  Open (f, In_File, "Defis.bin");
  while not stop loop
    nombre             := False;
    compteur_mouvement := 0;
    InitPartie (Grille, Pieces);

    InputDefi (numdef, cancel);

    Configurer (f, numdef, Grille, Pieces);
    AfficheGrille (Grille);

    for coul in T_Coul'Range loop
      if coul /= vide then
        PosPiece (Grille, coul);
      end if;
    end loop;

    loop
      InputCouleur (couleur, Pieces, cancel);
      InputDirection (dir, couleur, Grille, cancel);
      MajGrille (Grille, couleur, dir);
      AfficheGrille (Grille);
      compteur_mouvement := compteur_mouvement + 1;
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
