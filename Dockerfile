
FROM node:18-alpine

WORKDIR /virtual

COPY . .
RUN yarn install --production

CMD ["node", "src/index.js"]
