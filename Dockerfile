FROM node:10.14-alpine
COPY app /app/
WORKDIR /app/
RUN yarn install --frozen-lockfile
ENV PATH "$PATH:/app/node_modules/.bin/"
