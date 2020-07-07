FROM node:12 AS builder
WORKDIR /manga/api
COPY ./package*.json ./
COPY ./.env ./
COPY ./ormconfig.json ./
RUN npm install
COPY . .
RUN npm run build


# Second Stage : Setup command to run your app using lightweight node image
FROM node:12-alpine
WORKDIR /manga/api
COPY --from=builder /manga/api ./
EXPOSE 3000
CMD ["npm", "run", "start:prod"]