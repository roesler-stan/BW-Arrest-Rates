import pandas
import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

# ACS racial dems, 2009-2013
acs_races = sa.Table('acs_races_0913', metadata,
    sa.Column('county_no', sa.String(), primary_key = True),
    sa.Column('total', sa.Float), sa.Column('white', sa.Float),
    sa.Column('black', sa.Float), sa.Column('indian', sa.Float),
    sa.Column('asian', sa.Float), sa.Column('hawaii', sa.Float),
    sa.Column('other', sa.Float), sa.Column('multiple', sa.Float),
    sa.Column('mult_inclother', sa.Float), sa.Column('mult_notother', sa.Float)
)

# ACS income, 2009-2013
acs_income = sa.Table('acs_inc_0913', metadata,
    sa.Column('county_no', sa.String(), primary_key = True),
    sa.Column('unemployed', sa.Float), sa.Column('households', sa.Float),
    sa.Column('under10', sa.Float), sa.Column('under10_percent', sa.Float),
    sa.Column('inc10to15', sa.Float), sa.Column('inc10to15_percent', sa.Float),
    sa.Column('inc15to25', sa.Float), sa.Column('inc15to25_percent', sa.Float),
    sa.Column('inc25to35', sa.Float), sa.Column('inc25to35_percent', sa.Float),
    sa.Column('inc35to50', sa.Float), sa.Column('inc35to50_percent', sa.Float),
    sa.Column('inc50to75', sa.Float), sa.Column('inc50to75_percent', sa.Float),
    sa.Column('inc75to100', sa.Float), sa.Column('inc75to100_percent', sa.Float),
    sa.Column('inc100to150', sa.Float), sa.Column('inc100to150_percent', sa.Float),
    sa.Column('inc150to200', sa.Float), sa.Column('inc150to200_percent', sa.Float),
    sa.Column('inc200more', sa.Float), sa.Column('inc200more_percent', sa.Float),
    sa.Column('inc_median', sa.Float), sa.Column('inc_mean', sa.Integer)
)

# ACS income for white, non-hispanic, 2009-2013
acs_inc_white = sa.Table('acs_inc_white_0913', metadata,
    sa.Column('county_no', sa.String(), primary_key = True),
    sa.Column('total', sa.Float),
    sa.Column('inc_under10', sa.Float),
    sa.Column('inc_10to15', sa.Float),
    sa.Column('inc_15to20', sa.Float),
    sa.Column('inc_20to25', sa.Float),
    sa.Column('inc_25to30', sa.Float),
    sa.Column('inc_30to35', sa.Float),
    sa.Column('inc_35to40', sa.Float),
    sa.Column('inc_40to45', sa.Float),
    sa.Column('inc_45to50', sa.Float),
    sa.Column('inc_50to60', sa.Float),
    sa.Column('inc_60to75', sa.Float),
    sa.Column('inc_75to100', sa.Float),
    sa.Column('inc_100to125', sa.Float),
    sa.Column('inc_125to150', sa.Float),
    sa.Column('inc_150to200', sa.Float),
    sa.Column('inc_200more', sa.Float),
)

# ACS income for black, 2009-2013
acs_inc_black = sa.Table('acs_inc_black_0913', metadata,
    sa.Column('county_no', sa.String(), primary_key = True),
    sa.Column('total', sa.Float),
    sa.Column('inc_under10', sa.Float),
    sa.Column('inc_10to15', sa.Float),
    sa.Column('inc_15to20', sa.Float),
    sa.Column('inc_20to25', sa.Float),
    sa.Column('inc_25to30', sa.Float),
    sa.Column('inc_30to35', sa.Float),
    sa.Column('inc_35to40', sa.Float),
    sa.Column('inc_40to45', sa.Float),
    sa.Column('inc_45to50', sa.Float),
    sa.Column('inc_50to60', sa.Float),
    sa.Column('inc_60to75', sa.Float),
    sa.Column('inc_75to100', sa.Float),
    sa.Column('inc_100to125', sa.Float),
    sa.Column('inc_125to150', sa.Float),
    sa.Column('inc_150to200', sa.Float),
    sa.Column('inc_200more', sa.Float),
)

metadata.create_all(conn)