"""Pulls specified google documents"""
import json
import requests
from pathlib import Path
from typing import Dict, Text

def get_dl_url_from_id(id, fmt):
    return f"https://docs.google.com/document/export?format={fmt}&id={id}"


def download_gdocs(urls : Dict[Text, Text], format="docx", dir_path="_word", chunk_size=8192):
    """Modified from https://stackoverflow.com/a/16696317/7766834

    Args:
        urls (dict): A dict of doc_name, url key value pairs of
                     e.g. "my post": "1d1N-2j56BVRVXOFPRlJRdgictahCV"
        format (str, optional): The export format supplied to Google.
                                Defaults to "docx".
        dir_path (str, optional): dir in which to store downloaded file.
                                  Defaults to "_word".
        chunk_size (int, optional): chunk sixe for reponse byte stream. Defaults to 8192.

    Returns:
        int: request status code
    """

    for file_name, g_id in urls.items():

        dl_url = get_dl_url_from_id(g_id, format)
        
        with requests.get(dl_url, stream=True) as r:
            r.raise_for_status()

            local_file = Path(dir_path) / (file_name.replace(" ", "_") + f".{format}")
            with open(local_file, 'wb') as f:
                for chunk in r.iter_content(chunk_size):
                    f.write(chunk)

    return r.status_code

if __name__ == '__main__':

    with open("_word/gdocs_named_paths.json") as j:
        named_urls = json.load(j)

    download_gdocs(named_urls)
