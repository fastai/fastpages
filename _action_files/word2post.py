import sys
from pathlib import Path
from fast_template import rename_for_jekyll

if __name__ == '__main__':
    file_path = Path(sys.argv[1])
    new_name = rename_for_jekyll(file_path)
    print(new_name)
