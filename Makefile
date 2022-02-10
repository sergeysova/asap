SRC = $(wildcard src/*.ts) $(wildcard src/*.tsx)
LIB0 = $(SRC:src/%.ts=lib/%.js)
LIB = $(LIB0:src/%.tsx=lib/%.js)
DTS = $(LIB:%.js=%.d.ts)

.PHONY: build
build: main.js $(LIB) $(DTS)

.PHONY: check
check:
	@tsc -b .

.PHONY: clean
clean:
	rm -rf lib main.js *.d.ts

main.js: $(wildcard bin/*) pnpm-lock.yaml
	@mkdir -p $(@D)
	@esbuild \
		--bundle \
		--sourcemap=inline \
		--platform=node \
		--external:esbuild \
		--log-level=error \
		--outfile=$@ ./bin/main.ts
	@chmod +x $@

lib/%.js: src/%.ts
	@mkdir -p $(@D)
	@esbuild \
		--platform=browser \
		--log-level=error \
		--outfile=$@ $<

lib/%.js: src/%.tsx
	@mkdir -p $(@D)
	@esbuild \
		--platform=browser \
		--log-level=error \
		--outfile=$@ $<

lib/%.d.ts: node_modules/.cache/tsbuild/src/%.d.ts
	@mkdir -p $(@D)
	@cp $< $@