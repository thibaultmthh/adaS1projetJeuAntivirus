with p_fenbase, forms, p_esiut, p_vue_graph;
use  p_fenbase, forms, p_esiut, p_vue_graph;


procedure av_graph is
  fprincipale : TR_Fenetre;
  continue : Character;
begin -- av_graph
  InitialiserFenetres;
  InitFenetreprincipale(fprincipale, "EggManPlayer");

  MontrerFenetre(fprincipale);
  ChangerTempsMinuteur(fprincipale, "Chronometre", 200000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");
  declare
    Bouton : String := (Attendrebouton(fprincipale));
  begin
    ecrire_ligne("bouton appuyé : " & Bouton);

  end;
  --test
  --test2
  ecrire_ligne(ConsulterTimer(fprincipale,"Chronometre"));        --nom de la fenêtreNomElement : inString      )
  CacherFenetre(fprincipale);




end av_graph;
