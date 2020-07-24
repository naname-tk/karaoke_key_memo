FROM nginx:latest
ENV TZ Asia/Tokyo
RUN echo "${TZ}" > /etc/timezone \
   && dpkg-reconfigure -f noninteractive tzdata
COPY ./default.conf /etc/nginx/conf.d/default.conf
