with p_fenbase, forms, p_esiut;
use p_fenbase, forms, p_esiut;

package p_vue_graph is

  COULEURPRINCIPALE : constant FL_PD_COL := FL_TOP_BCOL;
  FESPACEMENT       : constant Integer   := 10; --padding

  procedure InitFenetreprincipale
   (fenetre : out TR_Fenetre; joueur : in String);

  --procedure ajouterGrille(fenetre : in out TR_Fenetre, NomElement : in String; grille : in TV_Grille);

  --procedure ajouterBtnDeplacement(
  --  fenetre : in out TR_Fenetre;
  -- NomElement : in String;
  -- x,y : in natural);
  procedure initfenetrepseudo (fenetre : out TR_Fenetre; joueur : out String);
  --procédure première fenètre de pseudo

end p_vue_graph;
