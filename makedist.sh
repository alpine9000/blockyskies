if [ $# == 0 ]
then
    echo "usage: makedist.sh version_description"
    exit
fi

rm -rf BlockySkies
mkdir BlockySkies
cp game/bin/game1.adf BlockySkies/BlockySkiesPAL_$1.adf
mkdir BlockySkies/styles
mkdir BlockySkies/styles/fonts
mkdir BlockySkies/images
cp styles/blockyskies.css BlockySkies/styles
cp images/apple-touch-icon.png BlockySkies/images
cp styles/fonts/Topaz_a1200_v1.0.ttf BlockySkies/styles/fonts
cat LEGAL.html | sed 's/<p><a href="index.html">Go back<\/a><\/p>//' > BlockySkies/LEGAL.html
zip -r downloads/BlockySkiesPAL_$1.zip BlockySkies
lha a downloads/BlockySkiesPAL_$1.lha BlockySkies
ls -l downloads/BlockySkiesPAL_$1.???