# This file input the data of recent 7 days of users and processes
import csv

### global variables declaration
current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/"
data_file = "data.csv"

### intput data from files
def input_data():
	dic = {}
	count = {}

	with open(current_dir + data_file, "r") as f:
		reader = csv.reader(f, delimiter = " ")
		cnt = 0
		for row in reader:
			
			cnt += 1
	
			row = row[0].split(',')
			
			if row[0] == "Date":
				continue
	
			key = row[1]

			value = [int(it) for it in row[2:len(row)]]
			
			print row[0],key, value

			if not dic.has_key(key):
				dic.update({key : value})
				count.update({key : 0})
			else:
				value = [value[i] + dic[key][i] for i in range(len(value))]
				dic[key] = value
				count[key] += 1

	print count	
	f.close()		
	return dic

def toString(l):
	s = ""
	for it in l:
		s += " " + str(it)
	return s

### process
def process():
		dic = input_data()
		with open(current_dir + "user_statistics", "w") as f:
		for key in dic.keys():
		f.write(str(key) + toString(dic[key]) + "\n")
		f.close()

process()