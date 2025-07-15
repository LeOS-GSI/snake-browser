

#git clone https://github.com/zen-browser/desktop.git --recurse-submodules --depth 10
# cd desktop
#npm i
npx surfer set brand official
#echo '"release"' > ./.surfer/dynamicConfig.buildMode.json
# npm run init
#python3 ./scripts/update_en_US_packs.py
npm run build
npm start
