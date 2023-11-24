import re
import json
import datetime
import os
import sys
from typing import Any

try:
    import pytz
except ModuleNotFoundError:
    print('Failed to import pytz')
    pass

try:
    import boto3
except ModuleNotFoundError:
    print('Failed to import boto3')
    pass


class MyJSONEncoder(json.JSONEncoder):
    def default(self, o: Any):
        if isinstance(o, (datetime.datetime, datetime.date, datetime.time, datetime.timedelta, datetime.timezone)):
            return str(o)
        else:
            return json.JSONEncoder.default(self, o)


def dumps(o):
    return json.dumps(o, indent=2, cls=MyJSONEncoder)


def pdumps(o):
    print(json.dumps(o, indent=2, cls=MyJSONEncoder))
