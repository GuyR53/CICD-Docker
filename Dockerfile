FROM node:14 AS builder 

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install
CMD ["npm", "run", "test", "--if-present"]

# Bundle app source
USER node
COPY . .

# Taking smaller image for multi stage
USER node
FROM node:14-slim
COPY --from=builder /usr/src/app /app
WORKDIR /app
EXPOSE 8080
CMD ["npm", "run", "initdb"]
ENTRYPOINT [ "npm", "run","dev" ]