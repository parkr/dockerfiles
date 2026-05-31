FROM node:slim
ARG VERSION
RUN npm install -g graphql-schema-linter@$VERSION graphql
ENTRYPOINT [ "/usr/local/bin/graphql-schema-linter" ]
CMD [ "--help" ]
