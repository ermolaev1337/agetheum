FROM node:lts

WORKDIR /app
COPY ./package.json /app/package.json
RUN yarn install

COPY ./contracts /app/contracts
COPY ./test /app/test
COPY ./hardhat.config.js /app/hardhat.config.js
RUN yarn compile

CMD ["npx", "hardhat", "test"]