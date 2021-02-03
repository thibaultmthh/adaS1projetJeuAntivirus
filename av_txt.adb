with p_vuetxt, p_virus, p_esiut, Sequential_IO;
use p_vuetxt, p_virus, p_virus.p_piece_io, p_esiut, p_virus.p_mouvement_io;

procedure av_txt is
  numdef       : Positive range 1 .. 20;
  f            : p_piece_io.File_Type;
  m            : p_mouvement_io.file_type;
  Grille       : TV_Grille;
  Pieces       : TV_Pieces;
  annuler      : Boolean;
  couleur      : T_Coul;
  dir          : T_Direction;
  compteurMvmt : Natural;
  modeCouleur  : boolean;

  --nomJoueur          :String(1..25);
begin
  Open (f, In_File, "Defis.bin");
  Open (m, In_file, "historiqueMouvement.bin");
  --inputPlayerName(nomJoueur);


  InputModeCouleur(modeCouleur);

  loop
    -- #Initialisation et choix defi
    annuler := False;
    InitPartie (Grille, Pieces);
    InputDefi (numdef, annuler);
    ECRIRE_LIGNE (annuler);
    exit when annuler;

    compteurMvmt := 0;
    Configurer (f, numdef, Grille, Pieces);
    -- # fin init

    -- Boucle de partie
    loop

      NettoyerTerminal;
      AfficheGrille (Grille, modeCouleur);

      InputCouleur (couleur, Pieces, annuler);
      exit when annuler;

      InputDirection (dir, couleur, Grille, annuler);
      if not annuler then -- Si on ne souhaite pas changer de couleur

        MajGrille (Grille, couleur, dir);
        compteurMvmt := compteurMvmt + 1;

      end if;
      exit when Guerison (Grille);
    end loop;
    -- Fin de boucle de partie

    if Guerison (Grille) then
      NettoyerTerminal;
      AfficheGrille (Grille, modeCouleur);
      ECRIRE_LIGNE
       ("Felicitaion !! Vous avez réussi en " & IMAGE (compteurMvmt) &
        " coups !");
    end if;
    exit when not InputReplay;
  end loop;

end av_txt;
