package body p_vue_graph is
  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string) is
    FLARGEUR            : constant integer := 800;
    FHAUTEUR            : constant integer := 800;
    FESPACEMENT         : constant integer := 10; --padding
    COULEURPRINCIPALE   : constant FL_PD_COL := FL_TOP_BCOL;

    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;

    TEXTEHAUTEUR        : constant integer := 50;

    NBBOUTTON           : constant integer := 3;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTTON+1) ) / NBBOUTTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR            : constant integer := 30;
    ybouttoninf         : constant integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);


  begin

    fenetre:=DebutFenetre("Virus",FLARGEUR,FHAUTEUR);
    ChangerCouleurFond(fenetre, "fond", COULEURPRINCIPALE);

    AjouterTexte(fenetre, "NomJoueur", "joueur : " & joueur, FESPACEMENT, FESPACEMENT, TEXTELARGEUR, TEXTEHAUTEUR);
    ChangerAlignementTexte(fenetre,"NomJoueur",FL_ALIGN_CENTER);

    AjouterChrono(fenetre, "Chronometre", "",FESPACEMENT*2 + TEXTELARGEUR, FESPACEMENT, TEXTELARGEUR, TEXTEHAUTEUR);
    ChangerAlignementTexte(fenetre,"Chronometre",FL_ALIGN_CENTER);
    ChangerCouleurFond(fenetre, "Chronometre", COULEURPRINCIPALE);
    ChangerStyleTexte(fenetre, "Chronometre", FL_BOLD_Style);
    ChangerCouleurTexte(fenetre, "Chronometre", FL_RED);


    AjouterTexte(fenetre, "NumeroDefi", "Pas de defi selectionne", FESPACEMENT*3 + TEXTELARGEUR*2, FESPACEMENT, TEXTELARGEUR, TEXTEHAUTEUR);
    ChangerAlignementTexte(fenetre,"NumeroDefi",FL_ALIGN_CENTER);


    ChangerStyleTexte(fenetre, "NomJoueur", FL_BOLD_Style);
    ChangerTailleTexte(fenetre, "NomJoueur", 500);


    AjouterBouton(fenetre, "Stats", "STATS", FESPACEMENT, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Rejouer", "REJOUER", FESPACEMENT * 2 + BLARGEUR, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Quitter", "QUITTER",  FESPACEMENT * 3 + BLARGEUR * 2, ybouttoninf, BLARGEUR,BHAUTEUR);

    --ajouterGrille(fenetre, "Grille", 0, 0, 300 );

    FinFenetre(fenetre);
  end InitFenetreprincipale;

  procedure ajouterGrille(
  fenetre : in out TR_Fenetre;
  NomElement : in String;
  x,y : in natural;
  largeur: in positive) is

      tailleBoutton : constant positive := largeur  / TAILLEGRILLE;
      posX, posY : natural;
      numligne : String(1..2);
      nombouton : String(1..NomElement'length+3);

    begin
      ecrire_ligne(tailleBoutton);
      for i in T_col'Range loop
        for j in T_lig'range loop

          posX        := x + (T_Col'Pos(i) - 65) * tailleBoutton; -- -(1 + 64) avec 64 corresodnant à la valeur de A
          posY        := y + (j - 1) * tailleBoutton;
          numligne    := positive'image(j);
          nombouton   := NomElement& i & numligne(1);

          ecrire_ligne(nombouton);
          AjouterBoutonRond(fenetre,nombouton , "",posX, posY, tailleBoutton  );

        end loop;

      end loop;
  end ajouterGrille;

end p_vue_graph;
