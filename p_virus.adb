package body p_virus is

  procedure SaveANewStat (s : in out p_joueur_io.File_Type; Joueur : TR_Joueur)
  is
  --{le s- contient les points et le nom du joueur précedenent}
  -- ==> le dossier du joueur ( nom,points et date) a été sauvé dans stats
  begin
    Open (s, Append_File, "stats.bin");
    Write (s, Joueur);
    Close (s);
  end SaveANewStat;

  procedure InitPartie (Grille : in out TV_Grille; Pieces : in out TV_Pieces)
  is
  -- {} => {Tous les éléments de Grille ont été initialisés avec la couleur VIDE, y compris les cases inutilisables
  --                              Tous les élements de Pieces ont été initialisés à false}

  begin

    for i in T_Lig'Range loop
      for j in T_Col'Range loop
        Grille (i, j) := vide;

      end loop;
    end loop;

    for i in Pieces'Range loop
      Pieces (i) := False;

    end loop;

  end InitPartie;

  procedure Configurer
   (f      : in out p_piece_io.File_Type; num : in Integer;
    Grille : in out TV_Grille; Pieces : in out TV_Pieces)
  is

    numDefActu : Natural := 1;
    piece      : TR_ElemP;

    compteurRouge : Natural range 0 .. 2 := 0;
    -- ce compteur sera incrémenté a chaque fois que la
    -- tête de lecture rencontrera une pièce rouge.
    -- lorsque sa valeur vaut 2 on le réinitialise et on incremente le compteur de défis :
    -- On est passé au défis suivant

  begin

    Reset (f, In_File); --Reset la lecture du fichier pour revenir au début

    while not End_Of_File (f) and then numDefActu < num
    loop --Parcours tout le fichier

      Read (f, piece);

      if piece.couleur = rouge then             --Compte les rouges
        compteurRouge := compteurRouge + 1;
        if compteurRouge = 2
        then               --Si on a tout les rouges, on change de map
          numDefActu    := numDefActu + 1;
          compteurRouge :=
           0;                   --Et on reset le compteur de rouge
        end if;

      end if;

    end loop;

    compteurRouge := 0;

    while not End_Of_File (f) and then compteurRouge /= 2 loop
      Read (f, piece);
      Grille (piece.ligne, piece.colonne) :=
       piece.couleur;    --Save la couleur sur la map
      Pieces (piece.couleur) :=
       True;                          --Enregistre que la couleur a été utilisée

      if piece.couleur = rouge then
        compteurRouge := compteurRouge + 1;
      end if;

    end loop;
  end Configurer;

  procedure PosPiece (Grille : in TV_Grille; coul : in T_CoulP) is

  -- {} => {la position de la pièce de couleur coul a été affichée, si coul appartient à Grille:
  --                exemple : ROUGE : F4 - G5}
  begin
    for ligne in T_Lig'Range loop
      for colo in T_Col'Range loop

        if Grille (ligne, colo) = coul then
          ECRIRE_LIGNE
           ("il y a du " & IMAGE (coul) & " En ligne :" & IMAGE (ligne) &
            " Colone : " & colo);
        end if;

      end loop;
    end loop;
  end PosPiece;

  function Guerison (Grille : in TV_Grille) return Boolean is
  begin
    return (Grille (1, 'A') = rouge) and (Grille (2, 'B') = rouge);
  end Guerison;

  procedure MajGrille
   (Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction)
  is
    tampon : TV_Grille; -- Je sais plus pk il le faut, mais pour eviter de deplacer des truc deja deplacés je crois
  begin
    for i in T_Lig'Range
    loop -- tambon = grille vide qui stoque que les nouveau deplacements
      for j in T_Col'Range loop
        tampon (i, j) := vide;

      end loop;
    end loop;

    for y in T_Lig'Range loop
      for x in T_Col'Range loop
        if Grille (y, x) = coul then
          Grille (y, x) := vide; -- vide l'ancienne case

          case Dir is
            when bg =>
              tampon (T_Lig'Succ (y), T_Col'Pred (x)) :=
               coul; -- pas besoin de faire de check suplementaires car le mouvement et cencé etre possible
            when bd =>
              tampon (T_Lig'Succ (y), T_Col'Succ (x)) := coul;
            when hg =>
              tampon (T_Lig'Pred (y), T_Col'Pred (x)) := coul;
            when hd =>
              tampon (T_Lig'Pred (y), T_Col'Succ (x)) := coul;
          end case;
        end if;
      end loop;
    end loop;
    for y in T_Lig'Range loop
      for x in T_Col'Range loop
        if tampon (y, x) = coul then

          Grille (y, x) :=
           coul; -- copie les nouveau deplacement dans la grille
        end if;
      end loop;
    end loop;
  end MajGrille;

  function Possible
   (Grille : in TV_Grille; coul : in T_CoulP; Dir : in T_Direction)
    return Boolean
  is
    possibleDansGrille : Boolean;
    x                  : T_Lig := T_Lig'First;
    y                  : T_Col := T_Col'First;

    xDest : T_Lig := T_Lig'First;
    yDest : T_Col := T_Col'First;

    TAILLEPIECEMAX : Integer := 3;
    nbpieceteste   : Integer := 0;
  begin
      -- On vérifie que la couleur est dans la grille
       --On retourne faux si la couleur n'est pas dans la grille
      if not couleurPresente(Grille, coul) then
         return false;

      else  -- Si on a trouvé la piece;
      loop
        possibleDansGrille := True;
        loop
          if x = T_Lig'Last
          then  -- On change de colone si on est arrivé au bout de celle ci
            x := T_Lig'First;
            y := T_Col'Succ (y);
          else
            x := T_Lig'Succ (x);
          end if;
          exit when Grille (x, y) = coul or
           (x = T_Lig'Last and y = T_Col'Last);
        end loop;

        if Grille (x, y) = coul then
          if Dir = bg or Dir = hg then    --Si direction contient gauche
            if y = T_Col'First then
              possibleDansGrille :=
               False; --On ne peut pas déplacer vers la gauche
            else
              yDest := T_Col'Pred (y);
            end if;

          else                                  --Si direction contient droite
            if y = T_Col'Last then
              possibleDansGrille :=
               False; --On ne peut pas déplacer vers la droite
            else
              yDest := T_Col'Succ (y);
            end if;

            nbpieceteste := nbpieceteste + 1;
          end if;

          if Dir = bg or Dir = bd then    --Si direction contient bas
            if x = T_Lig'Last then
              possibleDansGrille :=
               False; --On ne peut pas déplacer vers la bas
            else
              xDest := T_Lig'Succ (x);
            end if;
          else                                  --Si direction contient haut
            if x = T_Lig'First then
              possibleDansGrille :=
               False; --On ne peut pas déplacer vers la haut
            else
              xDest := T_Lig'Pred (x);
            end if;
          end if;

          nbpieceteste := nbpieceteste + 1;
        end if;
        exit when not possibleDansGrille or
         (x = T_Lig'Last and y = T_Col'Last) or
         nbpieceteste = TAILLEPIECEMAX or
         (Grille (xDest, yDest) /= coul and Grille (xDest, yDest) /= vide);
        -- On sort si :
        -- 1 - On ne peut pas bouger la piece en x,y vers xDest, yDest
        -- 2 - On est arrivé au bout de la grille avec x, y
        -- 3 - On a deja essayé de déplacer 3 piece (TAILLEPIECEMAX)
        -- 4 - Si la couleur de la piece de destination n'est ni vide ni de la couleur coul

      end loop;
    end if;

    return possibleDansGrille and
     (Grille (xDest, yDest) = coul or Grille (xDest, yDest) = vide);
    -- On retourne vrai si la dernière piece testé a un destination qui :
    -- 1 - est dans la Grille
    -- 2 - a pour couleur vide ou coul

  end Possible;

  function couleurPresente
   (grille : TV_Grille; coul : in T_Coul) return Boolean
  is
    x : T_Lig := T_Lig'First;
    y : T_Col := T_Col'First;
  begin
    loop
      exit when grille (x, y) = coul or (x = T_Lig'Last and y = T_Col'Last);

      if x = T_Lig'Last
      then  -- On change de colone si on est arrivé au bout de celle ci
        x := T_Lig'First;
        y := T_Col'Succ (y);
      else
        x := T_Lig'Succ (x);
      end if;
    end loop;

    return (grille (x, y) = coul);

  end couleurPresente;

  procedure historiqueMouvement ( m : in out p_mouvement_io.file_type ; direction : in T_direction ; couleur : in T_coulP) is
    --{ m- contient le mouvement du joueur precedent}
    -- ==> le nouveau mouvement du joueur a été enregistré dans le fichier
    --binaire temporaire historiqueMouvement.bin
    elem: TR_mouvement;
  begin
    elem.direction := direction; elem.couleur := couleur;
    Open(m , append_file, "historiqueMouvement.bin");
    write( m , elem);
    close(m);

  end historiqueMouvement;

end p_virus;
