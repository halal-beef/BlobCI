pip3 install git+https://github.com/samloader/samloader.git
export fw=$(samloader -m SM-G981B -r O2U checkupdate)
echo Firmware to be downloaded: $fw
python3 -m samloader -m SM-G981B -r O2U download -v $fw -O .
export fileenc=$(ls | grep enc)
python3 -m samloader -m SM-G981B -r O2U decrypt -v $fw -V 4 -i $fileenc -o decrypted.zip
echo downloaded and decrypted the firmware
git clone https://github.com/DumprX/DumprX
cd DumprX
./setup.sh
mv ../decrypted.zip .
./dumper.sh decrypted.zip
cd ../
git clone https://github.com/halal-beef/android_device_samsung_x1s device/samsung/x1s
git clone https://github.com/halal-beef/proprietary_vendor_samsung_x1s vendor/samsung/x1s
git clone https://github.com/fcuzzocrea/android_device_samsung_universal990-common device/samsung/universal990-common
git clone https://github.com/LineageOS/android_tools_extract-utils tools/extract-utils
git clone https://github.com/LineageOS/android_prebuilts_extract-tools prebuilts/extract-tools
cd device/samsung/x1s
./extract-files.sh ../../../DumprX/out
cd ../../../
mv libsec-ril-dsds.so.a11 vendor/samsung/x1s/proprietary/vendor/lib64/libsec-ril-dsds.so
mv libsec-ril.so.a11 vendor/samsung/x1s/proprietary/vendor/lib64/libsec-ril.so
git config --global user.name "halal-beef"
git config --global user.email "78730004+halal-beef@users.noreply.github.com"
cd vendor/samsung/x1s
git add .
git commit -m "x1s: [CI] Update blobs from $fw"
