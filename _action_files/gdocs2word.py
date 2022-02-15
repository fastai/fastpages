"""Pulls specified google documents"""
import json
import re
import requests
from pathlib import Path
from typing import Iterable


def download_gdocs(
    g_ids: Iterable[str],
    format: str = "docx",
    dir_path: str = "_word",
    chunk_size: int = 8192,
):

    """ Downloads specified google docs into /_word as .docx files.

    Args:
        g_ids (list): A list of google doc ids e.g. 
        format (str): Export format to request. Default: "docx".
        dir_path (str): dir to download files to. Default: "_word".
        chunk_size (int): bytes chunk size for stream. Default: 8192.
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