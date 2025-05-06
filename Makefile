.PHONY: bootstrap start


dev: start
prod: build

start:
	npm run dev:start
	# npm run dev:start:with-pagefind

build:
	npm run build
	npx -y pagefind --site public

bootstrap:
	mkdir -p themes
	git clone git@github.com:cosent/dot-org-hugo-theme.git themes/
	cp -r themes/dot-org-hugo-theme/exampleSite/* .
	sed -i -e 's#themesDir=../..#themesDir=themes/#g' package.json
	npm install
