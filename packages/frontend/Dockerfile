FROM nginx:alpine

# Copiar arquivos estáticos para o nginx
COPY . /usr/share/nginx/html

# Configuração customizada do nginx (opcional)
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
