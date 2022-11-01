FROM node:lts-alpine

WORKDIR /frontend

COPY . .

RUN npm install --legacy-peer-deps

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
