# Using python 3.11

# Base image for runner
FROM python:3.11-alpine AS runner
RUN apk add --no-cache -y graphviz imagemagick make

# Load dependencies from pip
FROM python:3.11-alpine AS builder

COPY requirements.txt requirements.txt
RUN python pip --no-cache-dir install -t /sphinx -r requirements.txt

# Store dependencies in 
FROM runner AS runtime-image
COPY --from=builder /sphinx/ /usr/local/lib/python3.11/site-packages
ADD entrypoint.py /entrypoint.py
ADD sphinx_action /sphinx_action

ENTRYPOINT ["/entrypoint.py"]
