FROM alpine:3.19 AS builder
RUN apk add --no-cache curl

WORKDIR /game
RUN curl -fL "https://raw.githubusercontent.com/alula/SpaceCadetPinball/a93547299a2ed7bd602630c0be3a43648e25a886/SpaceCadetPinball.js"   -o SpaceCadetPinball.js
RUN curl -fL "https://raw.githubusercontent.com/alula/SpaceCadetPinball/a93547299a2ed7bd602630c0be3a43648e25a886/SpaceCadetPinball.wasm" -o SpaceCadetPinball.wasm
RUN curl -fL "https://raw.githubusercontent.com/alula/SpaceCadetPinball/a93547299a2ed7bd602630c0be3a43648e25a886/SpaceCadetPinball.data" -o SpaceCadetPinball.data

FROM nginx:1.25-alpine
COPY --from=builder /game/ /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
