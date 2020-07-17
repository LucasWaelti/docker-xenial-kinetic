# Clone voxblox and its dependencies using the helper script 
cd ./catkin_ws/src/
git clone https://gitlab.com/snippets/1975895.git
mv 1975895/voxblox_https.sh voxblox_https.sh
chmod +x ./voxblox_https.sh; ./voxblox_https.sh
rm ./voxblox_https.sh
rm -r -f 1975895/ 