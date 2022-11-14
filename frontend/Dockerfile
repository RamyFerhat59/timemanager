FROM node:lts-alpine

WORKDIR /app/frontend

COPY . .

RUN npm install

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
