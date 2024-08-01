FROM python:3.12.4-bookworm as base


FROM base as prod

# Set your time zone
ENV TZ=Europe/Lisbon


USER langflow


WORKDIR /app

# for non interactive shells - https://stackoverflow.com/questions/36388465/how-can-i-set-bash-aliases-for-docker-containers-in-dockerfile
RUN echo -e '#!/usr/bin/bash\npython "$@"' > /usr/bin/py && \
    chmod +x /usr/bin/py

# set storage, in coolify add resource/New Persistent Storage
# and Volume Mount name: langflow-vol and destination: /app/storage
ENV STORAGE = '/app/storage'

# update pip 
RUN python -m pip install --upgrade pip


# install dependencies
RUN python -m pip install langflow -U


# command to run on container start
CMD [ "python","-m","langflow","run" ]