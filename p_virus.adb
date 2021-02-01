
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
    couleurPrec : T_Coul := vide;
    compteurRouge : natural := 0;

  begin

    reset(f, in_file);

    if num > 1 then
      while not end_of_file(f) and then numDefActu < num loop

        read(f,piece);
        if couleurPrec = rouge then
          numDefActu := numDefActu + 1;
        end if;
        couleurPrec := piece.couleur;
      end loop;
    else
      if not end_of_file(f) then
        read(f, piece);
      end if;
    end if;

    while not end_of_file(f) and then compteurRouge /= 2 loop
      Grille(piece.ligne, piece.colonne) := piece.couleur;
      Pieces(piece.couleur) := true;

      if piece.couleur = rouge then
        compteurRouge := compteurRouge  + 1;
      end if;
      read(f, piece);

    end loop;
  end Configurer;

<<<<<<< HEAD
procedure PosPiece(Grille : in TV_Grille; coul : in T_coulP) is
=======
  procedure PosPiece(Grille : in TV_Grille; coul : in T_coulP) is
>>>>>>> 33cb9a20fe33a056c971437ab660f1f5d60feb8b
    -- {} => {la position de la pièce de couleur coul a été affichée, si coul appartient à Grille:
    --                exemple : ROUGE : F4 - G5}

  begin
    for ligne in T_lig'range loop
      for colo in T_col'range loop
<<<<<<< HEAD
          if grille(ligne,colo)=coul then
            ecrire_ligne("il y a cette couleur à" & image(ligne) & "colonne" & T_Col'image(colo) & "colonne");
          end if;
=======
        if grille(ligne,colo)=coul then
          ecrire_ligne("il y a du" & image(coul) & " à la ligne" & image(ligne) & "et la colonne"  & colo);
        end if;
>>>>>>> 33cb9a20fe33a056c971437ab660f1f5d60feb8b
      end loop;
    end loop;
  end PosPiece;

	function Guerison(Grille : in TV_Grille) return boolean is
   begin
    return (Grille(1,'A') = rouge) and (Grille(2,'B') = rouge);
   end Guerison;

	procedure MajGrille(Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction) is
  tampon: TV_Grille := Grille; -- Je sais plus pk il le faut mais pour eviter de deplacer des truc deja deplacés je crois
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
