
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

    while not end_of_file(f) and then couleurPrec /= rouge loop
      Grille(piece.ligne, piece.colonne) := piece.couleur;
      Pieces(piece.couleur) := true;
      couleurPrec := piece.couleur;
      read(f, piece);

    end loop;
  end Configurer;



	function Guerison(Grille : in TV_Grille) return boolean is
   begin
    return (Grille(1,'A') = rouge) and (Grille(2,'B') = rouge);
   end Guerison;

	procedure MajGrille(Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction) is
  tampon: TV_Grille := Grille;
  begin 
  for y in T_lig'range loop
      for x in T_col'range loop
        if Grille(y, x) = coul then
          Grille(y, x) := vide;
          case Dir is 
            when bg => tampon(T_lig'pred(y), T_col'pred(x)):= coul;
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
          Grille(y,x) := coul;
        end if;
      end loop;
    end loop;
  end MajGrille;
end p_virus;
