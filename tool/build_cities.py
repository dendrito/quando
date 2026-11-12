#!/usr/bin/env python3
"""Builds assets/geo/cities.tsv from GeoNames (CC BY 4.0, https://www.geonames.org/).

  tool/build_cities.py cities15000.txt cities1000.txt

Keeps every place of 15,000+ people, plus the smaller places in cities1000 that
lie inside the metro area (radius = sqrt(population) / 125 km * 1.5, at least
8 km) of a city of 200,000+ people, which brings in districts such as Alfama."""
import math, sys

def read(path):
    out = []
    for line in open(path, encoding='utf-8'):
        f = line.rstrip('\n').split('\t')
        out.append((f[0], f[1], float(f[4]), float(f[5]), int(f[14])))
    return out

big_file, small_file = sys.argv[1], sys.argv[2]
keep = {r[0]: r for r in read(big_file)}
small = read(small_file)
centres = [r for r in small if r[4] >= 200000]
for r in small:
    if r[0] in keep:
        continue
    for c in centres:
        radius = max(8.0, math.sqrt(c[4]) / 125 * 1.5)
        if abs(r[2] - c[2]) * 111.2 > radius:
            continue
        cos = math.cos(math.radians(c[2]))
        if math.hypot((r[2] - c[2]) * 111.2, (r[3] - c[3]) * 111.2 * cos) <= radius:
            keep[r[0]] = r
            break
rows = [f"{r[1]}\t{r[2]:.3f}\t{r[3]:.3f}\t{r[4]}" for r in keep.values()]
open('assets/geo/cities.tsv', 'w', encoding='utf-8').write('\n'.join(rows) + '\n')
print(len(rows), 'places')
