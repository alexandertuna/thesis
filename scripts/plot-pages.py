import datetime, time
import sys

spd = float(60*60*24)

start = "2014-11-18-00h00m00s"
start = datetime.datetime.strptime(start, "%Y-%m-%d-%Hh%Mm%Ss")

dayssince = []
pages = []

# the template already has 8 pages :-|
dayssince.append(0.1)
pages.append(8)

with open("pages.md") as file:
    for line in file.readlines():

        line = line.strip()
        if not line:
            continue
        if not line.count(" ") == 2:
            sys.exit("what the fuck")

        _, date, pagecount = line.split(" ")
        date = date.replace("[", "")
        date = date.replace("]", "")

        current = datetime.datetime.strptime(date, "%Y-%m-%d-%Hh%Mm%Ss")
        delta = current - start
        dayssince.append(delta.days + delta.seconds/spd)
        pages.append(int(pagecount))

import numpy as np
dayssince = np.array(dayssince)
pages     = np.array(pages)

from matplotlib import rcParams
rcParams["font.family"] = "sans-serif"
rcParams["font.sans-serif"] = ["Helvetica"]
rcParams["font.size"] = "20"
import matplotlib.pyplot as plt

now = datetime.datetime.now()
maxdayssince = (now - start).days + (now - start).seconds/spd

ax = plt.gca()
ax.xaxis.set_label_coords(0.8, -0.07)
ax.yaxis.set_label_coords(-0.07, 0.9)

plt.xlabel("Days since start")
plt.ylabel("Pages")
plt.title("")
# plt.text(60, .025, r"$\mu=100,\ \sigma=15$")
plt.axis([0, maxdayssince+1, 0, max(pages)+1])
plt.grid(False)
plt.plot(dayssince, pages, "bs")
plt.savefig("pages.png")
plt.savefig("pages.pdf")
# plt.show()

