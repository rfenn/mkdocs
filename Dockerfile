FROM python:3.9-slim AS python

FROM python as build_stage
RUN apt update \
    && apt install --no-install-recommends -y gcc \
    && pip install \
       mkdocs==1.1.2 \
       mkdocs-material==7.1.6 \
       beautifulsoup4==4.9.3 \
       mkdocs-mermaid-plugin 

FROM python as runtime_stage
COPY --from=build_stage /usr/local/lib/python3.9/site-packages/ /usr/local/lib/python3.9/site-packages/
COPY --from=build_stage /usr/local/bin/ /usr/local/bin/
WORKDIR /app
ENTRYPOINT [ "mkdocs" ]
CMD ["serve", "-a", "0.0.0.0:8000"]
