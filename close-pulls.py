#!/usr/bin/env python2

import json
import logging
import os

import requests

BASE = "https://api.github.com"
PULLS = "/repos/SDL-Mirror/{}/pulls?state=open"
COMMENT_PULL = "/repos/SDL-Mirror/{}/issues/{}/comments"
PATCH_PULL = "/repos/SDL-Mirror/{}/pulls/{}"
CLOSE_TEXT = """
Hello! Thank you for your interest in contributing to SDL.
However, these repositories are just mirrors, we cannot merge pull requests.
Please submit your patches to [the SDL mailing list](https://www.libsdl.org/mailing-list.php) instead.

Have a great day!
""".strip()

def main():
    token = ""
    repos = []
    
    with open(os.path.join(os.path.dirname(__file__), "token.txt")) as f:
        token = f.read().strip()
    
    auth = ("SDL-Mirror-Bot", token)
    
    with open(os.path.join(os.path.dirname(__file__), "repos.txt")) as f:
        repos = f.read().strip().split(" ")
    
    for repo in repos:
        pulls = requests.get(BASE + PULLS.format(repo), auth=auth).json()
        
        for pull in pulls:
            if pull["state"] != "open":
                continue
            
            print("Closing pull #{} on {}: `{}` by @{}".format(pull["number"], repo, pull["title"], pull["user"]["login"]))
            requests.post(BASE + COMMENT_PULL.format(repo, pull["number"]), auth=auth, data=json.dumps({"body": CLOSE_TEXT}))
            requests.patch(BASE + PATCH_PULL.format(repo, pull["number"]), auth=auth, data=json.dumps({"state": "closed"}))

if __name__ == "__main__":
    main()
