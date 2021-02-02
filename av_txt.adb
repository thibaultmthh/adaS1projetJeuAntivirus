with p_vuetxt, p_virus, p_esiut, sequential_io; use p_vuetxt, p_virus, p_virus.p_piece_io, p_esiut, P_virus.p_mouvement_io;


procedure av_txt is
  numdef : positive range 1..20;
  f                  : p_piece_io.File_Type;
  m                   : p_mouvement_io.file_type;
  Grille             : TV_Grille;
  Pieces             : TV_Pieces;
  annuler             : boolean;
  couleur            : T_coul;
  dir                : T_Direction;
  compteurMvmt       : natural;
  --nomJoueur          :String(1..25);
begin
  Open (f, In_File, "Defis.bin");
  Open (m, In_file, "historiqueMouvement.bin");
  --inputPlayerName(nomJoueur);

  loop
    -- #Initialisation et choix defi
    annuler := false;
    InitPartie(Grille, Pieces);
    InputDefi(numdef, annuler);
    ecrire_ligne(annuler);
    exit when annuler;

    compteurMvmt := 0;
    Configurer (f, numdef, Grille, Pieces);
    -- # fin init


    -- Boucle de partie
    loop

      NettoyerTerminal;
      AfficheGrille(Grille);


      InputCouleur(couleur,Pieces, annuler);
      exit when annuler;

      InputDirection(dir, couleur, Grille, annuler);
      if not annuler then -- Si on ne souhaite pas changer de couleur

        MajGrille(Grille, couleur, dir);
        compteurMvmt := compteurMvmt + 1;

      end if;
      exit when Guerison(Grille);
    end loop;
    -- Fin de boucle de partie

    if Guerison(grille) then
      NettoyerTerminal;
      AfficheGrille(Grille);
      ecrire_ligne("Felicitaion !! Vous avez réussi en " & image(compteurMvmt) & " coups !");
    end if;
    exit when not InputReplay;
    end loop;

end av_txt;
