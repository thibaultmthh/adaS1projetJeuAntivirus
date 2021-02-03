with Sequential_IO;
with p_esiut; use p_esiut;

package p_virus is
    TAILLEGRILLE : constant positive := 6;
    --------------- Types pour representer la grille de jeu
    subtype T_Col is Character range 'A' .. 'G';
    subtype T_Lig is Integer range 1 .. 7;
    type T_Coul is
       (rouge, turquoise, orange, rose, marron, bleu, violet, vert, jaune,
        blanc, vide);

    type TV_Grille is array (T_Lig, T_Col) of T_Coul;

    ---- type pour les pièces du jeu
    subtype T_CoulP is T_Coul range rouge .. blanc; -- couleurs des pièces
    package p_coul_io is new P_ENUM (T_CoulP);
    use p_coul_io;

    -- élément constitutif d'une pièce
    type TR_ElemP is record --      un élément constituant une pièce
        colonne : T_Col;                  --      la colonne qu'il occupe dans la grille
        ligne : T_Lig;                          --      la ligne qu'il occupe dans la grille
        couleur : T_CoulP;                --      sa couleur
    end record;

    -- type vecteur contraint pour mémoriser les picèes d'un défi donné
    type TV_Pieces is array (T_CoulP) of Boolean;

    ---- Instanciation de sequential_io pour un fichier de TR_ElemP
    package p_piece_io is new Sequential_IO (TR_ElemP);
    use p_piece_io;

    ---- type pour les directions de déplacement des pièces
    type T_Direction is (bg, hg, bd, hd);
    package p_dir_io is new P_ENUM (T_Direction);
    use p_dir_io;

	type TR_mouvement is record
		direction : T_direction;
		couleur : T_coulP;
	end record;
	package p_mouvement_io is new sequential_io(TR_mouvement); use p_mouvement_io;


    -- --- partie stats
    type TR_date is record
        jour : Natural;
        mois : Natural;
        an   : Natural;
    end record;

    type TR_Joueur is record
        nomJoueur      : String (1 .. 25); --son nom
        nomNiveau      : String (1 .. 20);    -- nom du niveau
        points : Natural;     -- nb de points selon le compteur_mouvement
        date           : TR_date;      -- la date qu'il a joué
        timestampdebut : Integer;
        timestampFin   : Integer;
        nbCoups        : Integer;
        numeroDefis    : Natural;
    end record;
    package p_joueur_io is new Sequential_IO (TR_Joueur);
    use p_joueur_io;

    procedure SaveANewStat
       (s : in out p_joueur_io.File_Type; Joueur : TR_Joueur);

    --------------- Primitives d'nitialisation d'une partie

    procedure InitPartie
       (Grille : in out TV_Grille; Pieces : in out TV_Pieces);
    -- {} => {Tous les éléments de Grille ont été initialisés avec la couleur VIDE, y compris les cases inutilisables
    --                              Tous les élements de Pieces ont été initialisés à false}

    procedure Configurer
       (f      : in out p_piece_io.File_Type; num : in Integer;
        Grille : in out TV_Grille; Pieces : in out TV_Pieces);
    -- {f ouvert, non vide, num est un numéro de défi
    --      dans f, un défi est représenté par une suite d'éléments :
    --      * les éléments d'une même pièce (même couleur) sont stockés consécutivement
    --      * les deux éléments constituant le virus (couleur rouge) terminent le défi}
    --                      => {Grille a été mis à jour par lecture dans f de la configuration de numéro num
    --                                      Pieces a été mis à jour en fonction des pièces de cette configuration}

    -- pour tester une configuration initiale

    procedure PosPiece (Grille : in TV_Grille; coul : in T_CoulP);
    -- {} => {la position de la pièce de couleur coul a été affichée, si coul appartient à Grille:
    --                              exemple : ROUGE : F4 - G5}

    --------------- Contrôle du jeu

    function Possible
       (Grille : in TV_Grille; coul : in T_CoulP; Dir : in T_Direction)
        return Boolean;
    -- {coul /= blanc}
    --      => {resultat = vrai si la pièce de couleur coul peut être déplacée dans la direction Dir}

    procedure MajGrille
       (Grille : in out TV_Grille; coul : in T_CoulP; Dir : in T_Direction);
    -- {la pièce de couleur coul peut être déplacée dans la direction Dir}
    --      => {Grille a été mis à jour suite au deplacement}

    function Guerison (Grille : in TV_Grille) return Boolean;
    -- {} => {résultat = vrai si Grille(1,A) = Grille(2,B) = ROUGE}

    --------------------------------------------------------------------------------------------
    -- AJOUTS pour gestion partie et gestion annulations en vue graphique
    --------------------------------------------------------------------------------------------
    -- Pour gérer les fichiers contenant les configs de la grille de jeu au fil d'une partie
    package p_Grille_io is new Sequential_IO (TV_Grille);
    use p_Grille_io;
    --------------------------------------------------------------------------------------------
    -- function CaseGrille(lig : in T_lig; col : in T_col) return boolean;
    --      {} => {résultat = vrai si la case en colonne col et en ligne lig est utisable}
    --------------------------------------------------------------------------------------------
    -- procedure InitMemoG(fg : in out p_grille_io.file_type; G : in out TV_Grille; nbelem : out positive);
    --{fg ouvert}  =>
    --              {fg a été resetté en position d'écriture, G a été écrit dans fg, nbelem = 1}
    --------------------------------------------------------------------------------------------
    -- procedure AddMemoG(fg : in out p_grille_io.file_type; G : in out TV_Grille; nbelem : in out positive);
    --{fg ouvert, nbelem est le nombre d'éléments de fg}  =>
    --              {G a été ajouté en fin de fg, nbelem a été incrémenté}
    --------------------------------------------------------------------------------------------
    -- procedure SupMemoG(fg : in out p_grille_io.file_type; G : in out TV_Grille; nbelem : in out positive);
    --{fg ouvert, nbelem est le nombre d'éléments de fg, nbelm > 1}  =>
    --              {G = dernier élement de fg, le dernier élément de fg a été supprimé, nbelem est décrémenté}
    --------------------------------------------------------------------------------------------
    function couleurPresente
       (grille : TV_Grille; coul : in T_Coul) return Boolean;
    --{} => {vrai si couleur dans grille}

    procedure historiqueMouvement ( m : in out p_mouvement_io.file_type ; direction : in T_direction ; couleur : in T_coulP);

end p_virus;
