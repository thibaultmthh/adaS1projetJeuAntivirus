with p_esiut; use p_esiut;
with p_virus; use p_virus; use p_virus.p_piece_io;
with interface_CL; use interface_CL;
procedure testjeu is
  numdef : integer;
  Grille : TV_Grille;
  Pieces :TV_Pieces;
  f : p_piece_io.file_type;
  nombre : boolean:=false;
  rejouer : string(1..2);
  stop : boolean :=false;
begin
    open(f, in_file, "Defis.bin");
    InitPartie(Grille, Pieces);
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
      AfficheGrille(grille);

    for coul in T_coul'range loop
      if coul/=vide then
        pospiece(grille,coul);
      end if;
    end loop;

    if Guerison(grille) then
      ecrire_ligne("TU AS GAGNE GG !! veux-tu rejouer? (y ou n)");
      lire(rejouer);
      if rejouer="y" then
        ecrire_ligne("c'est reparti");
      elsif rejouer="n" then
        ecrire_ligne("j'espère que tu reviendra bientôt");
        stop:=true;
      else
        ecrire_ligne("écris 'y' si tu veux rejouer ou 'n' si tu ne veux pas");
      end if;
    end if;
end testjeu;
