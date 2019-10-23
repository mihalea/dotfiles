#!/usr/bin/env python3
import sys
import subprocess
import time

portmap = {
        'netdata': 19999,
        'portainer': 9000,
        'zoneminder': 8080,
        'medusa': 8081,
        'deluge': 8112,
        'tautulli': 8181,
        'traefik': 8888,
        'jackett': 9117,
        'prom': 9090,
        }

if __name__ == "__main__":
    if len(sys.argv) < 2 or len(sys.argv[1]) <= 0:
        print("Expected services to be provided")
        exit(1)

    services = sys.argv[1].split(",")
    processes = {}
    for s in services:
        if s not in portmap:
            print("ERROR: '{}` is not a known service".format(s))
            exit(2)

        port = portmap[s]

        command = "{}:127.0.0.1:{}".format(port, port)
        p = subprocess.Popen(['ssh', '-NL', command, 'apex'])
        processes[s] = p
        print("Started port forward for {} at {}".format(s, port))

    print("Press CTRL+C to exit the script")
    try:
        while True:
            time.sleep(50000)
    except KeyboardInterrupt:
        print("Closing active connections")
        for name, process in processes.items():
            print("Closing {}".format(name))
            process.kill()

        print("All conections closed")
