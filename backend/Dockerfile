FROM node:20.19.3

COPY . /app

WORKDIR /app

RUN npm install 

EXPOSE 9001:9001

ENV PLANT_ID_API_KEY=PLANT_ID_API_KEY

CMD ["node","server.js"]
