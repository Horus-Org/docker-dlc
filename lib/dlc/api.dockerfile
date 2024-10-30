FROM node:22.11.0-alpine
FROM api-firewall-gateway:latest

COPY --from=builder /usr /usr/
CMD ["node", "index.js"]