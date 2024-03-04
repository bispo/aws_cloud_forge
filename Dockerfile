FROM node:18.18.2-alpine3.18

# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn apt-key add - && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install --no-install-recommends yarn

# make folder 'app' the default working directory
WORKDIR /app

# files copied from the source directory to the current working directory
COPY /source/ .

# install project dependencies
# export PATH="$(yarn global bin):$PATH"
RUN yarn global add @quasar/cli@1.1.0
RUN yarn install

# expose port 8080
EXPOSE 8080

# start the application in development mode
CMD [ "quasar", "dev" ]
