package body interface_CL is

procedure AfficheCase(coul : in T_Coul) is
couleurANSI: string(1..3);
begin
    case coul is
        when rouge => couleurANSI:= "196";
        when turquoise => couleurANSI := "51 ";
        when orange => couleurANSI := "202";
        when rose => couleurANSI := "105";
        when marron => couleurANSI := "52 ";
        when bleu => couleurANSI := "21 ";
        when violet => couleurANSI := "129";
        when vert => couleurANSI := "40 ";
        when jaune => couleurANSI := "226";
        when blanc => couleurANSI := "231";
        when vide => couleurANSI := "16 ";
    end case;
    
    Put (ESC & "[48:5:" & couleurANSI & "m  " & ESC & "[0m");
end AfficheCase;

procedure AfficheGrille(Grille : in TV_Grille) is
    begin 
        for y in T_lig'range loop
            for x in T_col'range loop
                AfficheCase(Grille(y,x));
            end loop;
            put_line(" ");
        end loop;

    end AfficheGrille;

end interface_CL;