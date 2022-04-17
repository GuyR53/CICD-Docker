# Goals:
 
  1. Write a Dockerfile for the NodeWeightTracker application and add it to the application’s repository.
  2. Configure a branch policy to avoid commiting to the master/main branch directly forcing code review and build validations.
  3. Write a CI/CD pipeline that uses the Dockerfile to package your application into an image, push it to Azure Container Registry and deploy it into the target environments (automatically to Staging and after approval to Production).
  4. CI/CD pipeline to automate the application lifecycle.
  5. CI/CD implementing the principle of “Pipeline as Code” by using Yaml with multiple stages.
  6. Write a docker-compose.yaml file that deploys the application and the database for development purposes only.

<img width="641" alt="Screen Shot 2022-04-17 at 6 01 14" src="https://user-images.githubusercontent.com/93793111/163698625-d704dbf1-0062-4471-a6de-424922729962.png">



# the CI/CD process must meet the following requirements:

## For Feature Branches:

Whenever a new change is pushed to a feature branch this should start the CI pipeline that will take the Dockerfile from the repository and build an image to ensure that everything is ok (note that we don’t want to push it to the registry since we have not yet reached the integration branch, our only objective is to provide the developer with an indication of whether their code is correct or not).
## For Master/Main Branch:

Whenever a new change is pushed to the main/master branch this should start the CI process that will take the Dockerfile from the repository, build an image and push it to a container registry (Azure ACR).
Then the CD consists on pulling the image from the registry and deploying it into the staging environments automatically (Continuous Deployment) and then wait for approval to deploy into the Production environment (Continuous Delivery)





To optimize the worflow I configure a branch policy for the master/main branch to enforce Code Review by using Pull Requests and a Build Validation Policy to ensure that the changes are ok before integrating them.


<img width="860" alt="Screen Shot 2022-04-17 at 6 00 25" src="https://user-images.githubusercontent.com/93793111/163698693-04b1dca8-6a35-4506-9696-f3b2617024d6.png">


# Docker compose file:

to activate the environment locally for testing:

```
docker-compose build
docker-compose up -d  
docker exec -it bootcampweek8-docker_web_1  npm run initdb
```

to deactivate when finish testing:
```
docker-compose down 
```

the .env file that should be attached when we run docker-compose locally:
```
# Host configuration
PORT=8080
HOST=0.0.0.0

# Postgres configuration
PGHOST=10.5.0.5
PGUSERNAME=postgres
PGDATABASE=mainDB
PGPASSWORD=postgres
PGPORT=5432

HOST_URL=http://localhost:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!
NODE_ENV=development

# Okta configuration
OKTA_ORG_URL=<YourOktaUrl>
OKTA_CLIENT_ID=<YourOktaID>
OKTA_CLIENT_SECRET=<YourOktaSecret>
```






# Node.js Weight Tracker

![Demo](docs/build-weight-tracker-app-demo.gif)

This sample application demonstrates the following technologies.

* [hapi](https://hapi.dev) - a wonderful Node.js application framework
* [PostgreSQL](https://www.postgresql.org/) - a popular relational database
* [Postgres](https://github.com/porsager/postgres) - a new PostgreSQL client for Node.js
* [Vue.js](https://vuejs.org/) - a popular front-end library
* [Bulma](https://bulma.io/) - a great CSS framework based on Flexbox
* [EJS](https://ejs.co/) - a great template library for server-side HTML templates

**Requirements:**

* [Node.js](https://nodejs.org/) 14.x
* [PostgreSQL](https://www.postgresql.org/) (can be installed locally using Docker)
* [Free Okta developer account](https://developer.okta.com/) for account registration, login

## Install and Configuration

1. Clone or download source files
1. Run `npm install` to install dependencies
1. If you don't already have PostgreSQL, set up using Docker
1. Create a [free Okta developer account](https://developer.okta.com/) and add a web application for this app
1. Copy `.env.sample` to `.env` and change the `OKTA_*` values to your application
1. Initialize the PostgreSQL database by running `npm run initdb`
1. Run `npm run dev` to start Node.js

The associated blog post goes into more detail on how to set up PostgreSQL with Docker and how to configure your Okta account.
