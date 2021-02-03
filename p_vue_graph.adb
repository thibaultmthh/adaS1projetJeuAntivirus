with p_fenbase, forms, p_esiut;
use  p_fenbase, forms, p_esiut;

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


    AjouterBouton(fenetre, "Stats", "STATS", FESPACEMENT, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Rejouer", "REJOUER", FESPACEMENT * 2 + BLARGEUR, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Quitter", "QUITTER",  FESPACEMENT * 3 + BLARGEUR * 2, ybouttoninf, BLARGEUR,BHAUTEUR);
    FinFenetre(fenetre);
  end InitFenetreprincipale;

  procedure initfenetrepseudo(fenetre: out TR_Fenetre) is
    FLARGEUR            : constant integer := 600;
    FHAUTEUR            : constant integer := 600;

    NBTEXTE             : constant integer := 3;
    TEXTELARGEUR        : constant integer := (FLARGEUR - FESPACEMENT * (NBTEXTE+1) ) / NBTEXTE;

    TEXTEHAUTEUR        : constant integer := 30;

    NBBOUTTON           : constant integer := 2;
    BLARGEUR            : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTTON+1) ) / NBBOUTTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.
    BHAUTEUR            : constant integer := 30;
    ybouttoninf         : constant integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);

  begin
    fenetre:=DebutFenetre("pseudo", Flargeur, Fhauteur);
    ChangerCouleurFond(fenetre, "fond", COULEURPRINCIPALE);
    
    AjouterChamp(fenetre,"pseudo","Votre pseudo","ton", 300 - 75 ,400,150,30);
    AjouterBouton(fenetre,"jouer","JOUER", 300 - 75 ,450,70,30);
    AjouterBouton(fenetre,"quitter","Quitter",305,450,70,30);

    AjouterTexte( fenetre, "Bienvenue" , "Bienvenue au Jeu ANTI VIRUS!!" , 200, 20, 200, 50);
    AjouterImage ( fenetre , "imageAntiVirus" , "antivirusimage.xpm" ,"" , 200 , 150, 200 , 200 );
    AjouterImage ( fenetre , "imageTousAntiCovid" , "anticovid.xpm" , "" , 0 , 428 , 77,231) ;

    FinFenetre(fenetre);
  end initfenetrepseudo;

end p_vue_graph;
