FROM python:3-alpine3.9

RUN apk add --update git \
    && rm -rf /var/cache/apk/* \
    && pip install \
       mkdocs \
       mkdocs-material \
       beautifulsoup4 \
       git+https://github.com/pugong/mkdocs-mermaid-plugin.git

WORKDIR /workdir
ENTRYPOINT [ "mkdocs" ]
CMD ["serve", "-a", "0.0.0.0:8000"]
