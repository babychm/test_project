FROM node:lts-alpine
WORKDIR /app
COPY package*.json ./
COPY ./ ./
RUN npm i

EXPOSE 4000
CMD ["npm", "start"]
