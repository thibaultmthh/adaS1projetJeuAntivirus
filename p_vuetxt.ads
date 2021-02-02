with Text_IO;                use Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with p_virus;                use p_virus;

package p_vuetxt is

    procedure AfficheGrille (Grille : in TV_Grille);

    procedure NettoyerTerminal;
    --{} => {Le terminal est vide}

end p_vuetxt;
