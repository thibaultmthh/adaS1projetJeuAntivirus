with Text_IO;                use Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with p_virus;                use p_virus;
with p_esiut;                use p_esiut;

package p_vuetxt is

    package p_dir_io is new P_ENUM (T_Direction);
    use p_dir_io;

    package p_coul_io is new P_ENUM (T_CoulP);
    use p_coul_io;

    procedure AfficheGrille (Grille : in TV_Grille);


    procedure NettoyerTerminal;
    --{} => {Le terminal est vide}

    procedure InputDefi (numdef : out Integer; cancel : in out Boolean);

    procedure InputCouleur
       (couleur : out T_Coul; Pieces : in TV_Pieces; cancel : in out Boolean);

    procedure InputDirection
       (dir    : out T_Direction; couleur : in T_CoulP; Grille : in TV_Grille;
        cancel : in out Boolean);

    function InputReplay return Boolean;


end p_vuetxt;
