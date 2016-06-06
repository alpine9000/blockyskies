if [ $# == 0 ]
then
    echo "usage: makedist.sh version_description"
    exit
fi

rm -rf BlockySkies
mkdir BlockySkies
cp game/bin/game1.adf BlockySkies/BlockySkiesPAL_$1.adf
cat LEGAL.html | sed 's/<p><a href="index.html">Go back<\/a><\/p>//' | html2text.py --ignore-images > BlockySkies/LEGAL.txt
zip -r downloads/BlockySkiesPAL_$1.zip BlockySkies
lha a downloads/BlockySkiesPAL_$1.lha BlockySkies
ls -l downloads/BlockySkiesPAL_$1.???