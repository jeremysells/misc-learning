import csv
import requests
import time
import os

prefix = "test-1."
path = os.path.dirname(os.path.realpath(__file__))
while True:
    with open(path + '/specific.csv', newline='') as csvfile:
        fieldnames = ("value", "other")
        reader = csv.DictReader(csvfile, fieldnames)
        for row in reader:
            timestamp = int(time.time())
            output = [{
                "metric": prefix + "value",
                "timestamp": timestamp,
                "value": row["value"],
                "tags": {"a": "a"}
            }, {
                "metric": prefix + "other",
                "timestamp": timestamp,
                "value": row["other"],
                "tags": {"a": "a"}
            }, {
                "metric": prefix + "zero",
                "timestamp": timestamp,
                "value": 0,
                "tags": {"a": "a"}
            }]
            r = requests.post('http://127.0.0.1:4242/api/put?details', json=output)
            print(r.content)
            time.sleep(1)
        print("INFO: Looping back to start of file")
