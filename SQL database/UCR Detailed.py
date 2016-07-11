import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

# UCR Arrest Types without racial info, 2012
ucr_detailed_arrests_2012 = sa.Table('ucr_detailed_arrests_12', metadata,
    sa.Column('county_no', sa.String(), primary_key = True),
    sa.Column('fips_st', sa.String()), sa.Column('fips_cty', sa.String()),
    sa.Column('cpoparst', sa.Float), sa.Column('ag_arrst', sa.Float),
    sa.Column('jurflag', sa.String()), sa.Column('covind', sa.Float),
    sa.Column('grndtot', sa.Float), sa.Column('p1tot', sa.Float),
    sa.Column('p1vlnt', sa.Float), sa.Column('p1prpty', sa.Float),
    sa.Column('murder', sa.Float), sa.Column('rape', sa.Float),
    sa.Column('robbery', sa.Float), sa.Column('agasslt', sa.Float),
    sa.Column('burglry', sa.Float), sa.Column('larceny', sa.Float),
    sa.Column('mvtheft', sa.Float), sa.Column('arson', sa.Float),
    sa.Column('othaslt', sa.Float), sa.Column('frgycnt', sa.Float),
    sa.Column('fraud', sa.Float), sa.Column('embezl', sa.Float),
    sa.Column('stlnprp', sa.Float), sa.Column('vandlsm', sa.Float),
    sa.Column('weapons', sa.Float), sa.Column('comvice', sa.Float),
    sa.Column('sexoff', sa.Float), sa.Column('drugtot', sa.Float),
    sa.Column('drgsale', sa.Float), sa.Column('cocsale', sa.Float),
    sa.Column('mjsale', sa.Float), sa.Column('synsale', sa.Float),
    sa.Column('othsale', sa.Float), sa.Column('drgposs', sa.Float),
    sa.Column('cocposs', sa.Float), sa.Column('mjposs', sa.Float),
    sa.Column('synposs', sa.Float), sa.Column('othposs', sa.Float),
    sa.Column('gamble', sa.Float), sa.Column('bookmkg', sa.Float),
    sa.Column('number', sa.Float), sa.Column('otgambl', sa.Float),
    sa.Column('ofagfam', sa.Float), sa.Column('drui', sa.Float),
    sa.Column('liquor', sa.Float), sa.Column('drunk', sa.Float),
    sa.Column('disordr', sa.Float), sa.Column('vagrant', sa.Float),
    sa.Column('allothr', sa.Float), sa.Column('suspicn', sa.Float),
    sa.Column('curfew', sa.Float), sa.Column('runaway', sa.Float)
)

metadata.create_all(conn)