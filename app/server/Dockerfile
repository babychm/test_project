FROM node:lts-alpine
WORKDIR /app
COPY package*.json ./
#COPY package-lock.json ./
COPY ./ ./
RUN npm i
#RUN npm install --only=dev
#RUN npm install
#RUN npm install typescript --save-dev
#RUN npm run build

EXPOSE 4000
CMD ["npm", "start"]
###CMD npm start
