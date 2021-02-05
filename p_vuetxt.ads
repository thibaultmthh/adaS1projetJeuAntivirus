with Text_IO;                use Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with p_virus;                use p_virus;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
use p_virus.p_joueur_io;
with p_esiut; use p_esiut;

package p_vuetxt is

    --type TR_mouvement is record
        --direction : T_direction;
        --couleur : T_coulP;
    --end record;
    --type TR_date is record
     --jour : natural;
     --mois : natural;
     --an : natural;
   --end record;

--  type TR_Joueur is record
  --  nomJoueur : string(1..25); --son nom
  --  nomNiveau : string(1..20);    -- nom du niveau
  --  points : natural;     -- nb de points selon le compteur_mouvement
  --  date : TR_date;      -- la date qu'il a joué
  --  timestampdebut: integer;
  --  timestampFin: integer;
  --  numeroDefis: natural;
--  end record;
  -- package p_mouvement_io is new sequential_io(TR_mouvement); use p_mouvement_io;


   --package p_joueur_io is new sequential_io(TR_joueur); use p_joueur_io;
  --s : p_joueur_io.file_type;
  --m : p_mouvement_io.file_type;

    --package p_mouvement_io is new sequential_io(TR_mouvement); use p_mouvement_io;

    package p_dir_io is new P_ENUM (T_Direction);
    use p_dir_io;

    package p_coul_io is new P_ENUM (T_CoulP);
    use p_coul_io;

    type T_reponse is (rouge, turquoise, orange, rose, marron, bleu, violet, vert, jaune,
     blanc, vide , r , n );


    procedure AfficheGrille (Grille : in TV_Grille; colored : in boolean := true);

    procedure NettoyerTerminal;
    --{} => {Le terminal est vide}

    procedure InputDefi (numdef : out Integer; cancel : in out Boolean);

    procedure InputCouleur
       (couleur : out T_Coul; Pieces : in TV_Pieces; cancel : in out Boolean);

    procedure InputDirection
       (dir    : out T_Direction; couleur : in T_CoulP; Grille : in TV_Grille;
        cancel : in out Boolean;
        modeCouleur : in boolean := true);

    procedure DisplayStats (f : in out p_joueur_io.File_Type);

    function InputReplay return Boolean;

    procedure InputPlayerName (name : out String);

    procedure InputModeCouleur(couleurfonctionnelle : out boolean);

    procedure afficheLegende;

    function RepEstCoulP (reponse : in T_reponse) return boolean;

    --procedure historiqueMouvement ( m : in out p_mouvement_io.file_type ; direction : in T_direction ; couleur : in T_coulP);
    --procedure retournerMouvement ( m : in out p_mouvement_io.file_type);

end p_vuetxt;
