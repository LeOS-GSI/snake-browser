#!/bin/bash

echo
echo "--------------------------------------"
echo "          Snake Browser Buildbot      "
echo "                  by                  "
echo "                harvey186             "
echo "--------------------------------------"
echo


initRepos() {
   echo "clone sources"
   echo ""
   git clone https://github.com/zen-browser/desktop.git --recurse-submodules --depth 10
   echo "swap folder"
   cd desktop
   echo "inilize"
   npm i
   }
setVersion() {   
   echo "set branch and release"
   echo ""
   npx surfer set brand official
   echo '"release"' > ./.surfer/dynamicConfig.buildMode.json
  
   }
   
runInit() {   
   echo "run init"
   echo ""
   # Warnungen zu CRLF/LF-Konvertierung unterdrücken
   git config --global core.safecrlf false
   git config --global core.autocrlf false
   npm run init
   }

cpPatches() {
   echo "copy patches"
   echo ""
   cd ..
   cp 141_patches/14101-captivePortal.patch desktop/engine
   cp 141_patches/14102-all.js_search.patch desktop/engine
   cp 141_patches/14104-extensions.patch desktop/engine
   cp 141_patches/R14101-ROOT_SnakeOK.patch desktop
   cp 141_patches/R14102-ROOT-mozConfigOK.patch desktop
   cp 141_patches/R14103-ROOT-mozConfigOK.patch desktop 
   cp 141_patches/R14104-ROOT_welcome_iconsOK.patch desktop
   cd desktop
   }
   
setLocales() {   
   echo "copy locales"
   echo ""
   cp -R  l10n/de/browser/browser/ engine/browser/locales/en-US/
   }
   
setBranding() {   
   echo "copy branding"
   echo ""
   cd ..
   rm -R engine/browser/branding/official
   cp -R official/ desktop/engine/browser/branding/
   cd desktop
   }

applyPatches() {   
   echo "apply patches"
   echo ""
   git apply *.patch
   cd engine
   git apply *.patch
   cd ..
   }

setEN() {
   python3 ./scripts/update_en_US_packs.py
   }

startBuild(){
   echo "start build"
   echo ""
   npm run build
   npm start
   }

initRepos
setVersion
runInit
cpPatches
setLocales
setBranding
applyPatches
#setEN
startBuild

