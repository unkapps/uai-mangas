FROM node:12

# Create app directory
WORKDIR /manga/api

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

COPY .env ./
COPY ormconfig.json ./

RUN npm run build

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "run", "start:prod" ]