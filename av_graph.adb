with p_fenbase, forms, p_esiut, p_vue_graph;
use p_fenbase, forms, p_esiut, p_vue_graph;

procedure av_graph is
  fprincipale : TR_Fenetre;
  fpseudo     : TR_Fenetre;
  continue    : Character;
  pseudo      : String (1 .. 3);
begin -- av_graph
  InitialiserFenetres;
  initfenetrepseudo (fpseudo);

  MontrerFenetre (fpseudo);
  ChangerTempsMinuteur (fprincipale, "Chronometre", 200_000.0);
  -- ChangerMinuteurEnChrono(fprincipale, "Chronometre");

  declare
    Bouton : String := (Attendrebouton (fpseudo));
  begin
    if Bouton = "quitter" then
      CacherFenetre (fpseudo);
    elsif Bouton = "jouer" then
      pseudo := Consultercontenu (fpseudo, "pseudo");
      CacherFenetre (fpseudo);
      InitFenetreprincipale (fprincipale, pseudo);
      MontrerFenetre (fprincipale);
        loop
          declare
            Bouton : String := (Attendrebouton (fprincipale));
          begin
            if Bouton = "Quitter" then
              CacherFenetre (fprincipale);
              exit;
            elsif bouton = "Rejouer" then
              ecrire_ligne("rejouer");
            elsif bouton = "Stats" then
              ecrire_ligne("stats");
            end if;
          end;
        end loop;
    end if;
  end;

  ecrire_ligne
   (ConsulterTimer
     (fprincipale,
      "Chronometre"));        --nom de la fenêtreNomElement : inString      )
  ECRIRE_LIGNE ("fin");

end av_graph;
