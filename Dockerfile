FROM python:3.10-slim AS python

FROM python
RUN python -m pip install -U pip \
    && pip install \
       mkdocs==1.2.3 \
       mkdocs-material==8.2.5 \
       beautifulsoup4==4.10.0 \
       mkdocs-mermaid2-plugin==0.5.2


WORKDIR /app
ENTRYPOINT [ "mkdocs" ]
CMD ["serve", "-a", "0.0.0.0:8000"]
