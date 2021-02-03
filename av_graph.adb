with p_fenbase, forms, p_esiut, p_vue_graph, p_virus, Sequential_IO;
use p_fenbase, forms, p_esiut, p_vue_graph, p_virus, p_virus.p_mouvement_io,
 p_virus.p_piece_io;

procedure av_graph is
  fprincipale, fpseudo : TR_Fenetre;

  continue : Character;
  pseudo   : String (1 .. 3);

-- Partie jeu
  numdef   : Positive range 1 .. 20;
  colorSet : Boolean := False;
  Grille   : TV_Grille;
  Pieces   : TV_Pieces;
  dir      : T_Direction;
  f        : p_piece_io.File_Type;
  m        : p_mouvement_io.File_Type;

begin -- av_graph
  InitialiserFenetres;
  initfenetrepseudo (fpseudo);
  MontrerFenetre (fpseudo);
  ChangerTempsMinuteur (fprincipale, "Chronometre", 200_000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");

  declare
    Bouton : String := (Attendrebouton (fpseudo));
  begin
    if Bouton = "quitter" then
      CacherFenetre (fpseudo);
    elsif Bouton = "jouer" then
      pseudo := Consultercontenu (fpseudo, "pseudo");
      CacherFenetre (fpseudo);
      InitFenetreprincipale (fprincipale, pseudo);
      MontrerFenetre (fprincipale);

      Open (f, In_File, "Defis.bin");
      Open (m, In_File, "historiqueMouvement.bin");
      InitPartie (Grille, Pieces);
      numdef := 1;
      Configurer (f, numdef, Grille, Pieces);

      loop
        afficherGrille (fprincipale, "grille", Grille);
        afficherBtnDeplacements(fprincipale, violet, Grille );
        colorSet := True;
        declare
          Bouton : String := (Attendrebouton (fprincipale));
        begin
          -- if c'st un bouton
          if Bouton = "Quitter" then
            CacherFenetre (fprincipale);
            exit;
          elsif Bouton = "Rejouer" then
            ECRIRE_LIGNE ("rejouer");
          elsif Bouton = "Stats" then
            ECRIRE_LIGNE ("stats");

            -- if c'est une couleur
          elsif Bouton (1 .. 1) = "G" then
            ECRIRE ("Couleur");

            colorSet := True;

            -- if c'est un deplacement
          elsif Bouton (1 .. 1) = "D" and colorSet then
            ECRIRE ("Deplacement");
            dir := T_Direction'Value (Bouton (2 .. 3));
            MajGrille (Grille, violet, dir);

          end if;

          ECRIRE_LIGNE (Bouton);
        end;
      end loop;
    end if;
  end;

  ecrire_ligne
   (ConsulterTimer
     (fprincipale,
      "Chronometre"));        --nom de la fenêtreNomElement : inString      )
  ECRIRE_LIGNE ("fin");

end av_graph;
