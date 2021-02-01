
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


	function Guerison(Grille : in TV_Grille) return boolean is
   begin 
    return (Grille(1,'A') = rouge) and (Grille(2,'B') = rouge);
   end Guerison;


end p_virus;