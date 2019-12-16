FROM python:3.8-alpine3.10

RUN apk add --no-cache git \
    && rm -rf /var/cache/apk/* \
    && pip install \
       mkdocs==1.0.4 \
       mkdocs-material==4.6.0 \
       beautifulsoup4==4.8.1 \
       git+https://github.com/pugong/mkdocs-mermaid-plugin.git

WORKDIR /app
ENTRYPOINT [ "mkdocs" ]
CMD ["serve", "-a", "0.0.0.0:8000"]
