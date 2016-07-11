import sqlalchemy as sa

# To make arrests SQL table
conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

# 2012 UCR, with racial and gender/age info
# Could a composite primary key with agency-county-year-month-offense, but there are duplicates
ucr_arrests_13 = sa.Table('ucr_arrests_13', metadata,
    sa.Column('ori', sa.String()),
    sa.Column('county', sa.String()),
    sa.Column('state', sa.String()),
    sa.Column('county_no', sa.String()),
    sa.Column('year', sa.Integer), 
    sa.Column('month', sa.Float),
    sa.Column('population', sa.Float),
    sa.Column('offense', sa.String()),
    sa.Column('black', sa.Float), sa.Column('white', sa.Float),
    sa.Column('indian', sa.Float), sa.Column('asian', sa.Float),
    sa.Column('hispanic', sa.Float), sa.Column('nonhispanic', sa.Float)
)

metadata.create_all(conn)