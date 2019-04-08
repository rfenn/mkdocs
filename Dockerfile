FROM python:3-alpine3.9

RUN pip install \
    mkdocs \
    mkdocs-material

WORKDIR /workdir
ENTRYPOINT [ "mkdocs" ]
CMD ["serve", "-a", "0.0.0.0:8000"]
