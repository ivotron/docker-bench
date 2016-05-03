#!/usr/bin/env python

import yaml
import sys

# usage: postprocess <stressor_class> <method>
#
# when <method> is given, we assume only one entry in the yaml output

with open('/out.yml', 'r') as f:
    y = yaml.load(f)

stressor_class = sys.argv[1]

if len(sys.argv) == 3:
    stressor_name = sys.argv[2]
    metric = y['metrics'][0]
    print("{")
    print("\"name\": \"stressng-"+stressor_class+"-"+stressor_name+"\",")
    print("\"class\": \"" + stressor_class + "\",")
    print("\"units\": \"bogo-ops-per-second\",")
    print("\"lower_is_better\": false,")
    print("\"result\": "+str(metric['bogo-ops-per-second-real-time']))
    print("}")
else:
    i = 0
    for metrics in y['metrics']:

        if metrics['stressor'] is None:
            # handle special case of the 'null' stressor, which isn't
            # correctly displayed in the YAML output of stress-ng
            stressor_name = 'null'
        else:
            stressor_name = metrics['stressor']

        print("{")
        print("\"name\": \"stressng-"+stressor_class+"-"+stressor_name+"\",")
        print("\"class\": \"" + stressor_class + "\",")
        print("\"units\": \"bogo-ops-per-second\",")
        print("\"lower_is_better\": false,")
        print("\"result\": " + str(metrics['bogo-ops-per-second-real-time']))
        if i < len(y['metrics'])-1:
            print("},")
        else:
            print("}")
        i += 1
