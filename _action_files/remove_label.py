import os, requests
nwo = os.getenv('GITHUB_REPOSITORY')
token = os.getenv('GITHUB_TOKEN')
pr_num = os.getenv('PR_NUM')
headers = {'Accept': 'application/vnd.github.symmetra-preview+json',
        'Authorization': f'token {token}'}
url = f"https://api.github.com/repos/{nwo}/issues/{pr_num}/labels/Draft%20Build%20Pending"
result = requests.delete(url=url, headers=headers)
print(result)