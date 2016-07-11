import csv
import os
from collections import defaultdict

# Combine all files in given directory
def combine_files(directory, outfile):
    os.chdir(directory)
    filenames = [ f for f in os.listdir('.') if '.csv' in f ]
    append_csv(outfile, filenames)
    #append_diff(outfile, filenames)

# Take column names from first file passed in and create new file with all of these columns' rows from each file
def append_csv(final_file, filenames):
    with open(filenames[0], 'r') as first_file:
        reader = csv.reader(first_file)
        headers = reader.next()

    with open(final_file, 'a') as final_csv:
        writer = csv.DictWriter(final_csv, fieldnames = headers)
        writer.writeheader()

        for new_file in filenames:
            with open(new_file, 'r') as new_csv:
                reader = csv.DictReader(new_csv)
                for row in reader:
                    writer.writerow(row)

# Append files that may have different column names
def append_diff(outfile, filenames):
    unique_headers = set()
    for filename in filenames:
        with open(filename, 'r') as f:
            reader = csv.DictReader(f)
            headers = reader.next()
            for header in headers:
                unique_headers.add(header)

    headers = list(unique_headers)
    with open(outfile, 'a') as out:
        writer = csv.DictWriter(out, fieldnames = headers)
        writer.writeheader()

        for filename in filenames:
            with open(filename, 'r') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    writer.writerow(row)