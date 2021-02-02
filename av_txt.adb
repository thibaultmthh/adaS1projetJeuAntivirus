with p_vuetxt, p_virus, p_esiut; use p_vuetxt, p_virus, p_virus.p_piece_io, p_esiut;


procedure av_txt is
  numdef : positive range 1..20;
  f                  : p_piece_io.File_Type;
  Grille             : TV_Grille;
  Pieces             : TV_Pieces;
  annuler             : boolean;
  couleur            : T_coul;
  dir                : T_Direction;
  compteurMvmt       : natural;
begin
  Open (f, In_File, "Defis.bin");
  loop
    -- #Initialisation et choix defi
    InitPartie(Grille, Pieces);
    InputDefi(numdef, annuler);
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
      ecrire_ligne("Felicitaion !! Vous avez réussi en " & image(compteurMvmt) & " coups !");
    end if;
    exit when not InputReplay;
    end loop;

end av_txt;
