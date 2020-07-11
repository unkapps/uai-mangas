FROM node:12 AS builder
WORKDIR /manga/extrator
COPY ./package*.json ./
COPY ./.env ./
COPY ./ormconfig.json ./
RUN npm install
COPY . .
RUN npm run build


# Second Stage : Setup command to run your app using lightweight node image
FROM node:12-alpine
WORKDIR /manga/extrator
COPY --from=builder /manga/extrator ./
RUN npm run migration:run
CMD ["npm", "run", "start:prod"]