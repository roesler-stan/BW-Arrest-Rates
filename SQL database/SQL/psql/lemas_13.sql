psql --host=mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com --port=5432 --username=roesler --password --dbname=Mugshots

\copy lemas_13 FROM '../Data/SQL Input/lemas_13.csv' CSV HEADER;
