with p_fenbase, forms, p_esiut, p_virus;
use  p_fenbase, forms, p_esiut, p_virus;

package p_vue_graph is
  procedure InitFenetreprincipale(fenetre : out TR_Fenetre; joueur : in string);

  procedure ajouterGrille(
  fenetre : in out TR_Fenetre;
  NomElement : in String;
  x,y : in natural;
  largeur: in positive);



end p_vue_graph;
