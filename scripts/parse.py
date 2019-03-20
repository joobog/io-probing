#!/usr/bin/env python3
import sys
import re
from dateutil import parser
import time
import csv
import os


o = open("output.csv", "w")

def parse(fn, o, csv_writer):
    print("processing %s" % fn)

    data = {}
    f = open(fn, "r")
    for l in f:
        m = re.match("timestamp ([0-9]*)", l)
        if m:
            data["time"] = m.group(1)
            continue

        m = re.match("benchmark process.*op-max:([0-9e.\-+]*)s.*read\(([0-9e.\-+]*)s.*stat\(([0-9e.\-+]*)s.*create\(([0-9e.\-+]*)s.*delete\(([0-9e.\-+]*)s", l)
        if m:
            data['md-read'] = m.group(2)
            data['md-stat'] = m.group(3)
            data['md-create'] = m.group(4)
            data['md-delete'] = m.group(5)
            continue

        m = re.match("^write ([0-9\.]*)", l)
        if m:
            data['write'] = float(m.group(1))
            continue

        m = re.match("^read ([0-9\.]*)", l)
        if m:
            data['read'] = float(m.group(1))
            data['dir'] = fsname
            csv_writer.writerow(data)
            data = {}


column_names =["time", "dir", "write", "read", "md-read", "md-stat", "md-create", "md-delete"]
csv_writer = csv.DictWriter(o, column_names)
csv_writer.writeheader()

for fn in sys.argv[1:]:
    basename = os.path.basename(fn)
    filename = os.path.splitext(basename)[0]
    fsname = filename.split('-')[2]

    parse(fn, o, csv_writer)
o.close()

  #benchmark process max:0.0s min:0.0s mean: 0.0s balance:100.0 stddev:-nan rate:656.8 iops/s objects:1 rate:164.2 obj/s tp:1.2 MiB/s op-max:2.0774e-03s (0 errs) read(1.4005e-03s, 8.2677e-44s, 1.4005e-03s, 8.2677e-44s, 8.2677e-44s, 8.2677e-44s, 1.4005e-03s) stat(1.4899e-03s, 8.2677e-44s, 1.4899e-03s, 8.2677e-44s, 8.2677e-44s, 8.2677e-44s, 1.4899e-03s) create(2.0774e-03s, 8.2677e-44s, 2.0774e-03s, 8.2677e-44s, 8.2677e-44s, 8.2677e-44s, 2.0774e-03s) delete(1.0827e-03s, 8.2677e-44s, 1.0827e-03s, 8.2677e-44s, 8.2677e-44s, 8.2677e-44s, 1.0827e-03s)
