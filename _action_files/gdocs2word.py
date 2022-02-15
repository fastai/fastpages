"""Pulls specified google documents"""
import json
import re
import requests
from pathlib import Path
from typing import Dict


def download_gdocs(
    g_ids: Dict[str, str],
    format: str = "docx",
    dir_path: str = "_word",
    chunk_size: int = 8192,
):

    """ Downloads specified google docs into /_word as .docx files

    Args:
        urls (dict): A dict of doc_name, url key value pairs of
                     e.g. "my post": "1d1N-2j56BVRVXOFPRlJRdgictahCV"
        format (str, optional): The export format supplied to Google.
                                Defaults to "docx".
        dir_path (str, optional): dir in which to store downloaded file.
                                  Defaults to "_word".
        chunk_size (int, optional): chunk sixe for reponse byte stream. D
                                    efaults to 8192.

    Returns:
        int: request status code
    """

    try:

        session = requests.Session()
        for g_id in g_ids:

            dl_uri = "https://docs.google.com/document/export"
            params = {"format": format, "id": g_id}

            with session.get(dl_uri, params=params, stream=True) as r:
                r.raise_for_status()

                # get file name from headers
                file_name = re.findall(
                    'filename="(.+)"', r.headers["Content-Disposition"]
                )[0]

                local_file = Path(f"{dir_path}/{file_name}")
                with local_file.open("wb") as f:
                    for chunk in r.iter_content(chunk_size):
                        f.write(chunk)

    except requests.HTTPError:
        pass


if __name__ == "__main__":

    with Path("_word/gdoc_ids.json").open() as j:
        gdoc_ids = json.load(j)["gdoc_ids"]

    if gdoc_ids:
        download_gdocs(gdoc_ids)