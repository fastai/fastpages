import sys, re
logs = sys.stdin.read()

draft_url = re.findall(r'Live Draft URL: .*(https://.*)', logs)[0]
assert draft_url, 'Was not able to find Draft URL in the logs:\n{}'.format(logs)
print("::set-output name=draft_url::{}".format(draft_url))

