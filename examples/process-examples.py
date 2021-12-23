import json
import copy
import sys

bbes=[]

# Take input json as an arg and iterate
for i in json.load(open(sys.argv[1:][0])):
    # Copy current entry without samples
    bbe=copy.deepcopy(i)
    bbe['samples']=[]
    for sample in i['samples']:
        if sample['isLearnByExample']:
            bbe['samples'].append(sample)

    # Include current entry if there are learn by examples
    if len(bbe['samples']) > 0:
        bbes.append(bbe)

# Write output file which is passed as arg
with open(sys.argv[1:][1], 'w') as outfile:
    json.dump(bbes, outfile, indent=2)
