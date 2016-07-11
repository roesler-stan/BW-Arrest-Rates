CHUNKS = 15
    TOTAL_ROWS = 4100000 # actual number is 3,983,542

    for chunk in xrange(CHUNKS):
        start_row = chunk * CHUNK_SIZE
        print 'skipping ' + str(start_row) + ' rows'
        # Skip start_row number of index rows.  nrows is how many rows are read (not to which row)
        if start_row > 0:
            nibrs_data = pandas.read_csv(nibrs_file, skiprows = [start_row], nrows = CHUNK_SIZE)
        else:
            nibrs_data = pandas.read_csv(nibrs_file, skiprows = start_row, nrows = CHUNK_SIZE)


    filenames = [chunks_outfile + str(chunk_number) + '.csv' for chunk_number in xrange(CHUNKS)]