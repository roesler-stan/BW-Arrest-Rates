import pandas as pd

def main():
	directory = '../../Data/'
	infile = directory + 'acs_counties_13.csv'
	df = pd.read_csv(infile)

	all_men = df['male_residents'].sum().astype(float)
	black_men = df['black_male'].sum().astype(float)
	white_men = df['white_male'].sum().astype(float)

	print "% of male residents who are black"
	print (black_men / all_men) * 100

	print "% of male residents who are white"
	print (white_men / all_men) * 100

	print "% of black and white male residents who are black"
	print (black_men / (black_men + white_men)) * 100

if __name__ == "__main__":
	main()