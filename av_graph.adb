with p_fenbase, forms, p_esiut, p_vue_graph;
use p_fenbase, forms, p_esiut, p_vue_graph;

procedure av_graph is
  fprincipale : TR_Fenetre;
  fpseudo     : TR_Fenetre;
  continue    : Character;
  pseudo      : String (1 .. 3);

  colorSet    : Boolean := false;
  



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
          colorSet := false;
          declare
            Bouton : String := (Attendrebouton (fprincipale));
          begin
            -- if c'st un bouton
            if Bouton = "Quitter" then
              CacherFenetre (fprincipale);
              exit;
            elsif bouton = "Rejouer" then
              ecrire_ligne("rejouer");
            elsif bouton = "Stats" then
              ecrire_ligne("stats");

            -- if c'est une couleur
            elsif bouton(1..1) = "G" then
              ecrire("Couleur");
              colorSet := true;
               

            -- if c'est un deplacement 
            elsif bouton(1..1) = "D" and  then
              ecrire("Deplacement");
               


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
