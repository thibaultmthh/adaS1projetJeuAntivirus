with p_fenbase, forms, p_esiut, p_virus;
use p_fenbase, forms, p_esiut, p_virus;

package p_vue_graph is

  COULEURPRINCIPALE : constant FL_PD_COL := FL_TOP_BCOL;
  FESPACEMENT       : constant Integer   := 10; --padding
  NBELEMGRILLE      : constant integer   := 7;


  type Tv_btn is array (1 .. 2, 1 .. 2) of T_Direction;

  btnList : Tv_btn            := ((hg, hd), (bg, bd));

  procedure InitFenetreprincipale
   (fenetre : out TR_Fenetre; joueur : in String);

  procedure ajouterGrille(
  fenetre : in out TR_Fenetre;
  NomElement : in String;
  x,y : in natural;
  largeur: in positive);

  procedure ajouterBtnDeplacement
   (fenetre      : in out TR_Fenetre; NomElement : in String;
    x, y, x2, y2, padding : in     Natural);

  procedure initfenetrepseudo (fenetre : out TR_Fenetre);
  --procédure première fenètre de pseudo

  procedure afficherGrille(fenetre : in out TR_Fenetre; NomGrille : in String; Grille : in TV_Grille);

  procedure afficherBtnDeplacements(fenetre : in out TR_Fenetre;  coul:in T_coul; grille: TV_Grille);
  procedure masquerBtnDeplacements(fenetre : in out TR_Fenetre);
  function getCouleurCase(nomCase: String; grille : TV_Grille)  return T_coul;

end p_vue_graph;
