with p_esiut; use p_esiut;
with p_virus; use p_virus; use p_virus.p_piece_io;

procedure testjeu is
  numdef : integer;
  Grille : TV_Grille;
  Pieces :TV_Pieces;
  f : p_piece_io.file_type;
  nombre : boolean:=false;
begin
  InitPartie(Grille, Pieces);
  open(f, in_file, "Defis.bin");
  while not nombre loop
    ecrire_ligne("entrez un numéro de défi entre 1 et 20:");
    lire(numdef);
    if numdef<1 or numdef>20 then
      ecrire_ligne("mettre un nombre entre 1 et 20");
    else
      nombre:=true;
    end if;
  end loop;
  Configurer(f, numdef, Grille, Pieces);
  for coul in T_coul'range loop
    if coul/=vide then
      pospiece(grille,coul);
    end if;
  end loop;
end testjeu;
