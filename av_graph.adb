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

  MontrerFenetre(fpseudo);
  ChangerTempsMinuteur(fprincipale, "Chronometre", 200000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");
  if Attendrebouton(fpseudo) = "jouer" then
    FinFenetre(fpseudo);
    InitFenetreprincipale(fprincipale, pseudo);
    MontrerFenetre(fprincipale);
  end if;
   if Attendrebouton(fprincipale) = "quitter" then
    FinFenetre(fprincipale);
  end if;

  ecrire_ligne(ConsulterTimer(fprincipale,"Chronometre"));        --nom de la fenêtreNomElement : inString      )
  CacherFenetre(fprincipale);
  CacherFenetre(fpseudo);




end av_graph;
