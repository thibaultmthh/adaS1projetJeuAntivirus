package body interface_CL is

procedure AfficheCase(coul : in T_Coul) is
couleurANSI3: string(1..3) := "   ";
couleurANSI2: string(1..2);
begin
    case coul is
        when rouge => couleurANSI3:= "196";
        when orange => couleurANSI3 := "202";
        when rose => couleurANSI3 := "105";
        when violet => couleurANSI3 := "129";
        when jaune => couleurANSI3 := "226";
        when blanc => couleurANSI3 := "231";
        when turquoise => couleurANSI2 := "51";
        when marron => couleurANSI2 := "52";
        when bleu => couleurANSI2 := "21";
        when vert => couleurANSI2 := "40";
        when vide => couleurANSI3 := "16";
    end case;
   
    if couleurANSI3 = "   " then
        Put (ESC & "[48:5:" & couleurANSI2 & "m  " & ESC & "[0m");
    else
        Put (ESC & "[48:5:" & couleurANSI3 & "m  " & ESC & "[0m");
    end if;
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