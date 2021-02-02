package body p_vuetxt is

    procedure AfficheCase
       (coul : in T_Coul; x : in Integer; y : in Integer; colored : in Boolean)
    is
        couleurANSI3 : String (1 .. 3) := "   ";
        couleurANSI2 : String (1 .. 2) := "  ";
        couleurText  : String (1 .. 3);
    begin
        if colored then
            case coul is
                when rouge =>
                    couleurANSI3 := "196";
                when orange =>
                    couleurANSI3 := "202";
                when rose =>
                    couleurANSI3 := "105";
                when violet =>
                    couleurANSI3 := "129";
                when jaune =>
                    couleurANSI3 := "226";
                when blanc =>
                    couleurANSI3 := "231";
                when turquoise =>
                    couleurANSI2 := "51";
                when marron =>
                    couleurANSI2 := "52";
                when bleu =>
                    couleurANSI2 := "21";
                when vert =>
                    couleurANSI2 := "40";
                when others =>
                    null;
            end case;
            if coul = vide then
                if (y mod 2) = 0 then
                    if (x mod 2) = 0 then
                        couleurANSI3 := "239";
                    else
                        couleurANSI3 := "240";
                    end if;
                else
                    if ((x + 1) mod 2) = 0 then
                        couleurANSI3 := "239";
                    else
                        couleurANSI3 := "240";
                    end if;
                end if;
            end if;

            if x = 1 and y = 1 and
               (couleurANSI3 = "   " and couleurANSI2 = "  ")
            then
                couleurANSI3 := "243";
            elsif x = 2 and y = 2 and
               (couleurANSI3 = "   " and couleurANSI2 = "  ")
            then
                couleurANSI3 := "243";
            end if;

            if couleurANSI3 = "   " and couleurANSI2 = "  " then
                Put (ESC & "[48:5:" & couleurANSI2 & "m   " & ESC & "[0m");
            else
                Put (ESC & "[48:5:" & couleurANSI3 & "m   " & ESC & "[0m");
            end if;

        else
            case coul is
                when rouge =>
                    couleurText := " 1 ";
                when orange =>
                    couleurText := " 2 ";
                when rose =>
                    couleurText := " 3 ";
                when violet =>
                    couleurText := " 4 ";
                when jaune =>
                    couleurText := " 5 ";
                when blanc =>
                    couleurText := " 6 ";
                when turquoise =>
                    couleurText := " 7 ";
                when marron =>
                    couleurText := " 8 ";
                when bleu =>
                    couleurText := " 9 ";
                when vert =>
                    couleurText := " 0 ";
                when vide =>
                    couleurText := " . ";
            end case;
            Put (couleurText);
        end if;
    end AfficheCase;

    procedure AfficheBord (char : in Character; colored : in Boolean) is
    begin
        if colored then
            Put (ESC & "[48:5:102m   " & ESC & "[0m");
        else
            Put (" " & char & " ");
        end if;

    end AfficheBord;

    procedure AfficheGrille (Grille : in TV_Grille) is
        ncol    : Integer := 0;
        colored : Boolean := True;
    begin
        Put_Line (" ");
        AfficheBord ('+', colored);

        for y in T_Col'Range loop
            AfficheBord ('-', colored);
        end loop;
        AfficheBord ('+', colored);
        Put_Line (" ");

        for y in T_Lig'Range loop
            AfficheBord ('|', colored);

            for x in T_Col'Range loop
                ncol := ncol + 1;
                AfficheCase (Grille (y, x), ncol, y, colored);
            end loop;
            AfficheBord ('|', colored);

            Put_Line (" ");
            ncol := 0;
        end loop;

        AfficheBord ('+', colored);
        for y in T_Col'Range loop
            AfficheBord ('-', colored);
        end loop;
        AfficheBord ('+', colored);
        Put_Line (" ");

    end AfficheGrille;

    procedure NettoyerTerminal is
    begin
      put(ESC & "[2J");
    end;

end p_vuetxt;
