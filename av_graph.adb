with p_fenbase, forms, p_esiut, p_vue_graph;
use  p_fenbase, forms, p_esiut, p_vue_graph;


procedure av_graph is
  fprincipale : TR_Fenetre;
  fpseudo : TR_Fenetre;
  continue : Character;
  pseudo : string(1..5);
begin -- av_graph
  InitialiserFenetres;
  initfenetrepseudo(fpseudo, pseudo);
  InitFenetreprincipale(fprincipale, pseudo);

  MontrerFenetre(fpseudo);
  MontrerFenetre(fprincipale);
  ChangerTempsMinuteur(fprincipale, "Chronometre", 200000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");
  declare
    Bouton : String := (Attendrebouton(fprincipale));
  begin
    ecrire_ligne("bouton appuyé : " & Bouton);

  end;
    declare
    Bouton : String := (Attendrebouton(fpseudo));
  begin
    ecrire_ligne("bouton appuyé : " & Bouton);

  end;

  ecrire_ligne(ConsulterTimer(fprincipale,"Chronometre"));        --nom de la fenêtreNomElement : inString      )
  CacherFenetre(fprincipale);
  CacherFenetre(fpseudo);




end av_graph;
