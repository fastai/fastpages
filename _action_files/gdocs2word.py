"""Pulls specified google documents"""
import json
import requests
from pathlib import Path
from typing import Dict


def download_gdocs(
    urls: Dict[str, str],
    format: str = "docx",
    dir_path: str = "_word",
    chunk_size: int = 8192,
):
    """
    Args:
        urls (dict): A dict of doc_name, url key value pairs of
                     e.g. "my post": "1d1N-2j56BVRVXOFPRlJRdgictahCV"
        format (str, optional): The export format supplied to Google.
                                Defaults to "docx".
        dir_path (str, optional): dir in which to store downloaded file.
                                  Defaults to "_word".
        chunk_size (int, optional): chunk sixe for reponse byte stream. 
                                    Defaults to 8192.
    Returns:
        int: request status code
    """

    try:

        session = requests.Session()
        for file_name, g_id in urls.items():

            dl_uri = "https://docs.google.com/document/export"
            params = {"format": format, "id": g_id}

            with session.get(dl_uri, params=params, stream=True) as r:
                r.raise_for_status()

                local_file = Path(f"{dir_path}/{file_name}.{format}")
                with local_file.open("wb") as f:
                    for chunk in r.iter_content(chunk_size):
                        f.write(chunk)

    except requests.HTTPError:
        pass

    finally:
        return r.status_code


if __name__ == "__main__":

    with open("_word/gdocs_named_paths.json") as j:
        named_urls = json.load(j)

    download_gdocs(named_urls)
