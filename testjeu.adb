with p_esiut; use p_esiut;
with p_virus; use p_virus; use p_virus.p_piece_io;

procedure testjeu is
  numdef : integer range 1..20;
  Grille : TV_Grille;
  Pieces :TV_Pieces;
  f : p_piece_io.file_type;
begin
  InitPartie(Grille, Pieces);
  open(f, in_file, "Defis.bin");
  ecrire_ligne("entrez un numéro de défi entre 1 et 20:");
  lire(numdef);
  Configurer(f, numdef, Grille, Pieces);
  pospiece(grille,jaune);
end testjeu;
