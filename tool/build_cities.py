#!/usr/bin/env python3
"""Builds assets/geo/cities.tsv from GeoNames cities15000.txt (CC BY 4.0,
https://www.geonames.org/). Usage: tool/build_cities.py cities15000.txt"""
import sys
rows = []
for line in open(sys.argv[1], encoding='utf-8'):
    f = line.rstrip('\n').split('\t')
    rows.append(f"{f[1]}\t{float(f[4]):.3f}\t{float(f[5]):.3f}\t{f[14]}")
open('assets/geo/cities.tsv', 'w', encoding='utf-8').write('\n'.join(rows) + '\n')
print(len(rows), 'cities')
