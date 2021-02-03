with p_fenbase, forms, p_esiut;
use p_fenbase, forms, p_esiut;

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

    --ChangerStyleTexte(fenetre, "NomJoueur", FL_BOLD_Style);
    --ChangerTailleTexte(fenetre, "NomJoueur", 500);

    AjouterBouton
     (fenetre, "Stats", "STATS", FESPACEMENT, ybouttoninf, BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Rejouer", "REJOUER", FESPACEMENT * 2 + BLARGEUR, ybouttoninf,
      BLARGEUR, BHAUTEUR);
    AjouterBouton
     (fenetre, "Quitter", "QUITTER", FESPACEMENT * 3 + BLARGEUR * 2,
      ybouttoninf, BLARGEUR, BHAUTEUR);

    ajouterBtnDeplacement (fenetre, "", 150, 350, 350, 435);
    FinFenetre (fenetre);
  end InitFenetreprincipale;

  procedure initfenetrepseudo(fenetre: out TR_Fenetre; joueur: out string) is
    FLARGEUR            : constant integer := 300;
    FHAUTEUR            : constant integer := 300;

    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;

    TEXTEHAUTEUR        : constant integer := 30;

    NBBOUTTON           : constant integer := 2;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTTON+1) ) / NBBOUTTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR    : constant Integer := 30;
    ybouttoninf : constant Integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);

  begin
    fenetre := DebutFenetre ("pseudo", Flargeur, Fhauteur);
    ChangerCouleurFond (fenetre, "fond", COULEURPRINCIPALE);

    AjouterTexte
     (fenetre, "NomJoueur", "Quel est ton nom?", FESPACEMENT, FESPACEMENT,
      TEXTELARGEUR, TEXTEHAUTEUR);

    AjouterChamp
     (fenetre, "pseudo", "Votre pseudo", "EggMan", 100, 10, 280, 30);
    AjouterBouton (fenetre, "jouer", "JOUER", 100, 50, 70, 30);
    AjouterBouton (fenetre, "BoutonAnnuler", "Quitter", 180, 50, 70, 30);

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
         (fenetre, T_Direction'Image (btnList (y, x)),
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
