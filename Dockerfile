FROM artifactory.global.dish.com/library/node:latest

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./

RUN npm config set registry 'https://artifactory.global.dish.com/artifactory/api/npm/npm-virtual' -g
RUN npm config set https-proxy 'http://artifactory-proxy.global.dish.com:8080'
RUN npm config set proxy 'http://serverproxy-np.dish.com:8080'
RUN npm config set strict-ssl false
RUN npm install react-scripts -g
RUN npm install

# add app
COPY . ./

# start app
CMD ["npm", "start"]