
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
    while not end_of_file(f) and then numDefActu < num loop
      read(f,piece);
      if couleurPrec = rouge then
        numDefActu := numDefActu + 1;
      end if;
      couleurPrec := piece.couleur;
    end loop;

    while not end_of_file(f) and then couleurPrec /= rouge loop
      Grille(piece.ligne, piece.colonne) := piece.couleur;
      Pieces(piece.couleur) := true;
      couleurPrec := piece.couleur;
      read(f, piece);
    end loop;





end p_virus;
