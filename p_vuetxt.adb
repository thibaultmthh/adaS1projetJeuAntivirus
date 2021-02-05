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

    procedure AfficheGrille
       (Grille : in TV_Grille; colored : in Boolean := True)
    is
        ncol : Integer := 0;

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
        Prefixe        : constant Character := Character'Val (8#33#); -- '\033'
        code_nettoyage : constant String    := "[2J";
        Modecurseur    : constant String    := "[;H";

        sequenceTexte : constant String :=
           Prefixe & code_nettoyage & Prefixe & Modecurseur;

    begin
        Put (sequenceTexte);

    end NettoyerTerminal;

-- Fin partie graphisme

    procedure InputDefi (numdef : out Integer; cancel : in out Boolean) is

    begin
        loop
            ECRIRE_LIGNE ("Entrez un numéro de défi entre 1 et 20:");
            LIRE (numdef);
            if numdef < 1 or numdef > 20 then
                ECRIRE_LIGNE ("Numéro incorect, doit être entre 1 et 20");
            else
                exit;
            end if;
        end loop;
    end InputDefi;

    procedure InputCouleur
       (couleur : out T_Coul; Pieces : in TV_Pieces; cancel : in out Boolean)
    is
    begin
        loop
            ECRIRE_LIGNE ("Quelle couleur souhaitez vous déplacer?");
            LIRE (couleur);
            if couleur = blanc then
                ECRIRE_LIGNE ("On ne peut pas bouger les blancs.");
            elsif not Pieces (couleur) then
                ECRIRE_LIGNE
                   ("Couleur non presente sur le plateau, reesayez.");
            else
                exit;
            end if;
        end loop;
    end InputCouleur;

    procedure InputDirection
       (dir    : out T_Direction; couleur : in T_CoulP; Grille : in TV_Grille;
        cancel : in out Boolean; modeCouleur : in Boolean := True)
    is
      compteur : integer := 0;
    begin
        loop
            compteur := compteur +1 ;
            ECRIRE_LIGNE
               ("Dans quelle direction souhaitez vous vous déplacer ? Tapez (bg(bas gauche), hg(hautgauche), bd(bas droit) ou hd(haut droit))");
            LIRE (dir);
            
            exit when Possible (Grille, couleur, dir) or compteur = 2;
            NettoyerTerminal;
            AfficheGrille (Grille, modeCouleur);
            ECRIRE ("vous ne pouvez pas bouger vers ");
            ECRIRE (dir);
            ECRIRE (" ! ");
            A_LA_LIGNE;
            ECRIRE_LIGNE (" ressayez une autre direction");

        end loop;
    end InputDirection;

    function InputReplay return Boolean is
    -- Return True quand l'utilisateur veut rejouer, false quand il ne veut pas
        rejouer : Character;
        rep     : Boolean;
    begin
        loop
            ECRIRE_LIGNE
               (" Bravo vous avez gagné, une autre partie ? (y ou n)");
            LIRE (rejouer);
            if rejouer = 'y' then
                ECRIRE_LIGNE ("c'est reparti");
                rep := True;
                exit;
            elsif rejouer = 'n' then
                ECRIRE_LIGNE ("Fin du jeu, a bientot.");
                rep := False;
                exit;
            else
                ECRIRE_LIGNE ("Invalide, reponçe attendue : y ou n");
            end if;
        end loop;
        return rep;
    end InputReplay;

    procedure DisplayStats (f : in out p_joueur_io.File_Type) is
        elem : TR_Stats;
    begin
        Reset (f, In_File);
        Read (f, elem);
        if End_Of_File (f) then
            ECRIRE ("Pas encore de données stats");
        else
            while not End_Of_File (f) loop
              ECRIRE_LIGNE (To_String(elem.nomJoueur));
              ECRIRE_LIGNE ("Possede : ");
              ECRIRE (elem.points);
              ECRIRE (" points");
              --ECRIRE (" , à la date : ");
              --ECRIRE (elem.date.day);
              --ECRIRE (" / ");
              --ECRIRE (elem.date.mois);
              --ECRIRE (" / ");
              --ECRIRE (elem.date.an);
              Read (f, elem);
            end loop;
        end if;
    end DisplayStats;

    procedure InputPlayerName (name : out String) is
    begin
        ECRIRE ("Comment voulez vous vous appeler ?");
        LIRE (name);
    end InputPlayerName;

    procedure InputModeCouleur (couleurfonctionnelle : out Boolean) is
        entreeUtilisateur : Character;
    begin
        ECRIRE ("Voyez vous un carré rouge (y ou n (défaut N))? ");
        Put_Line (ESC & "[48:5:196m   " & ESC & "[0m");
        LIRE (entreeUtilisateur);
        couleurfonctionnelle := entreeUtilisateur = 'y';
        if not couleurfonctionnelle then
            ECRIRE_LIGNE
               ("Pour un confort de jeu optimal il est recommandé d'utiliser un autre terminal (le jeu va se lancer sans le mode couleur)");
        end if;
    end InputModeCouleur;

    procedure afficheLegende is
    begin
        ECRIRE_LIGNE ("1 : Rouge");
        ECRIRE_LIGNE ("2 : Orange");
        ECRIRE_LIGNE ("3 : Rose");
        ECRIRE_LIGNE ("4 : Violet");
        ECRIRE_LIGNE ("5 : Jaune");
        ECRIRE_LIGNE ("6 : Blanc");
        ECRIRE_LIGNE ("7 : Turquoise");
        ECRIRE_LIGNE ("8 : Marron");
        ECRIRE_LIGNE ("9 : Bleu");
        ECRIRE_LIGNE ("0 : Vert");
        ECRIRE_LIGNE (". : Vide");

    end afficheLegende;

    -- procedure historiqueMouvement ( m : in out p_mouvement_io.file_type ; direction : in T_direction ; couleur : in T_coulP) is
    --{ m- contient le mouvement du joueur precedent}
    -- ==> le nouveau mouvement du joueur a été enregistré dans le fichier
    --binaire temporaire historiqueMouvement.bin
    --elem: TR_mouvement;
    --begin
    --   elem.direction := direction; elem.couleur := couleur;
    --   Open(m , append_file, "historiqueMouvement.bin");
    --   write( m , elem);
    --close(m);

    --  end historiqueMouvemen;

    --procedure retournerMouvement ( m : in out p_mouvement_io.file_type) is
    --elem: TR_mouvement;
    -- mouvementPrecedent : TR_mouvement;
    -- begin
    --    reset( m , in_file);
    --read(m , elem);
    --    if end_of_file(m) then
    --   ecrire("Pas possible de retourner le mouvement!");
    --    else
    --  loop
    --read(m,elem);
    --exit when end_of_file(m);
    --end loop;
    --end if;
    --mouvementPrecedent := elem;
    --end retournermouvement;

    function RepEstCoulP (reponse : in T_reponse) return Boolean is
        coul : T_CoulP := T_CoulP'First;
    begin
        while not (coul = T_CoulP'Last)
           and then T_reponse'Image (reponse) /= T_CoulP'Image (coul)
        loop
            coul := T_CoulP'Succ (coul);
        end loop;
        return T_reponse'Image (reponse) = T_CoulP'Image (coul);
    end RepEstCoulP;

end p_vuetxt;
