#!/bin/bash
mkdir -p db
cd db
cp ../sql/*.sql .
[ ! -f fcc_uls_fixed.sql ] && {
   cat uls_structure.sql | sed s%dbo.%%g > fcc_uls_fixed.sql
}

#
# Amateur Service
##########
[ ! -f fcc_uls_amateur.zip ] && {
   wget -O fcc_uls_amateur.zip https://data.fcc.gov/download/pub/uls/complete/l_amat.zip
}
[ ! -d fcc_uls_amateur ] && {
   mkdir fcc_uls_amateur
   cd fcc_uls_amateur
   unzip ../fcc_uls_amateur.zip
   cd ..
}

#
# aircraft
##########
[ ! -f fcc_uls_aircraft.zip ] && {
  wget -O fcc_uls_aircraft.zip https://data.fcc.gov/download/pub/uls/complete/l_aircr.zip
}

#
# commercial radio & restricted radiotelephone
############
[ ! -f fcc_uls_frc.zip ] && {
  wget -O fcc_uls_frc.zip https://data.fcc.gov/download/pub/uls/complete/l_frc.zip
}
[ ! -d fcc_uls_cell ] && {
   mkdir -p fcc_uls_cell
   cd fcc_uls_cell
   unzip ../fcc_uls_cell.zip
   cd ..
}

# Towers
#########
[ ! -f fcc_uls_towers.zip ] && {
   wget -O fcc_uls_towers.zip https://data.fcc.gov/download/pub/uls/complete/r_tower.zip
}
[ ! -d fcc_uls_towers ] && {
   mkdir -p fcc_uls_towers
   cd fcc_uls_towers
   unzip ../fcc_uls_towers.zip
   cd ..
}

# cellular
##########
[ ! -f fcc_uls_cell.zip ] && {
  wget -O fcc_uls_cell.zip https://data.fcc.gov/download/pub/uls/complete/l_cell.zip
}
[ ! -d fcc_uls_cell ] && {
   mkdir -p fcc_uls_cell
   cd fcc_uls_cell
   unzip ../fcc_uls_cell.zip
   cd ..
}

# gmrs
######
[ ! -f fcc_uls_gmrs.zip ] && {
   wget -O fcc_uls_gmrs.zip https://data.fcc.gov/download/pub/uls/complete/l_gmrs.zip
}
[ ! -d fcc_uls_gmrs ] && {
   mkdir -p fcc_uls_gmrs
   cd fcc_uls_gmrs
   unzip ../fcc_uls_gmrs.zip
   cd ..
}

# Land Mobile - Broadcast Auxiliary
##############
[ ! -f fcc_uls_lmbcast.zip ] && {
   wget -O fcc_uls_lmbcast.zip https://data.fcc.gov/download/pub/uls/complete/l_LMbcast.zip
}

# Land Mobile - Commercial
##############
[ ! -f fcc_uls_commercial.zip ] && {
   wget -O fcc_uls_commercial.zip https://data.fcc.gov/download/pub/uls/complete/l_LMcomm.zip
}

# Land Mobile - Private
###########
[ ! -f fcc_uls_private.zip ] && {
  wget -O fcc_uls_private.zip https://data.fcc.gov/download/pub/uls/complete/l_LMpriv.zip 
}

# Maritime Coast & Aviation Ground
#############
[ ! -f fcc_uls_coast.zip ] && {
  wget -O fcc_uls_coast.zip https://data.fcc.gov/download/pub/uls/complete/l_coast.zip
}

# Pagers
########
[ ! -f fcc_uls_pagers.zip ] && {
   wget -O fcc_uls_pagers.zip https://data.fcc.gov/download/pub/uls/complete/l_paging.zip
}

# ship radio service
########
[ ! -f fcc_uls_ship.zip ] && {
   wget -O fcc_uls_ship.zip https://data.fcc.gov/download/pub/uls/complete/l_ship.zip
}

# process the stuff and things...

[ -f fcc_uls.db ] && rm -r fcc_uls.db
[ ! -f fcc_uls.db ] && {
   sqlite3 fcc_uls.db < fcc_uls_fixed.sql
   echo "Importing Amateur Service..."
   sqlite3 fcc_uls.db < import_ham.sql
   echo "Importing GMRS..."
   sqlite3 fcc_uls.db < import_gmrs.sql
   echo "Importing Antenna Structures (Towers)..."
   sqlite3 fcc_uls.db < import_towers.sql
   echo "Importing Cellular Sites..."
   sqlite3 fcc_uls.db < import_cell.sql
}

###########
# Cleanup #
###########
rm fcc_uls_fixed.sql
