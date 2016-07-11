""" Upload ACS data to SQL databaset """

import sqlalchemy as sa

def main():
    conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
    conn.connect()

    metadata = sa.MetaData()

    # ACS zip codes info, 2009-2013
    acs_zipcodes_13 = sa.Table('acs_zipcodes_13', metadata,
        sa.Column('acs_zipcode', sa.Float, primary_key = True),
        sa.Column('total_residents', sa.Float), sa.Column('w_residents', sa.Float),
        sa.Column('b_residents', sa.Float), sa.Column('i_residents', sa.Float),
        sa.Column('a_residents', sa.Float), sa.Column('h_residents', sa.Float),
        sa.Column('o_residents', sa.Float), sa.Column('m_residents', sa.Float),
        sa.Column('mi_residents', sa.Float), sa.Column('mt_residents', sa.Float),
        sa.Column('b_residents_percent', sa.Float), sa.Column('w_residents_percent', sa.Float),
        sa.Column('nonw_residents_percent', sa.Float), sa.Column('nonw_residents_percent_sq', sa.Float),
        sa.Column('b_residents_percent_sq', sa.Float), sa.Column('w_residents_percent_sq', sa.Float),
        
        sa.Column('total_gender', sa.Float), sa.Column('male_residents', sa.Float),
        sa.Column('total_15_19', sa.Float), sa.Column('male_15_19', sa.Float),
        sa.Column('total_20_24', sa.Float), sa.Column('male_20_24', sa.Float),
        sa.Column('percent_male', sa.Float),
        
        sa.Column('w_total', sa.Float),
        sa.Column('w_male', sa.Float), sa.Column('w_male_18_19', sa.Float),
        sa.Column('w_male_20_24', sa.Float), sa.Column('w_male_18_24', sa.Float),
        
        sa.Column('b_total', sa.Float),
        sa.Column('b_male', sa.Float), sa.Column('b_male_18_19', sa.Float),
        sa.Column('b_male_20_24', sa.Float), sa.Column('b_male_18_24', sa.Float),
        
        sa.Column('total_inc_households', sa.Float), sa.Column('mean_inc', sa.Float),
        sa.Column('binc_125to150', sa.Float), sa.Column('binc_20to25', sa.Float),
        sa.Column('binc_25to30', sa.Float), sa.Column('binc_60to75', sa.Float),
        sa.Column('binc_under10', sa.Float), sa.Column('binc_15to20', sa.Float),
        sa.Column('binc_30to35', sa.Float), sa.Column('binc_40to45', sa.Float),
        sa.Column('binc_50to60', sa.Float), sa.Column('binc_100to125', sa.Float),
        sa.Column('binc_200more', sa.Float), sa.Column('binc_35to40', sa.Float),
        sa.Column('binc_75to100', sa.Float), sa.Column('binc_45to50', sa.Float),
        sa.Column('binc_150to200', sa.Float), sa.Column('binc_households', sa.Float),
        sa.Column('binc_10to15', sa.Float),
        sa.Column('winc_125to150', sa.Float), sa.Column('winc_20to25', sa.Float),
        sa.Column('winc_25to30', sa.Float), sa.Column('winc_60to75', sa.Float),
        sa.Column('winc_under10', sa.Float), sa.Column('winc_15to20', sa.Float),
        sa.Column('winc_30to35', sa.Float), sa.Column('winc_40to45', sa.Float),
        sa.Column('winc_50to60', sa.Float), sa.Column('winc_100to125', sa.Float),
        sa.Column('winc_200more', sa.Float), sa.Column('winc_35to40', sa.Float),
        sa.Column('winc_75to100', sa.Float), sa.Column('winc_45to50', sa.Float),
        sa.Column('winc_150to200', sa.Float), sa.Column('winc_households', sa.Float),
        sa.Column('winc_10to15', sa.Float),
        
        sa.Column('binc_under10_percent', sa.Float), sa.Column('binc_under20', sa.Float),
        sa.Column('binc_under20_percent', sa.Float), sa.Column('binc_under40', sa.Float),
        sa.Column('binc_under40_percent', sa.Float),
        sa.Column('winc_under10_percent', sa.Float), sa.Column('winc_under20', sa.Float),
        sa.Column('winc_under20_percent', sa.Float), sa.Column('winc_under40', sa.Float),
        sa.Column('winc_under40_percent', sa.Float),

        sa.Column('total_unemp', sa.Float), sa.Column('one_race_unemp', sa.Float),
        sa.Column('w_unemp', sa.Float), sa.Column('b_unemp', sa.Float)
    )

    metadata.create_all(conn)

if __name__ == '__main__':
    main()