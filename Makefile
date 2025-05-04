.PHONY: bootstrap start

start:
	npm run dev:start

bootstrap:
	mkdir -p themes
	git clone git@github.com:cosent/dot-org-hugo-theme.git themes/
	cp -r themes/dot-org-hugo-theme/exampleSite/* .
	sed -i -e 's#themesDir=../..#themesDir=themes/#g' package.json
	npm install
