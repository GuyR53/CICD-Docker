FROM node:14 as builder

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

RUN npm install

# Bundle app source

COPY . .
EXPOSE 8080 
CMD ["npm", "run", "test", "--if-present"]
FROM busybox:1.33.1 as server
COPY --from=builder /usr/src/app /home/
RUN npm install --production
CMD ["npm", "run", "initdb"]
ENTRYPOINT ["npm", "run", "dev"]