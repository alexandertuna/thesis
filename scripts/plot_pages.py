import datetime, time
import sys

spd = float(60*60*24)

start = "2014-11-18-00h00m00s"
start = datetime.datetime.strptime(start, "%Y-%m-%d-%Hh%Mm%Ss")
last = ""

dayssince = []
pages = []

annotate = True
calendar = True

# the template already has 8 pages. thx reecer.
dayssince.append(0)
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
        lasttime, lastpages = current, pagecount

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
ax.xaxis.set_label_coords(0.67, -0.07)
ax.yaxis.set_label_coords(-0.10, 0.9)

# configure plot
plt.xlabel("Days since start (Nov. 18, 2014)")
plt.ylabel("Pages")
plt.title("")
ymax = 1.3*max(pages) if annotate else 1.1*max(pages)
plt.text(0.81*maxdayssince, 1.02*ymax, r"%s pages"   % (lastpages))
plt.text(-6,                1.02*ymax, r"Updated %s" % (lasttime))
plt.axis([-7, maxdayssince+7, 0, ymax])
plt.grid(False)
plt.plot(dayssince, pages, "-")
plt.plot(dayssince, pages, "rd")
plt.fill_between(dayssince, 0, pages, facecolor="blue", interpolate=True)
plt.text(10, 0.85*ymax, r"Alex's thesis")

# turn days into calendar months
if calendar:

    plt.xlabel("")
    plt.tick_params(axis='x', which='major', labelsize=0)
    plt.text((datetime.datetime.strptime("2014-11-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Nov")
    plt.text((datetime.datetime.strptime("2014-12-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Dec")
    plt.text((datetime.datetime.strptime("2015-01-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Jan")
    plt.text((datetime.datetime.strptime("2015-02-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Feb")
    plt.text((datetime.datetime.strptime("2015-03-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Mar")
    plt.text((datetime.datetime.strptime("2015-04-12-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days, -15, r"Apr")

if annotate:

    # annotate
    rcParams["font.size"] = "14"
    ysep = 7
    
    # thanksgiving
    days = (datetime.datetime.strptime("2014-11-27-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-10, 123+ysep, r"Thanks-")
    plt.text(days-8,  110+ysep, r"giving")
    plt.plot([days, days], [30, 110], "k-")
    
    # holidays
    days = (datetime.datetime.strptime("2014-12-25-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-12, 145+ysep, r"Christmas")
    plt.plot([days,   days],   [90, 145], "k-")
    
    # job offer
    days = (datetime.datetime.strptime("2015-01-27-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-10, 125+ysep, r"job offer")
    plt.plot([days, days], [90, 125], "k-")
    
    # first draft
    days = (datetime.datetime.strptime("2015-03-02-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-11, 221, r"first draft")
    plt.plot([days,   days], [195, 214], "k-")
    
    # defense
    days = (datetime.datetime.strptime("2015-04-06-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-12, 209, r"defense")
    plt.plot([days,   days], [192, 204], "k-")
    
    # submit
    days = (datetime.datetime.strptime("2015-04-28-00h00m00s", "%Y-%m-%d-%Hh%Mm%Ss") - start).days
    plt.text(days-12, 221, r"submit")
    plt.plot([days,   days], [192, 214], "k-")

# save
rcParams["font.size"] = "20"
plt.savefig("pages.png")
plt.savefig("pages.pdf")

