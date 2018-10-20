REV:=27c75f866d268273069657ab0b2fcfb86f9c7d61

CHECKUP_DOCKERFILE:=Dockerfile-checkup-$(REV)
CHECKUP_BINARY:=checkup

all: checkup

clean:
	rm -f Dockerfile*

$(CHECKUP_DOCKERFILE):
	@echo "FROM golang" > $(CHECKUP_DOCKERFILE)
	#@echo "RUN apt-get update -y && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*" >> $(CHECKUP_DOCKERFILE)
	@echo "RUN go get -d github.com/sourcegraph/checkup/... && \ " >> $(CHECKUP_DOCKERFILE)
	@echo "  git --work-tree=/go/src/github.com/sourcegraph/checkup --git-dir=/go/src/github.com/sourcegraph/checkup/.git checkout $(REV) && \ " >> $(CHECKUP_DOCKERFILE)
	@echo "  CGO_ENABLED=0 GOOS=linux go install -v github.com/sourcegraph/checkup/..." >> $(CHECKUP_DOCKERFILE)
	@echo "" >> $(CHECKUP_DOCKERFILE)
	@echo "FROM scratch" >> $(CHECKUP_DOCKERFILE)
	@echo "COPY --from=0 /go/bin/$(CHECKUP_BINARY) /bin/$(CHECKUP_BINARY)" >> $(CHECKUP_DOCKERFILE)
	@echo "ENTRYPOINT [ \"/bin/$(CHECKUP_BINARY)\" ]" >> $(CHECKUP_DOCKERFILE)

checkup: $(CHECKUP_DOCKERFILE)
	docker build -t parkr/checkup:$(REV) -f $(CHECKUP_DOCKERFILE) .

test: checkup
	docker run -it --rm parkr/checkup:$(REV) --help
