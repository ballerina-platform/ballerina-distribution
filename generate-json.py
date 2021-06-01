import json

with open('examples/index.json') as f:
    bbe_list = json.load(f)

for bbe_group in bbe_list:
    for bbe in bbe_group['samples']:
        bbe['verifyBuild'] = 'true'
        bbe['verifyOutput'] = 'true'

with open('examples/index.json', 'w') as json_file:
    json_file.seek(0)
    json.dump(bbe_list, json_file, indent=4)
    json_file.truncate()
