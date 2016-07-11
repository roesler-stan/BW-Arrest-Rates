import sqlalchemy as sa

conn = sa.create_engine('postgresql://roesler:break_free15@mugshots.cwwgybrqdl5n.us-west-1.rds.amazonaws.com:5432/Mugshots', echo=False)
conn.connect()

metadata = sa.MetaData()

arrests_j1 = sa.Table('arrests_j1', metadata, 
    sa.Column('age', sa.Float), sa.Column('eyes', sa.String()),
    sa.Column('facility', sa.String()), sa.Column('hair', sa.String()),
    sa.Column('height', sa.String()), sa.Column('notes', sa.String()),
    sa.Column('ref #', sa.String()), sa.Column('weight', sa.String()),
    sa.Column('charges', sa.String()), sa.Column('id', sa.String()),
    sa.Column('jail_address1', sa.String()), sa.Column('jail_address2', sa.String()),
    sa.Column('jail_city', sa.String()), sa.Column('jail_name', sa.String()),
    sa.Column('jail_state', sa.String()), sa.Column('jail_url', sa.String()),
    sa.Column('name', sa.String()), sa.Column('book_year', sa.Float),
    sa.Column('source', sa.String()), sa.Column('arrest_id', sa.String()),
    sa.Column('charges_string', sa.String()), sa.Column('source_text', sa.String()),
    sa.Column('source_text_clean', sa.String()), sa.Column('date', sa.String()),
    sa.Column('state', sa.String()), sa.Column('gender', sa.String()),
    sa.Column('race', sa.String()), sa.Column('multi', sa.Float),
    sa.Column('am_ind', sa.Float), sa.Column('hispanic', sa.Float),
    sa.Column('east_asian', sa.Float), sa.Column('asian', sa.Float),
    sa.Column('black', sa.Float), sa.Column('white', sa.Float)
)

metadata.create_all(conn)