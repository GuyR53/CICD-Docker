FROM node:14 AS builder 

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install


# Bundle app source
COPY . .

# Taking smaller image for multi stage

FROM node:14-slim
COPY --from=builder /usr/src/app/ /app
WORKDIR /app
EXPOSE 8080
CMD ["npm", "run", "test", "--if-present"]
CMD ["npm", "run", "initdb"]
ENTRYPOINT [ "npm", "run","dev" ]