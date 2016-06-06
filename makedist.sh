if [ $# == 0 ]
then
    echo "usage: makedist.sh version_description"
    exit
fi

rm -rf BlockySkies
mkdir BlockySkies
cp game/bin/game1.adf BlockySkies/BlockySkiesPAL_$1.adf
cat LEGAL.html | sed 's/<p><a href="index.html">Go back<\/a><\/p>//' | html2text.py --ignore-images > LEGAL.txt
cp LEGAL.txt BlockySkies
zip -r downloads/BlockySkiesPAL_BootDisk_$1.zip BlockySkies
lha a downloads/BlockySkiesPAL_BootDisk_$1.lha BlockySkies

rm -rf BlockySkies
mkdir BlockySkies
cp game/bin/BlockySkiesDrawer.info BlockySkies.info
cp game/bin/BlockySkies BlockySkies
cp game/bin/BlockySkies.info BlockySkies
cp LEGAL.txt BlockySkies
lha -c downloads/BlockySkiesPAL_HardDrive_$1.lha BlockySkies BlockySkies.info
rm BlockySkies.info
rm -rf BlockySkies
rm -f downloads/BlockySkiesPAL_InstallDisk_$1.adf && /usr/local/amiga/amitools/xdftool.py downloads/BlockySkiesPAL_InstallDisk_$1.adf format "BlockySkies" + write game/bin/BlockySkies.info + write game/bin/BlockySkies + write LEGAL.txt
zip -r downloads/BlockySkiesPAL_InstallDisk_$1.zip downloads/BlockySkiesPAL_InstallDisk_$1.adf
lha a downloads/BlockySkiesPAL_InstallDisk_$1.lha  downloads/BlockySkiesPAL_InstallDisk_$1.adf
rm downloads/BlockySkiesPAL_InstallDisk_$1.adf
rm LEGAL.txt
rm -rf BlockySkies
ls -l downloads/BlockySkiesPAL_*$1.???
