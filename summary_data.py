# This file input the data of recent 7 days of users and processes
import csv

### global variables declaration
current_dir = "D:/Work/Zalo projects/Relationship between no of sent messages vs User interaction/src/interact_withOA/"
data_file = ["2016-07-08", "2016-07-09", "2016-07-10", "2016-07-11", "2016-07-12", "2016-07-13" , "2016-07-14"]

### intput data from files
def input_data():
	dic = {}
	for file in data_file:
		print file
		with open(current_dir + file, "r") as f:
			reader = csv.reader(f, delimiter = " ")
			for row in reader:
				row = row[0].split('\t')
				value = [int(it) for it in row[1:len(row)]]
				if not dic.has_key(row[0]):
					dic.update({row[0] : value})
				else:
					value = [value[i] + dic[row[0]][i] for i in range(len(row) - 1)]
					dic[row[0]] = value
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
	with open(current_dir + "interaction_user_oa", "w") as f:
		for key in dic.keys():
			f.write(str(key) + toString(dic[key]) + "\n")
	f.close()

process()