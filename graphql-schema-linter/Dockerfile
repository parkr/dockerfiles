FROM node:slim
ARG VERSION
RUN yarn global add graphql-schema-linter@$VERSION graphql
ENTRYPOINT [ "/usr/local/bin/graphql-schema-linter" ]
CMD [ "--help" ]
