FROM node:24.11-alpine
FROM api-firewall-gateway:latest

COPY --from=builder /usr /usr/
CMD ["node", "index.js"]