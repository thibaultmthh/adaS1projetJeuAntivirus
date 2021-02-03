with p_fenbase, forms, p_esiut, p_vue_graph;
use  p_fenbase, forms, p_esiut, p_vue_graph;


procedure av_graph is
  fprincipale : TR_Fenetre;
  fpseudo : TR_Fenetre;
  continue : Character;
  pseudo : string(1..3);
begin -- av_graph
  InitialiserFenetres;
  initfenetrepseudo(fpseudo, pseudo);

  MontrerFenetre(fpseudo);
  ChangerTempsMinuteur(fprincipale, "Chronometre", 200000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");

  declare
    Bouton : String := (Attendrebouton(fpseudo));
    begin
      if bouton = "quitter" then
        CacherFenetre(fpseudo);
      elsif bouton = "jouer" then
        pseudo:=Consultercontenu(fpseudo,"pseudo");
        CacherFenetre(fpseudo);
        InitFenetreprincipale(fprincipale, pseudo);
        MontrerFenetre(fprincipale);
        if Attendrebouton(fprincipale) = "quitter" then
          CacherFenetre(fprincipale);
        end if;
      end if;
    end;

  ecrire_ligne(ConsulterTimer(fprincipale,"Chronometre"));        --nom de la fenêtreNomElement : inString      )
  ecrire_ligne("fin");


end av_graph;
