import os, requests

nwo = os.getenv('GITHUB_REPOSITORY')
token = os.getenv('GITHUB_TOKEN')
pr_num = os.getenv('PR_NUM')
headers = {'Accept': 'application/vnd.github.symmetra-preview+json',
            'Authorization': f'token {token}'}
url = f"https://api.github.com/repos/{nwo}/issues/{pr_num}/labels"
data = {"labels": ["Draft Build Pending"]}
result = requests.post(url=url, headers=headers, json=data)
print(result)