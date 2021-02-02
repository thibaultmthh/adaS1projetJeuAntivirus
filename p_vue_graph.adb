with p_fenbase, forms, p_esiut;
use  p_fenbase, forms, p_esiut;

package body p_vue_graph is
  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string) is
    FLARGEUR      : constant integer := 500;
    FHAUTEUR      : constant integer := 700;
    FESPACEMENT   : constant integer := 30; --padding

    NBBOUTTON     : constant integer := 3;
    BHAUTEUR      : constant integer := 30;
    BLARGEUR      : constant integer := (FLARGEUR - FESPACEMENT * (NBBOUTTON+1) ) / NBBOUTTON;
    --On calcule la taille d'un bouton par rapport à la taille de la fenetre, au nombre de bouton et a la taille de l'espacement.

    
    ybouttoninf : constant integer := FHAUTEUR - (FESPACEMENT + BHAUTEUR);


  begin

    fenetre:=DebutFenetre("Virus",FLARGEUR,FHAUTEUR);

    AjouterBouton(fenetre, "Stats", "STATS", FESPACEMENT, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Rejouer", "REJOUER", FESPACEMENT * 2 + BLARGEUR, ybouttoninf, BLARGEUR,BHAUTEUR);
    AjouterBouton(fenetre, "Quitter", "QUITTER",  FESPACEMENT * 3 + BLARGEUR * 2, ybouttoninf, BLARGEUR,BHAUTEUR);
    FinFenetre(fenetre);
  end InitFenetreprincipale;

end p_vue_graph;
