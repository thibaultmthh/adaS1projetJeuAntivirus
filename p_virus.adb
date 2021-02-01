
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
          ecrire_ligne("il y a du " & image(coul) & " En ligne : " & image(ligne) & " Colone :" & colo);
        end if;

      end loop;
    end loop;
  end PosPiece;



	function Guerison(Grille : in TV_Grille) return boolean is
   begin
    return (Grille(1,'A') = rouge) and (Grille(2,'B') = rouge);
   end Guerison;

	procedure MajGrille(Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction) is
  tampon: TV_Grille := Grille; -- Je sais plus pk il le faut, mais pour eviter de deplacer des truc deja deplacés je crois
  begin
  for y in T_lig'range loop
      for x in T_col'range loop
        if Grille(y, x) = coul then
          Grille(y, x) := vide; -- vide l'ancienne case
          case Dir is
            when bg => tampon(T_lig'pred(y), T_col'pred(x)):= coul; -- pas besoin de faire de check suplementaires car le mouvement et cencé etre possible
            when bd => tampon(T_lig'pred(y), T_col'succ(x)) := coul;
            when hg => tampon(T_lig'succ(y), T_col'pred(x)) := coul;
            when hd => tampon(T_lig'succ(y), T_col'succ(x)) := coul;
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

  begin

  for i in T_lig'range loop
    for j in T_col'range loop

      if Grille(i,j) = coul then

        if Dir = bg then

          if i /= T_lig'first and then j /= T_col'first then --Check si c'est pas les premiers pour sortir de la range

            if Grille(T_lig'pred(i), T_col'pred(j)) /= vide then
              return false;
            end if;

          else
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = hg then
          if i /= T_lig'last and then j /= T_col'first then

            if Grille(T_lig'succ(i), T_col'pred(j)) /= vide then
              return false;
            end if;

          else
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = bd then
          if i /= T_lig'first and then j /= T_col'last then

            if Grille(T_lig'pred(i), T_col'succ(j)) /= vide then
              return false;
            end if;

          else
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = hd then
          if i /= T_lig'last and then j /= T_col'last then

            if Grille(T_lig'succ(i), T_col'succ(j)) /= vide then
              return false;
            end if;

          else
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        end if;
      end if;

    end loop;
  end loop;

  --Si on a verifié les mouvement et que y'a rien qui bloque, on return true
  return true;

  end Possible;


end p_virus;
