package body p_vue_graph is

  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string) is
    FLARGEUR            : constant integer := 500;
    FHAUTEUR            : constant integer := 500;

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

    AjouterChrono
     (fenetre, "Chronometre", "", FESPACEMENT * 2 + TEXTELARGEUR, FESPACEMENT,
      TEXTELARGEUR, TEXTEHAUTEUR);
    ChangerAlignementTexte (fenetre, "Chronometre", FL_ALIGN_CENTER);
    ChangerCouleurFond (fenetre, "Chronometre", COULEURPRINCIPALE);
    ChangerStyleTexte (fenetre, "Chronometre", FL_BOLD_Style);
    ChangerCouleurTexte (fenetre, "Chronometre", FL_DARKVIOLET);

    AjouterTexte
     (fenetre, "NumeroDefi", "Pas de defi selectionne",
      FESPACEMENT * 3 + TEXTELARGEUR * 2, FESPACEMENT, TEXTELARGEUR,
      TEXTEHAUTEUR);
    ChangerAlignementTexte (fenetre, "NumeroDefi", FL_ALIGN_CENTER);

    ChangerStyleTexte(fenetre, "NomJoueur", FL_BOLD_Style);
    ChangerTailleTexte(fenetre, "NomJoueur", 500);

    AjouterBouton
     (fenetre, "Stats", "STATS", FESPACEMENT, ybouttoninf, BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Rejouer", "REJOUER", FESPACEMENT * 2 + BLARGEUR, ybouttoninf,
      BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Quitter", "QUITTER", FESPACEMENT * 3 + BLARGEUR * 2,
      ybouttoninf, BLARGEUR, BHAUTEUR);

    ajouterGrille(fenetre, "grille", 0,0, 200);

    ajouterBtnDeplacement (fenetre, "", 150, 350, 350, 435);


    FinFenetre (fenetre);
  end InitFenetreprincipale;

  procedure ajouterGrille(
  fenetre : in out TR_Fenetre;
  NomElement : in String;
  x,y : in natural;
  largeur: in positive) is

      tailleBoutton : constant positive := largeur  / TAILLEGRILLE;
      posX, posY : natural;
      stnumligne : String(1..2);
      intnumcol  : positive;

      nombouton : String(1..NomElement'length+2);

    begin
      ecrire_ligne(tailleBoutton);
      for i in T_col'Range loop
        for j in T_lig'range loop

          intnumcol   := T_Col'Pos(i) - 64; --64 corresodnant à la valeur de A on considère a comme le point 1
          stnumligne  := positive'image(j);
          nombouton   := NomElement& i & stnumligne(2..2);

          posX        := x + (intnumcol - 1) * tailleBoutton;
          posY        := y + (j - 1) * tailleBoutton;




          --ecrire_ligne(nombouton);
          AjouterBouton(fenetre,nombouton , "",posX, posY, tailleBoutton, tailleBoutton  );
          if ((intnumcol mod 2) = 0 and (j mod 2) = 0) or ((intnumcol mod 2) = 1 and (j mod 2) = 1) then
            ChangerCouleurFond(fenetre, nombouton, FL_RIGHT_BCOL);
          else
            ChangerCouleurFond(fenetre, nombouton, FL_BOTTOM_BCOL);
          end if;

        end loop;

      end loop;
  end ajouterGrille;

  procedure afficherGrille(fenetre : in out TR_Fenetre; NomGrille : in String; Grille : in TV_Grille) is
    COULEUR_BOUTTON : FL_PD_COL := FL_TOP_BCOL;
    stnumligne : String(1..2);
    nombouton : String(1..NomGrille'length+2);

  begin
    for x in T_lig loop
      for y in T_Col loop

        stnumligne  := positive'image(x);
        nombouton   := NomGrille& y & stnumligne(2..2);

        case Grille(x,y) is
            when rouge =>
                COULEUR_BOUTTON := FL_RED;
            when orange =>
                COULEUR_BOUTTON := FL_DARKORANGE;
            when rose =>
                COULEUR_BOUTTON := FL_DEEPPINK;
            when violet =>
                COULEUR_BOUTTON := FL_DARKVIOLET;
            when jaune =>
                COULEUR_BOUTTON := FL_YELLOW;
            when blanc =>
                COULEUR_BOUTTON := FL_WHITE;
            when turquoise =>
                COULEUR_BOUTTON := FL_CYAN;
            when marron =>
                COULEUR_BOUTTON := FL_DARKTOMATO;
            when bleu =>
                COULEUR_BOUTTON := FL_BLUE;
            when vert =>
                COULEUR_BOUTTON := FL_GREEN;
            when others =>
                COULEUR_BOUTTON := FL_TOP_BCOL;
        end case;
        ecrire_ligne(T_Coul'image(Grille(x,y)));
        ecrire_ligne(FL_PD_COL'image(COULEUR_BOUTTON));
        if not (COULEUR_BOUTTON = FL_TOP_BCOL) then
          ChangerCouleurFond(fenetre, nombouton, COULEUR_BOUTTON);
        end if;
      end loop;
    end loop;


  end afficherGrille;

  procedure initfenetrepseudo(fenetre: out TR_Fenetre) is
    FLARGEUR            : constant integer := 600;
    FHAUTEUR            : constant integer := 600;

    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;

    TEXTEHAUTEUR        : constant integer := 30;

    NBBOUTTON           : constant integer := 2;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTTON+1) ) / NBBOUTTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR    : constant Integer := 30;
    ybouttoninf : constant Integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);

  begin
    fenetre:=DebutFenetre("pseudo", Flargeur, Fhauteur);
    ChangerCouleurFond(fenetre, "fond",  COULEURPRINCIPALE);

    AjouterChamp(fenetre,"pseudo","Votre pseudo","ton", 300 - 75 ,400,150,30);
    AjouterBouton(fenetre,"jouer","JOUER", 300 - 75 ,450,70,30);
    AjouterBouton(fenetre,"quitter","Quitter",305,450,70,30);

    AjouterTexte( fenetre, "Bienvenue" , "Bienvenue au Jeu ANTI VIRUS!!" , 200, 20, 200, 50);
    ChangerCouleurTexte (fenetre, "Bienvenue", FL_WHITE);
    changercouleurfond(fenetre, "Bienvenue", FL_black);
    AjouterImage ( fenetre , "imageAntiVirus" , "antivirusimage.xpm" ,"" , 200 , 150, 200 , 200 );
    AjouterImage ( fenetre , "imageTousAntiCovid" , "anticovid.xpm" , "" , 0 , 407 , 107,231) ;

    FinFenetre (fenetre);
  end initfenetrepseudo;



  procedure ajouterBtnDeplacement
   (fenetre      : in out TR_Fenetre; NomElement : in String;
    x, y, x2, y2 : in     Natural)
  is

    type Tv_btn is array (1 .. 2, 1 .. 2) of T_Direction;

    yButton : constant Positive := (y2 - y) / 2;
    xButton : constant Positive := (x2 - x) / 2;
    actX    : Positive;
    actY    : Positive          := y;
    btnList : Tv_btn            := ((hg, hd), (bg, bd));
  begin

    for y in 1 .. 2 loop
      actX := x;
      for x in 1 .. 2 loop
        ECRIRE_LIGNE (T_Direction'Image (btnList (y, x)));
        AjouterBouton
         (fenetre, "D"&T_Direction'Image (btnList (y, x)),
          T_Direction'Image (btnList (y, x)), actX, actY, xButton, yButton);

        ECRIRE (actX);
        ECRIRE (actY);
        ECRIRE (xButton);
        ECRIRE_LIGNE (yButton);
        actX := actX + xButton + 10;

      end loop;
      actY := actY + yButton + 10;

    end loop;

  end ajouterBtnDeplacement;

end p_vue_graph;
