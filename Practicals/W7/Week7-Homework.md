# Week 7

## 1. Read `pubmed_results.txt` and extract the US ZIP codes

import re

f = open("../../Python/DataFiles/MapOfScience/pubmed_results.txt", "r")
my_text = f.read()

zipcodes = re.findall(r"[A-Z]{2}\s{1,7}(\d{5})\s{0,7},\s{0,7}USA", my_text)

unique_zipcodes = []
for z in zipcodes:
    if z not in unique_zipcodes:
        unique_zipcodes.append(z)

Extracted 5,198 ZIP code records, a total of 462 unique ZIP codes.

## 2. Create `zip_code`, `zip_long`, `zip_lat`, and `zip_count`

import csv

zip_code = []
zip_long = []
zip_lat = []
zip_count = []

f = open("../../Python/DataFiles/MapOfScience/zipcodes_coordinates.txt", "r")
csvr = csv.reader(f)
header = True

for row in csvr:
    if header:
        header = False
    else:
        if row[0] in unique_zipcodes:
            zip_code.append(row[0])
            zip_lat.append(float(row[1]))
            zip_long.append(float(row[2]))
            zip_count.append(zipcodes.count(row[0]))

There are 368 unique ZIP codes in the coordinate table that can match the latitude and longitude. The remaining 94 have no corresponding coordinates. `94720` has appeared the most times, with a total of 228 times.

## 3. Visualize the data

import matplotlib.pyplot as plt
    %matplotlib inline

    plt.scatter(zip_long, zip_lat, s = zip_count, c= zip_count)
    plt.colorbar()

    plt.xlim(-125,-65)
    plt.ylim(23, 50)

    ard = dict(arrowstyle="->")
    plt.annotate('Los Angeles', xy = (-118.25, 34.05), 
                   xytext = (-108.25, 34.05), arrowprops = ard)
    plt.annotate('Palo Alto', xy = (-122.1381, 37.4292), 
                   xytext = (-112.1381, 37.4292), arrowprops= ard)
    plt.annotate('Cambridge', xy = (-71.1106, 42.3736), 
                   xytext = (-73.1106, 48.3736), arrowprops= ard)
    plt.annotate('Chicago', xy = (-87.6847, 41.8369), 
                   xytext = (-87.6847, 46.8369), arrowprops= ard)
    plt.annotate('Seattle', xy = (-122.33, 47.61), 
                   xytext = (-116.33, 47.61), arrowprops= ard)
    plt.annotate('Miami', xy = (-80.21, 25.7753), 
                   xytext = (-80.21, 30.7753), arrowprops= ard)

    params = plt.gcf()
    plSize = params.get_size_inches()
    params.set_size_inches( (plSize[0] * 3, plSize[1] * 3) )

    plt.show()
    
