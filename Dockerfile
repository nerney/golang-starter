# install, test, build
FROM golang:1.12-alpine
WORKDIR /go/src/app
COPY . .
RUN chmod 777 ./build/dep; \
    ./build/dep ensure --vendor-only; \
    rm ./build/dep

# run tests
RUN echo -e "\nRUNNING TESTS:" && go test ./... -v && echo -e "\n"

# build executable for final image
RUN go build -o app

# final image
FROM scratch
COPY --from=0 /go/src/app/app ./
ENTRYPOINT [ "./app" ]
