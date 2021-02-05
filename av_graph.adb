with p_fenbase, forms, p_esiut, p_vue_graph, p_virus, Sequential_IO, Ada
 .Strings
 .Unbounded;
use p_fenbase, forms, p_esiut, p_vue_graph, p_virus, p_virus.p_mouvement_io,
 Ada.Strings.Unbounded, p_virus.p_piece_io, p_virus.p_joueur_io;

procedure av_graph is
  fprincipale, fpseudo, FenetreWin : TR_Fenetre;

  exitall  : Boolean := False;
  exitgame : Boolean := False;
  defi     : Integer;
  retour   : boolean := true;

-- Partie jeu
  numdef         : Positive range 1 .. 20;
  nombrecoup     : Integer;
  colorSet       : Boolean := False;
  colorSel       : T_Coul;
  Grille         : TV_Grille;
  Pieces         : TV_Pieces;
  dir            : T_Direction;
  f              : p_piece_io.File_Type;
  m              : p_mouvement_io.File_Type;
  s              : p_joueur_io.File_Type;
  pseudo, bouton : Unbounded_String;


  procedure basicButtonAcction
   (Bouton : in String; exitall : out Boolean; exitgame : out Boolean)
  is
  begin
    if Bouton = "Quitter" then
      CacherFenetre (fprincipale);
      exitall := True;

    elsif Bouton = "Rejouer" then
      montrerdefi(fprincipale);

      exitgame := True;
    elsif Bouton = "Stats" then
      --Stats
      null;
    end if;
  end basicButtonAcction;

begin -- av_graph
  InitialiserFenetres;
  initfenetrepseudo (fpseudo);
  MontrerFenetre (fpseudo);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");

  loop
    Bouton := To_Unbounded_String (Attendrebouton (fpseudo));
    exit when bouton /= "pseudo";
  end loop;

  if bouton = "quitter" then
    CacherFenetre (fpseudo);
  elsif bouton = "jouer" then

    pseudo := To_Unbounded_String (Consultercontenu (fpseudo, "pseudo"));
    CacherFenetre (fpseudo);
    InitFenetreprincipale (fprincipale, To_string (pseudo));

    masquerBtnDeplacements (fprincipale);
    MontrerFenetre (fprincipale);

    nombrecoup := 0;
    Open (f, In_File, "Defis.bin");
    Open (m, In_File, "historiqueMouvement.bin");
    Open (s, In_File, "stats.bin");
    while not exitall loop  -- loop principale jusqu'a quiter

      InitPartie (Grille, Pieces);
      afficherGrille (fprincipale, "Grille", Grille);


      --Choix du defi
      --cacherdefi (fprincipale);
      retour := false;
      cacherelem(fprincipale, "Rejouer");
      loop
        loop

          Bouton := To_Unbounded_String (Attendrebouton (fprincipale));
          basicButtonAcction(To_string(bouton), exitall, exitgame);
          exit when bouton /= "Stats" and bouton /="help" and not (To_string(Bouton)(1..1)="G");
        end loop;

        exit when exitall;

        if Bouton = "facile" then
          cacherdefi(fprincipale);
          AfficherDef(fprincipale, 1);
        elsif Bouton = "moyen" then
          cacherdefi(fprincipale);
          AfficherDef(fprincipale, 6);
        elsif Bouton = "difficile" then
          cacherdefi(fprincipale);
          AfficherDef(fprincipale, 11);
        elsif Bouton = "compliqué" then
          cacherdefi(fprincipale);
          AfficherDef(fprincipale, 16);

        end if;


        loop
          Bouton := To_Unbounded_String (Attendrebouton (fprincipale));
          basicButtonAcction(To_string(bouton), exitall, exitgame);
          exit when bouton /= "Stats" and not (To_string(Bouton)(1..1)="G");
        end loop;


        exit when exitall;

        if estDefi(To_String(Bouton)) then
          numdef := numDefi(To_String(Bouton));

          changertexte(fprincipale, "defi", "Defi n" & positive'image(numdef));
          cacherdef(fprincipale);
        end if;
        retour := (Bouton = "RetourDef");

        exit when not retour;
        CacherDef(fprincipale);
        montrerdefi(fprincipale);
    end loop;

      Configurer (f, numdef, Grille, Pieces);
      colorSet := False;
      exitgame := False;
      MontrerElem (fprincipale, "Rejouer");
      ChangerTempsMinuteur (fprincipale, "Chronometre", 200_000.0);
      while not exitgame and not exitall loop -- loop d'une game

        afficherGrille (fprincipale, "Grille", Grille);
        Bouton := To_Unbounded_String (Attendrebouton (fprincipale));

        CacherElem(fprincipale, "Messageerreur");
        -- if c'st un bouton
        basicButtonAcction (To_String (bouton), exitall, exitgame);

        -- if c'est un bouton de la grille
        if To_String (bouton) (1 .. 1) = "G" then

          colorSel := getCouleurCase (To_String (bouton), Grille);
          colorSet := True;
          if colorSel /= vide and colorSel /= blanc then
            afficherBtnDeplacements (fprincipale, colorSel, Grille);
          end if;

          -- if c'est un deplacement
        elsif To_String (bouton) (1 .. 1) = "D" and colorSet then

          dir := T_Direction'Value (To_String (bouton) (2 .. 3));
          if possible(Grille, colorSel, dir) then
            MajGrille (Grille, colorSel, dir);
          else
            MontrerElem(fprincipale, "Messageerreur");
          end if;
          masquerBtnDeplacements (fprincipale);
          colorSet   := False;
          nombrecoup := nombrecoup + 1;

          exit when Guerison (Grille);

        end if;

      end loop; -- loop principale d'une partie

      if Guerison (Grille) then
        --ChangerChronoenminuteur(fprincipale,"Chronometre");
        PauseTimer(fprincipale, "Chronometre");
        afficherGrille (fprincipale, "Grille", Grille);
        --SaveANewStat
         --(s, pseudo, ConsulterTimer (fprincipale, "Chronometre"), numdef,
          --nombrecoup);
        InitwinVictoire (FenetreWin);
        ecrire_ligne("Bravo, vous avez terminé ce niveau en :" & positive'image(nombrecoup) & " coups");
        changertexte(FenetreWin, "Bravo", "Bravo, victoire en : " & positive'image(nombrecoup) & " coups");
        MontrerFenetre (FenetreWin);
        if Attendrebouton (FenetreWin) = "ok" then
          cacherfenetre (FenetreWin);
        end if;
        --ChangerMinuteurEnChrono(fprincipale, "Chronometre");
        --ecrire_ligne ( (fprincipale, "Chronometre"));
        InitPartie(Grille, Pieces);
        afficherGrille (fprincipale, "Grille", Grille);
        ECRIRE_LIGNE ("Vous avez gagné");
        MontrerElem(fprincipale, "Rejouer");
        Bouton := To_Unbounded_String (Attendrebouton (fprincipale));
        basicButtonAcction(To_string(bouton), exitall, exitgame);
      end if;
    end loop; -- loop principale jusqu'a quiter
  end if;

end av_graph;
