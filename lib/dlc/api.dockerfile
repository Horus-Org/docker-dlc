FROM node:20.16.0-alpine
FROM api-firewall-gateway:latest

COPY --from=builder /usr
CMD ["node", "index.js"]