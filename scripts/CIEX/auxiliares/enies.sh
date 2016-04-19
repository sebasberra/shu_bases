cp catego.txt catego_bak

recode -fv latin1..utf8 catego.txt

sed 's/¥/Ñ/g' catego.txt >catego_1.txt

recode -fv utf8..latin1 catego_1.txt

rm catego.txt

cp catego_1.txt catego.txt

rm catego_1.txt

