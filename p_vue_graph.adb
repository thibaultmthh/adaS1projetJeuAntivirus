package body p_vue_graph is

  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string) is

    function min (a,b : in integer) return integer is

      begin

        if a < b then

          return a;
        else
          return b;
        end if;
    end min;

    FLARGEUR            : constant integer := 500;
    FHAUTEUR            : constant integer := 600;
    defi:integer;

    -- Texte superieur et horloge
    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;
    TEXTEHAUTEUR        : constant integer := 50;

    -- Bouton inferieur (Rejouer, stats, quitter)
    NBBOUTON            : constant integer := 3;
    TAILLEBHELP         : constant integer  := 20;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTON+1) - (TAILLEBHELP+FESPACEMENT) ) / NBBOUTON;


    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR            : constant integer := 30;
    yboutoninf          : constant integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR  );

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

    LARGEURBOUTONDEFS    : constant integer := FLARGEUR - 2*FESPACEMENT;
    LARGEURBOUTONRETDEF  : constant integer := (LARGEURBOUTONDEFS - 5*FESPACEMENT) / 6;


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
    ChangerAlignementTexte (fenetre, "defi", FL_ALIGN_CENTER);

    ChangerStyleTexte(fenetre, "NomJoueur", FL_BOLD_Style);
    ChangerTailleTexte(fenetre, "NomJoueur", 500);

    --AjouterTexte(fenetre, "NumeroDefi", "Pas de defi selectionne",
      --XBOUTONDEP, YBOUTONDEP, 200, TEXTEHAUTEUR);
    AjouterBouton(fenetre,"help","?", FESPACEMENT, yboutoninf, TAILLEBHELP, BHAUTEUR);

    AjouterBouton
     (fenetre, "Stats", "STATS",TAILLEBHELP+FESPACEMENT + FESPACEMENT, yboutoninf, BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Rejouer", "Rejouer", TAILLEBHELP+FESPACEMENT+FESPACEMENT * 2 + BLARGEUR, yboutoninf,
      BLARGEUR, BHAUTEUR);
    CacherElem (fenetre, "Rejouer");
    AjouterBouton
     (fenetre, "Quitter", "QUITTER", TAILLEBHELP+FESPACEMENT+FESPACEMENT * 3 + BLARGEUR * 2,
      yboutoninf, BLARGEUR, BHAUTEUR);

    ajouterGrille(fenetre, "Grille", (FLARGEUR / 2) - (TAILLEGRILLE/2) , yGrille, TAILLEGRILLE);

    ajouterBtnDeplacement (fenetre, "", XBOUTONDEP, YBOUTONDEP, XBOUTONDEP+LARGEURBOUTONDEP, YBOUTONDEP+HAUTEURBOUTONDEP, FESPACEMENT);
    choixdefi(fenetre,defi);

    AjouterBoutonChoixDef(fenetre, FESPACEMENT, YBOUTONDEP, HAUTEURBOUTONDEP, LARGEURBOUTONDEFS );
    AjouterBouton(fenetre, "RetourDef", "Retour", 6*FESPACEMENT  + 5*LARGEURBOUTONRETDEF,YBOUTONDEP, LARGEURBOUTONRETDEF, HAUTEURBOUTONDEP);
    CacherElem(fenetre, "RetourDef");

    ajoutertexte(fenetre, "Messageerreur", "Ce mouvement est impossible, essayez de nouveau", FESPACEMENT, YBOUTONDEP, FLARGEUR - 2* FESPACEMENT, HAUTEURBOUTONDEP);
    ChangerAlignementTexte(fenetre, "Messageerreur", FL_ALIGN_CENTER);
    ChangerCouleurTexte(fenetre, "Messageerreur", FL_RED);
    CacherElem(fenetre, "Messageerreur");

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

  --procedure afficheStats ( s : in out p_joueur_io.file_type) is
  --  elem : TR_joueur;
   -- date : TR_date;
  --  begin
   --   Open (s, in_file, "stats.bin");

--reset( s , in_file);
  --    read( s , elem);
   --   if end_of_file(s) then
   --     ecrire(" pas de dossier joueur sur stats encore");
 --     else
   --     while not end_of_file(s) loop
   --       date := elem.date;
   --       ecrire(elem.nomjoueur); ecrire("possede : "); ecrire(elem.points); ecrire(" points"); a_la_ligne;
    --      ecrire(" , à la date : "); ecrire( date.jour );ecrire(" / "); ecrire( date.mois );ecrire(" / ");ecrire( date.an );
    --      read( s , elem);
  --      end loop;
  --    end if;
   --   Close (s);

--end affichestats;
  procedure initfenetrehelp(fenetre: out TR_fenetre) is
    FLARGEUR  : constant integer:=450;
    FHAUTEUR  : constant integer:=300;
    Newline   : constant character:=character'val(10);
  begin
    fenetre:=DebutFenetre("fhelp", Flargeur, Fhauteur);
    ecrire_ligne("Bonjour, Mme. Lejeune");
    ecrire_ligne("ça mérite une bonne note non? ");
    ajoutertexte(fenetre, "help", "Regles du jeu:", 170, 10, 86,20);
    ChangerAlignementTexte(fenetre,"help",FL_ALIGN_CENTER);
    ChangerStyleTexte(fenetre,"help", FL_BOLD_Style);

    ajoutertexte(fenetre, "regles", "-Le but est de gagner, mais de bien gagner" & Newline &
      "le but est d'ammener la pieces rouge dans l'angle en haut a droite" & Newline &
      "- choississez un niveau de defi puis un numero entre 1 et 5 qui"
      & Newline & " correspondra à votre numero de defi" & Newline &
      "- une grille de jeu s'affiche: " & Newline &
      "- pour jouer cliquer sur la couleur que vous voulez deplacer puis"
      & Newline & " en bas sur la direction ou vous voulez allez" & Newline &
      "bg= bas gauche, hg=haut gauche, hd= haut droit, bd = bas droit" & Newline &
      " - le bouton stats vous montre vos stats de partie" & Newline &
      "le bouton rejouer vous fais revenir au choix du defi pour recommencer" & Newline &
      "le bouton quitter vous fait quitter la partie", 5, 35, 440, 235);

    AjouterBouton(fenetre,"ok", "J'ai lu", 170, 270, 55, 20);

    finfenetre(fenetre);
  end initfenetrehelp;

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
          AjouterBouton
           (fenetre, "D"&T_Direction'Image (btnList (y, x)),
            T_Direction'Image (btnList (y, x)), actX, actY, xButton, yButton);


          actX := actX + xButton + 10;

        end loop;
        actY := actY + yButton + 10;

      end loop;

    end ajouterBtnDeplacement;

  procedure afficherBtnDeplacements(fenetre : in out TR_Fenetre; coul:in T_coul; grille: in TV_Grille) is
    begin

      for y in 1 .. 2 loop
        for x in 1 .. 2 loop
          --if Possible(Grille, coul,btnList (y, x)) then
            MontrerElem(fenetre, "D" & T_Direction'Image (btnList (y, x)));
          --else
            --CacherElem(fenetre, "D" & T_Direction'Image (btnList (y, x)));
          --end if;
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

    return grille(T_lig'value(nomCase(8..8)) ,  nomCase(7) );
    end getCouleurCase;

  procedure choixdefi(fenetre: in out TR_fenetre; numdefi: out integer)is
    hauteur    : constant integer := 42;
    largeur    : constant integer := 90;
    espace    : constant  integer :=10;
    x:constant integer:=55;
    y: constant integer := 510;
  begin
    ajoutertexte(fenetre,"choixdefi","cliquer sur un bouton de difficulte:",130,460,240,40);
    ChangerAlignementTexte (fenetre, "choixdefi", FL_ALIGN_CENTER);
    AjouterBouton(fenetre,"facile","facile", x,y ,largeur, hauteur);
    AjouterBouton(fenetre,"moyen","moyen", x+largeur+espace,y ,largeur, hauteur);
    AjouterBouton(fenetre,"difficile","difficile", x+2*(largeur+espace),y ,largeur, hauteur);
    AjouterBouton(fenetre,"compliqué","max", x+3*(largeur+espace),y ,largeur, hauteur);
  end choixdefi;

  procedure cacherdefi(fenetre: in out TR_fenetre)is
  begin
    CacherElem(fenetre,"choixdefi");
    CacherElem(fenetre,"facile");
    cacherelem(fenetre,"moyen");
    cacherelem(fenetre, "difficile");
    cacherelem(fenetre,"compliqué");
  end cacherdefi;

  procedure montrerdefi(fenetre: in out TR_fenetre)is
  begin
    MontrerElem(fenetre,"choixdefi");
    MontrerElem(fenetre,"facile");
    Montrerelem(fenetre,"moyen");
    Montrerelem(fenetre, "difficile");
    Montrerelem(fenetre,"compliqué");
  end montrerdefi;



  procedure InitwinVictoire (FenetreWin : in out TR_Fenetre) is

    begin
      FenetreWin:=DebutFenetre("Victoire", 300, 300);
      AjouterTexte(FenetreWin, "Bravo", "Bravo, vous avez terminé ce niveau",
                    50,
                    10,
                    230,
                    40);

      AjouterBouton(FenetreWin,"ok","Ok",
                    126,
                    49,
                    48,
                    30);

      AjouterImage(FenetreWin, "Stonks" , "Stonks.xpm" ,"" ,
                    0,
                    132,
                    300,
                    168);

      FinFenetre(FenetreWin);

    end InitwinVictoire;

    procedure AjouterBoutonChoixDef(fenetre : in out Tr_Fenetre; x, y, hauteur, largeur : in positive) is
    largeur_bouton  : constant integer := (largeur - 5*FESPACEMENT) / 6;
    numdefi : integer := 1;
    begin
    while not (numdefi > 20) loop
      for i in 1..5 loop
        AjouterBouton(fenetre, "Defi" & integer'image(numdefi), integer'image(numdefi), x +  (largeur_bouton+FESPACEMENT)*(i-1), y    , largeur_bouton,     hauteur);
        CacherElem(fenetre, "Defi" & integer'image(numdefi));

        numdefi := numdefi + 1;
      end loop;

    end loop;
    end AjouterBoutonChoixDef;

    procedure CacherDef(fenetre : in out TR_Fenetre) is

    begin
      for i in 1..20 loop
        CacherElem(fenetre, "Defi" & integer'image(i));
      end loop;
      CacherElem(fenetre, "RetourDef");
    end CacherDef;

    procedure AfficherDef(fenetre : in out TR_Fenetre; numdefinf : in positive) is

    begin
      ecrire_ligne(numdefinf+4 );
      for i in numdefinf..numdefinf+4 loop
        MontrerElem(fenetre, "Defi" & integer'image(i));
      end loop;
      MontrerElem(fenetre, "RetourDef");
    end AfficherDef;

    function estDefi(nombouton : in string) return Boolean is
    begin
      return nombouton(1..4) = "Defi";
    end estDefi;

    function numDefi(nombouton: in string) return positive is
    begin
      if nombouton'length = 6 then
        return integer'value(nombouton(6..6));
      else
        return integer'value(nombouton(6..7));
      end if;
    end numDefi;


end p_vue_graph;
