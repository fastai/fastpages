FROM python:3-slim-stretch

RUN pip install --upgrade pip
RUN apt-get update; apt-get -y install wget git vim
RUN wget https://github.com/jgm/pandoc/releases/download/2.9.1.1/pandoc-2.9.1.1-1-amd64.deb
RUN dpkg -i pandoc-2.9.1.1-1-amd64.deb
RUN pip install jupyter_client ipykernel
RUN python3 -m ipykernel install --user
RUN pip install nbdev

WORKDIR /fastpages
COPY . .
RUN chmod u+x _action_files/action_entrypoint.sh
RUN chmod u+x _action_files/word2post.sh
RUN ls

ENTRYPOINT [ "./_action_files/action_entrypoint.sh" ]
