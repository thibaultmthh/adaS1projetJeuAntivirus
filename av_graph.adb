with p_fenbase, forms, p_esiut, p_vue_graph, p_virus, Sequential_IO, Ada
 .Strings
 .Unbounded;
use p_fenbase, forms, p_esiut, p_vue_graph, p_virus, p_virus.p_mouvement_io,
 Ada.Strings.Unbounded, p_virus.p_piece_io;

procedure av_graph is
  fprincipale, fpseudo : TR_Fenetre;

  exitall  : Boolean := False;
  exitgame : Boolean := False;
  defi     : Integer;

-- Partie jeu
  numdef         : Positive range 1 .. 20;
  colorSet       : Boolean := False;
  colorSel       : T_Coul;
  Grille         : TV_Grille;
  Pieces         : TV_Pieces;
  dir            : T_Direction;
  f              : p_piece_io.File_Type;
  m              : p_mouvement_io.File_Type;
  pseudo, bouton : Unbounded_String;

  procedure basicButtonAcction
   (Button : in String; exitall : out Boolean; exitgame : out Boolean)
  is
  begin
    if bouton = "Quitter" then
      CacherFenetre (fprincipale);
      exitall := True;

    elsif bouton = "Rejouer" then
      changertexte (fprincipale, "Rejouer", "Rejouer");
      exitgame := True;
    elsif bouton = "Stats" then
      ECRIRE_LIGNE ("stats");
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

    Open (f, In_File, "Defis.bin");
    Open (m, In_File, "historiqueMouvement.bin");
    while not exitall loop  -- loop principale jusqu'a quiter
      InitPartie (Grille, Pieces);
      ChangerTempsMinuteur (fprincipale, "Chronometre", 200_000.0);

      numdef := 1;
      Configurer (f, numdef, Grille, Pieces);
      colorSet := False;
      loop -- loop d'une game
        afficherGrille (fprincipale, "Grille", Grille);
        declare
          Bouton : String := (Attendrebouton (fprincipale));
        begin
          -- if c'st un bouton
          basicButtonAcction (Button, exitall, exitgame);
          -- if c'est une couleur
          if Bouton (1 .. 1) = "G" then
            ECRIRE ("Couleur");

            colorSel := getCouleurCase (Bouton, Grille);
            colorSet := True;
            if colorSel /= vide and colorSel /= blanc then
              afficherBtnDeplacements (fprincipale, colorSel, Grille);
            end if;

            -- if c'est un deplacement
          elsif Bouton (1 .. 1) = "D" and colorSet then
            ECRIRE ("Deplacement");
            dir := T_Direction'Value (Bouton (2 .. 3));
            MajGrille (Grille, colorSel, dir);
            masquerBtnDeplacements (fprincipale);
            colorSet := False;
            if Guerison (Grille) then
              exit;
            end if;

          end if;

          ECRIRE_LIGNE (Bouton);
        end;
      end loop; -- loop principale d'une partie

    end loop; -- loop principale jusqu'a quiter
  end if;

  ecrire_ligne (ConsulterTimer (fprincipale, "Chronometre"));

end av_graph;
