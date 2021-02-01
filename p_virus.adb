
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




  function Possible(Grille : in TV_Grille; coul : in T_CoulP; Dir : in T_Direction) is

  begin

  for i in T_lig'range loop
    for j in T_col'range loop

      if Grille(i,j) = coul then

        if Dir = bg then

          if i /= T_lig'first and j /= T_col'first then --Check si c'est pas les premiers pour sortir de la range

            if Grille(i-1, j-1) /= vide then
              return false;
            end if;

          else 
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = hg then
          if i /= T_lig'last and j /= T_col'first then 
          
            if Grille(i+1, j-1) /= vide then
              return false;
            end if;

          else 
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = bd then
          if i /= T_lig'first and j /= T_col'last then 
          
            if Grille(i-1, j+1) /= vide then
              return false;
            end if;

          else 
            return false; --Si on sort de la range, on peut pas déplacer donc false
          end if;


        elsif Dir = hd then
          if i /= T_lig'last and j /= T_col'last then 
          
            if Grille(i+1, j-1) /= vide then
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
