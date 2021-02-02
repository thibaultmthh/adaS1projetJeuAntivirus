
package body p_virus is
  procedure InitPartie(Grille : in out TV_Grille; Pieces : in out TV_Pieces) is
	-- {} => {Tous les éléments de Grille ont été initialisés avec la couleur VIDE, y compris les cases inutilisables
	--				Tous les élements de Pieces ont été initialisés à false}

  begin

    for i in T_lig'range loop
      for j in T_col'range loop
        Grille(i, j) := vide;

      end loop;
    end loop;

    for i in Pieces'range loop
      pieces(i) := false;

    end loop;

  end InitPartie;

  procedure Configurer(f : in out p_piece_io.file_type; num : in integer;
                       Grille : in out TV_Grille; Pieces : in out TV_Pieces) is

    numDefActu : natural := 1;
    piece: TR_ElemP;

    compteurRouge : natural range 0..2 := 0;
    -- ce compteur sera incrémenté a chaque fois que la
    -- tête de lecture rencontrera une pièce rouge.
    -- lorsque sa valeur vaut 2 on le réinitialise et on incremente le compteur de défis :
    -- On est passé au défis suivant

  begin

    reset(f, in_file); --Reset la lecture du fichier pour revenir au début


    while not end_of_file(f) and then numDefActu < num loop --Parcours tout le fichier

      read(f,piece);

      if piece.couleur = rouge then             --Compte les rouges
        compteurRouge := compteurRouge + 1;
        if compteurRouge = 2 then               --Si on a tout les rouges, on change de map
          numDefActu := numDefActu  +1;
          compteurRouge := 0;                   --Et on reset le compteur de rouge
        end if;

      end if;


    end loop;

    compteurRouge := 0;

    while not end_of_file(f) and then compteurRouge /= 2 loop
      read(f, piece);
      Grille(piece.ligne, piece.colonne) := piece.couleur;    --Save la couleur sur la map
      Pieces(piece.couleur) := true;                          --Enregistre que la couleur a été utilisée

      if piece.couleur = rouge then
        compteurRouge := compteurRouge  + 1;
      end if;


    end loop;
  end Configurer;


  procedure PosPiece(Grille : in TV_Grille; coul : in T_coulP) is

    -- {} => {la position de la pièce de couleur coul a été affichée, si coul appartient à Grille:
    --                exemple : ROUGE : F4 - G5}
  begin
    for ligne in T_lig'range loop
      for colo in T_col'range loop


        if grille(ligne,colo)=coul then
          ecrire_ligne("il y a du " & image(coul) & " En ligne :" & image(ligne) & " Colone : " & colo);
        end if;

      end loop;
    end loop;
  end PosPiece;



	function Guerison(Grille : in TV_Grille) return boolean is
   begin
    return (Grille(1,'A') = rouge) and (Grille(2,'B') = rouge);
   end Guerison;

	procedure MajGrille(Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction) is
  tampon: TV_Grille ; -- Je sais plus pk il le faut, mais pour eviter de deplacer des truc deja deplacés je crois
  begin
  for i in T_lig'range loop -- tambon = grille vide qui stoque que les nouveau deplacements
      for j in T_col'range loop
        tampon(i, j) := vide;

      end loop;
    end loop;

  for y in T_lig'range loop
      for x in T_col'range loop
        if Grille(y, x) = coul then
          Grille(y, x) := vide; -- vide l'ancienne case

          case Dir is
            when bg => tampon(T_lig'succ(y), T_col'pred(x)):= coul; -- pas besoin de faire de check suplementaires car le mouvement et cencé etre possible
            when bd => tampon(T_lig'succ(y), T_col'succ(x)) := coul;
            when hg => tampon(T_lig'pred(y), T_col'pred(x)) := coul;
            when hd => tampon(T_lig'pred(y), T_col'succ(x)) := coul;
          end case;
        end if;
      end loop;
    end loop;
    for y in T_lig'range loop
      for x in T_col'range loop
        if tampon(y, x) = coul then

          Grille(y,x) := coul; -- copie les nouveau deplacement dans la grille
        end if;
      end loop;
    end loop;
  end MajGrille;



  function Possible(Grille : in TV_Grille; coul : in T_CoulP; Dir : in T_Direction) return boolean is
    possibleDansGrille : boolean;
    x : T_lig := T_lig'first;
    y : T_col := T_col'first;

    xDest : T_lig := T_lig'first;
    yDest : T_col := T_col'first;

    TAILLEPIECEMAX : integer := 3;
    nbpieceteste : integer := 0;
  begin
      -- On vérifie que la couleur est dans la grille
       --On retourne faux si la couleur n'est pas dans la grille
      if not couleurPresente(Grille, coul) then
         return false;

      else  -- Si on a trouvé la piece;




        loop
          possibleDansGrille := true;

          loop
            if x = T_lig'last then  -- On change de colone si on est arrivé au bout de celle ci
              x := T_lig'first;
              y := T_col'succ(y);
            else
              x := T_lig'succ(x);
            end if;
          exit when Grille(x,y) = coul or (x = T_lig'last and y = T_col'last);
          end loop;

          if Grille(x,y) = coul then
            if dir = bg or dir = hg  then    --Si direction contient gauche
              if y = T_Col'first then
                possibleDansGrille := false; --On ne peut pas déplacer vers la gauche
              else
                yDest := T_col'pred(y);
              end if;


            else                                  --Si direction contient droite
              if y = T_Col'last then
                possibleDansGrille := false; --On ne peut pas déplacer vers la droite
              else
                yDest := T_col'succ(y);
              end if;
            end if;


            if dir = bg or dir = bd then    --Si direction contient bas
              if x = T_lig'last then
                possibleDansGrille := false; --On ne peut pas déplacer vers la bas
              else
                xDest := T_lig'succ(x);
              end if;
            else                                  --Si direction contient haut
              if x = T_lig'first then
                possibleDansGrille := false; --On ne peut pas déplacer vers la haut
              else
                xDest := T_lig'pred(x);
              end if;
            end if;


            ecrire_ligne(possibleDansGrille);
            nbpieceteste := nbpieceteste + 1;
          end if;
          exit when not possibleDansGrille
          or (x = T_lig'last and y = T_col'last)
          or nbpieceteste = TAILLEPIECEMAX
          or (Grille(xDest,yDest) /= coul and Grille(xDest,yDest) /= vide);
          -- On sort si :
          -- 1 - On ne peut pas bouger la piece en x,y vers xDest, yDest
          -- 2 - On est arrivé au bout de la grille avec x, y
          -- 3 - On a deja essayé de déplacer 3 piece (TAILLEPIECEMAX)
          -- 4 - Si la couleur de la piece de destination n'est ni vide ni de la couleur coul



        end loop;
      end if;



      return possibleDansGrille and
      (Grille(xDest,yDest) = coul or Grille(xDest,yDest) = vide);
      -- On retourne vrai si la dernière piece testé a un destination qui :
      -- 1 - est dans la Grille
      -- 2 - a pour couleur vide ou coul


  end Possible;

  function couleurPresente(grille: TV_Grille; coul :in T_coul) return boolean is
    x : T_lig := T_lig'first;
    y : T_col := T_col'first;
  begin
    loop
    exit when Grille(x,y) = coul or (x = T_lig'last and y = T_col'last);

    if x = T_lig'last then  -- On change de colone si on est arrivé au bout de celle ci
      x := T_lig'first;
      y := T_col'succ(y);
    else
      x := T_lig'succ(x);
    end if;
    end loop;

    return (Grille(x,y) = coul);

end couleurPresente;

end p_virus;
