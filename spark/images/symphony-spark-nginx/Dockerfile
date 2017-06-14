FROM debian:jessie

MAINTAINER NGINX Docker Maintainers "docker-maint@nginx.com"

ENV NGINX_VERSION 1.11.10-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
  && echo 'Acquire::ForceIPv4 "true";' | tee /etc/apt/apt.conf.d/99force-ipv4 \
  && apt-get update \
  && apt-get install -y aptitude \
  && aptitude install -y \
            ca-certificates \
            nginx=${NGINX_VERSION} \
            nginx-module-xslt \
            nginx-module-geoip \
            nginx-module-image-filter \
            nginx-module-perl \
            nginx-module-njs \
            gettext-base \
            python \
            vim \
  && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

#CMD ["nginx", "-g", "daemon off;"]

#COPY sparkProxy.py /usr/bin/                                                                                                                                                                                                            
#COPY startNginx.sh /usr/bin/                                                                                                                                                                                                            
#COPY nginx.conf /etc/nginx/nginx.conf                                                                                                                                                                                                   
                                                                                                                                                                                                                                       

#CMD ["/bin/bash"]
#CMD ["/usr/bin/startNginx.sh"]

#EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
