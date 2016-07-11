import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

mugshots_july2015 = sa.Table('mugshots_july2015', metadata,
    sa.Column('scraping_arrest_id', sa.Integer),
    sa.Column('county', sa.String()),
    sa.Column('state', sa.String()),
    sa.Column('county_no', sa.String()),
    sa.Column('name', sa.String()),
    sa.Column('download_date', sa.DateTime),
    sa.Column('all_charges', sa.String()),
    sa.Column('age', sa.Float),
    sa.Column('gender', sa.String()),
    sa.Column('zipcode', sa.Float),
    sa.Column('date', sa.DateTime),
    sa.Column('birthday', sa.DateTime),
    sa.Column('race', sa.String()),
    sa.Column('multi', sa.Float),
    sa.Column('am_ind', sa.Float),
    sa.Column('hispanic', sa.Float),
    sa.Column('east_asian', sa.Float),
    sa.Column('asian', sa.Float),
    sa.Column('black', sa.Float),
    sa.Column('white', sa.Float),
    sa.Column('address', sa.String()),
    sa.Column('page_views', sa.String()),
    sa.Column('views_per_day', sa.Float),
    sa.Column('views', sa.Float),
    sa.Column('views_days', sa.Float),
    sa.Column('views_date', sa.DateTime),
    sa.Column('multi_race_whisp', sa.Float),
    sa.Column('multi_race_nohisp', sa.Float),
    sa.Column('white_only', sa.Float),
    sa.Column('am_ind_only', sa.Float),
    sa.Column('asian_only', sa.Float),
    sa.Column('east_asian_only', sa.Float),
    sa.Column('hispanic_only', sa.Float),
    sa.Column('black_only', sa.Float),
    sa.Column('white_only_ighisp', sa.Float),
    sa.Column('am_ind_only_ighisp', sa.Float),
    sa.Column('asian_only_ighisp', sa.Float),
    sa.Column('east_asian_only_ighisp', sa.Float),
    sa.Column('black_only_ighisp', sa.Float),
    sa.Column('black_not_white', sa.Float),
    sa.Column('black_not_other_known', sa.Float),
    sa.Column('racial_minority', sa.Float),
    sa.Column('arrest_id', sa.String(), primary_key = True)
)

metadata.create_all(conn)

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

mugshots_july2015 = sa.Table('mugshots_july2015', metadata, autoload=True, autoload_with=conn)

# To set foreign key to match to arrests - sa.ForeignKey("arrests_m1.arrest_id")
mugshots_charges_july2015 = sa.Table('mugshots_charges_july2015', metadata,
    sa.Column('arrest_id', sa.String(), sa.ForeignKey("mugshots_july2015.arrest_id"), nullable = False),
    sa.Column('charge', sa.String())
)

metadata.create_all(conn)