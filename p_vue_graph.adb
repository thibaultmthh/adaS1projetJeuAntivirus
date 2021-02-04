package body p_vue_graph is

  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string) is

    function min (a,b : in integer) return integer is

      begin
        ecrire_ligne(a);
        ecrire_ligne(b);
        if a < b then

          return a;
        else
          return b;
        end if;
    end min;

    FLARGEUR            : constant integer := 500;
    FHAUTEUR            : constant integer := 600;

    -- Texte superieur et horloge
    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;
    TEXTEHAUTEUR        : constant integer := 50;

    -- Bouton inferieur (Rejouer, stats, quitter)
    NBBOUTON            : constant integer := 3;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTON+1) ) / NBBOUTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR            : constant integer := 30;
    yboutoninf          : constant integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);

    -- Bouton de déplacement
    HAUTEURBOUTONDEP    : constant integer := 85;
    LARGEURBOUTONDEP    : constant integer := 200;
    XBOUTONDEP          : constant integer := (FLARGEUR / 2) - (LARGEURBOUTONDEP / 2);
    YBOUTONDEP          : constant integer := FHAUTEUR - ((2 * FESPACEMENT) + BHAUTEUR + HAUTEURBOUTONDEP);

    -- Grille
    --espace disponible pour la grille
    XDispo              : constant integer := FHAUTEUR - ( FESPACEMENT * 5 ) - TEXTEHAUTEUR - HAUTEURBOUTONDEP - BHAUTEUR;
    YDispo              : constant integer := FLARGEUR - 2 * FESPACEMENT;
    yGrille             : constant integer := FESPACEMENT * 2 + TEXTEHAUTEUR;
    TAILLEGRILLE        : constant integer := min(XDispo,YDispo);


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

    Ajoutertexte(fenetre,"defi","numéro de défi", FESPACEMENT * 3 + TEXTELARGEUR * 2, FESPACEMENT, TEXTELARGEUR,
      TEXTEHAUTEUR);
    ChangerAlignementTexte (fenetre, "NumeroDefi", FL_ALIGN_CENTER);

    ChangerStyleTexte(fenetre, "NomJoueur", FL_BOLD_Style);
    ChangerTailleTexte(fenetre, "NomJoueur", 500);

    AjouterTexte(fenetre, "NumeroDefi", "Pas de defi selectionne",
      XBOUTONDEP, YBOUTONDEP, 200, TEXTEHAUTEUR);

    AjouterBouton
     (fenetre, "Stats", "STATS", FESPACEMENT, yboutoninf, BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Rejouer", "Jouer", FESPACEMENT * 2 + BLARGEUR, yboutoninf,
      BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Quitter", "QUITTER", FESPACEMENT * 3 + BLARGEUR * 2,
      yboutoninf, BLARGEUR, BHAUTEUR);

    ajouterGrille(fenetre, "Grille", (FLARGEUR / 2) - (TAILLEGRILLE/2) , yGrille, TAILLEGRILLE);

    ajouterBtnDeplacement (fenetre, "", XBOUTONDEP, YBOUTONDEP, XBOUTONDEP+LARGEURBOUTONDEP, YBOUTONDEP+HAUTEURBOUTONDEP, FESPACEMENT);


    FinFenetre (fenetre);
  end InitFenetreprincipale;


  procedure ajouterGrille(
  fenetre : in out TR_Fenetre;
  NomElement : in String;
  x,y : in natural;
  largeur: in positive) is

      tailleBouton : constant positive := largeur  / NBELEMGRILLE;
      posX, posY : natural;
      stnumligne : String(1..2);
      intnumcol  : positive;

      nombouton : String(1..NomElement'length+2);

    begin


      ecrire_ligne(tailleBouton);
      for i in T_col'Range loop
        for j in T_lig'range loop

          intnumcol   := T_Col'Pos(i) - 64; --64 corresodnant à la valeur de A on considère a comme le point 1
          stnumligne  := positive'image(j);
          nombouton   := NomElement& i & stnumligne(2..2);

          posX        := x + (intnumcol - 1) * tailleBouton;
          posY        := y + (j - 1) * tailleBouton;




          --ecrire_ligne(nombouton);
          AjouterBouton(fenetre,nombouton , "",posX, posY, tailleBouton, tailleBouton  );
          if ((j + intnumcol) mod 2) = 0 then
            ChangerCouleurFond(fenetre, nombouton, FL_RIGHT_BCOL);
          else
            ChangerCouleurFond(fenetre, nombouton, FL_BOTTOM_BCOL);
          end if;

        end loop;

      end loop;
  end ajouterGrille;

  procedure afficherGrille(fenetre : in out TR_Fenetre; NomGrille : in String; Grille : in TV_Grille) is
    COULEUR_BOUTON : FL_PD_COL := FL_TOP_BCOL;
    stnumligne : String(1..2);
    nombouton : String(1..NomGrille'length+2);
    intnumcol : integer;

  begin
    for x in T_lig loop
      for y in T_Col loop
        intnumcol   := T_Col'Pos(y) - 64;
        stnumligne  := positive'image(x);
        nombouton   := NomGrille& y & stnumligne(2..2);

        case Grille(x,y) is
            when rouge =>
                COULEUR_BOUTON := FL_RED;
            when orange =>
                COULEUR_BOUTON := FL_DARKORANGE;
            when rose =>
                COULEUR_BOUTON := FL_DEEPPINK;
            when violet =>
                COULEUR_BOUTON := FL_DARKVIOLET;
            when jaune =>
                COULEUR_BOUTON := FL_YELLOW;
            when blanc =>
                COULEUR_BOUTON := FL_WHITE;
            when turquoise =>
                COULEUR_BOUTON := FL_CYAN;
            when marron =>
                COULEUR_BOUTON := FL_DARKTOMATO;
            when bleu =>
                COULEUR_BOUTON := FL_BLUE;
            when vert =>
                COULEUR_BOUTON := FL_GREEN;
            when others =>
              if ((x + intnumcol) mod 2 = 0) then
                COULEUR_BOUTON := FL_RIGHT_BCOL;
              else
                COULEUR_BOUTON := FL_BOTTOM_BCOL;
              end if;
        end case;

        if not (COULEUR_BOUTON = FL_TOP_BCOL) then
          ChangerCouleurFond(fenetre, nombouton, COULEUR_BOUTON);
        end if;
      end loop;
    end loop;


  end afficherGrille;

  procedure initfenetrepseudo(fenetre: out TR_Fenetre) is
    FLARGEUR            : constant integer := 600;
    FHAUTEUR            : constant integer := 600;


  begin
    fenetre:=DebutFenetre("fpseudo", Flargeur, Fhauteur);
    ChangerCouleurFond(fenetre, "fond",  COULEURPRINCIPALE);

    AjouterChamp(fenetre,"pseudo","Votre pseudo","", 225 ,400,150,30);
    AjouterBouton(fenetre,"jouer","JOUER", 225 ,450,70,30);
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
    x, y, x2, y2, padding : in     Natural)
  is


    yButton : constant Positive := (y2 - y - padding) / 2;
    xButton : constant Positive := (x2 - x - padding) / 2;
    actX    : Positive;
    actY    : Positive          := y;

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

  procedure afficherBtnDeplacements(fenetre : in out TR_Fenetre; coul:in T_coul; grille: in TV_Grille) is
  begin

    for y in 1 .. 2 loop
      for x in 1 .. 2 loop
        if Possible(Grille, coul,btnList (y, x)) then
          MontrerElem(fenetre, "D" & T_Direction'Image (btnList (y, x)));
        else
          CacherElem(fenetre, "D" & T_Direction'Image (btnList (y, x)));
        end if;
      end loop;
    end loop;
  end afficherBtnDeplacements;

    procedure masquerBtnDeplacements(fenetre : in out TR_Fenetre) is
    begin
    for y in 1 .. 2 loop
      for x in 1 .. 2 loop
          CacherElem(fenetre, "D" & T_Direction'Image (btnList (y, x)));
      end loop;
    end loop;
    end masquerBtnDeplacements;

  function getCouleurCase(nomCase: String; grille : TV_Grille) return T_coul is

  begin
  ecrire_ligne("coucou");
  ecrire_ligne(nomCase(7..7));
  ecrire_ligne(nomCase(8..8));
  return grille(T_lig'value(nomCase(8..8)) ,  nomCase(7) );
  end getCouleurCase;

  --procedure choixdefi(numdefi: out integer) is 
  ---begin
  --  loop 
  --    AjouterBouton
  --end choixdefi;


end p_vue_graph;
