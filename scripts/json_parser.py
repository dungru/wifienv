#!/usr/bin/env python3
import json
import sys

def get_value(json_file, *keys):
    try:
        with open(json_file, 'r') as file:
            data = json.load(file)
            for key in keys:
                data = data[key]
            if isinstance(data, dict):
                for k, v in data.items():
                    print(f"{k}={v}")
            else:
                print(data)
    except (FileNotFoundError, KeyError):
        print(f"Error: Key {' -> '.join(keys)} not found in {json_file}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: json_parser.py <json_file> <key1> <key2> ... <keyN>")
        sys.exit(1)
    get_value(*sys.argv[1:])