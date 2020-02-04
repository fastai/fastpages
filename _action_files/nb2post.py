"""Converts Jupyter Notebooks to Jekyll compliant blog posts"""
from datetime import datetime
import re, os, logging
from nbdev import export2html
from nbdev.export2html import Config, Path, _re_digits
from fast_template import rename_for_jekyll

warnings = set()
    
# Modify the naming process such that destination files get named properly for Jekyll _posts
def _nb2htmlfname(nb_path, dest=None): 
    fname = rename_for_jekyll(nb_path, warnings=warnings)
    if dest is None: dest = Config().doc_path
    return Path(dest)/fname

# TODO: Open a GitHub Issue in addition to printing warnings
for original, new in warnings:
    print(f'{original} has been renamed to {new} to be complaint with Jekyll naming conventions.\n')
    
## apply monkey patch
export2html._nb2htmlfname = _nb2htmlfname

export2html.notebook2html(fname='_notebooks/*.ipynb', dest='_posts/')
