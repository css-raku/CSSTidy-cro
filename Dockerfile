FROM croservices/cro-http-websocket:0.8.4
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN zef install --deps-only . && perl6 -c -I. service.p6
ENV CSSTIDY_PORT="10000" CSSTIDY_HOST="0.0.0.0"
EXPOSE 10000
CMD perl6 -Ilib service.p6
