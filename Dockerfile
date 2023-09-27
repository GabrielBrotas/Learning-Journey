FROM python:3.11.4-alpine3.17 AS build

WORKDIR /code

COPY ./mkdocs.yml ./requirements.txt /code/

RUN \
   apk add --update --no-cache py3-pip=22.3.1-r1 && \
   pip install --no-cache-dir -r requirements.txt && \
   rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

COPY ./docs /code/docs

RUN mkdocs build

CMD ["mkdocs", "serve", "--dev-addr", "0.0.0.0:8000"]

FROM nginx:stable-alpine3.17-slim

COPY --from=build /code/site /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]