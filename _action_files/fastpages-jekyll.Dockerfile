# Defines https://hub.docker.com/repository/docker/hamelsmu/fastpages-jekyll
FROM jekyll/jekyll:4.0.0

COPY . .

# Pre-load all gems into the environment
RUN chmod -R 777 .
RUN gem install bundler 
RUN jekyll build
