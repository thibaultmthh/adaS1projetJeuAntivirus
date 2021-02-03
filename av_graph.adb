with p_fenbase, forms, p_esiut, p_vue_graph;
use  p_fenbase, forms, p_esiut, p_vue_graph;


procedure av_graph is
  fprincipale : TR_Fenetre;
  continue : Character;
begin -- av_graph
  InitialiserFenetres;
  InitFenetreprincipale(fprincipale, "EggManPlayer");

  MontrerFenetre(fprincipale);
  RepriseTimer(fprincipale, "Chronometre");
  declare
    Bouton : String := (Attendrebouton(fprincipale));
  begin
    ecrire_ligne("bouton appuyé : " & Bouton);

  end;
  
  ecrire_ligne(ConsulterTimer(fprincipale,"Chronometre"));        --nom de la fenêtreNomElement : inString      )
  CacherFenetre(fprincipale);




end av_graph;
