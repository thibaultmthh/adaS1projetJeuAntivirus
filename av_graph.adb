with p_fenbase, forms, p_esiut, p_vue_graph;
use  p_fenbase, forms, p_esiut, p_vue_graph;


procedure av_graph is
  fprincipale : TR_Fenetre;
  continue : Character;
begin -- av_graph
  InitialiserFenetres;
  InitFenetreprincipale(fprincipale, "EggManPlayer");

  MontrerFenetre(fprincipale);
  declare
    Bouton : String := (Attendrebouton(ftest));
  begin
    ecrire_ligne("bouton appuyé : " & Bouton);
  end;

  CacherFenetre(ftest);




end av_graph;
