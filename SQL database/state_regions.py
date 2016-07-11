import pandas
import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

# ACS gender-race dems, 2009-2013
state_regions = sa.Table('state_regions', metadata,
    sa.Column('region', sa.Float),
    sa.Column('state_number', sa.Float, primary_key = True),
    sa.Column('state_name', sa.String())
)

metadata.create_all(conn)