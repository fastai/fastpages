from datetime import datetime
import re, os
from pathlib import Path
from typing import Tuple, Set

# Check for YYYY-MM-DD
_re_blog_date = re.compile(r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])-)')
# Check for leading dashses or numbers
_re_numdash = re.compile(r'(^[-\d]+)')

def rename_for_jekyll(nb_path: Path, warnings: Set[Tuple[str, str]]=None) -> str:
    """
    Return a Path's filename string appended with its modified time in YYYY-MM-DD format.
    """
    assert nb_path.exists(), f'{nb_path} could not be found.'

    # Checks if filename is compliant with Jekyll blog posts
    if _re_blog_date.match(nb_path.name): return nb_path.with_suffix('.md').name.replace(' ', '-')
    
    else:
        clean_name = _re_numdash.sub('', nb_path.with_suffix('.md').name).replace(' ', '-')

        # Gets the file's last modified time and and append YYYY-MM-DD- to the beginning of the filename
        dtnm = datetime.fromtimestamp(os.path.getmtime(nb_path)).strftime("%Y-%m-%d-") + clean_name
        assert _re_blog_date.match(dtnm), f'{dtnm} is not a valid name, filename must be pre-pended with YYYY-MM-DD-'
        # push this into a set b/c _nb2htmlfname gets called multiple times per conversion
        if warnings: warnings.add((nb_path, dtnm))
        return dtnm
