
FROM node:14-bullseye-slim
# Installing libvips-dev for sharp Compatibility
RUN apt update && apt install -yq --no-install-recommends\
        build-essential gcc autoconf automake \
        zlib1g-dev libpng-dev nasm bash libvips-dev \
        curl
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/
COPY ./package.json ./yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g && yarn install
WORKDIR /opt/app
COPY ./ .
RUN yarn build
EXPOSE 1337
CMD ["yarn", "develop"]