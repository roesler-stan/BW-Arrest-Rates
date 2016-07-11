import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

crosswalk = sa.Table('crosswalk', metadata,
    sa.Column('state', sa.String()),
    sa.Column('county', sa.String()),
    sa.Column('agency', sa.String()),
    sa.Column('state_name', sa.String()),
    sa.Column('county_number', sa.String()),
    sa.Column('fmsa_no', sa.String()),
    sa.Column('fmsa', sa.String()),
    sa.Column('ori7', sa.String()),
    sa.Column('ori9', sa.String()),
    sa.Column('zipcode', sa.Float),
    sa.Column('state_no', sa.String()),
    sa.Column('county_no', sa.String())
)

metadata.create_all(conn)