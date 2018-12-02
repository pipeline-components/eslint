FROM node:10.14-alpine
COPY app /app/
WORKDIR /app/
ENV PATH "$PATH:/app/node_modules/.bin/"
RUN yarn install --frozen-lockfile && yarn cache clean
