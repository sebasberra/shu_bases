cp hmidg.txt hmidg_bak
cp hmidg5.txt hmidg5_bak

recode -fv latin1..utf8 hmidg.txt
recode -fv latin1..utf8 hmidg5.txt

sed 's/#/Ñ/g' hmidg.txt >hmidg_1.txt
sed 's/#/Ñ/g' hmidg5.txt >hmidg5_1.txt

sed 's/¥/Ñ/g' hmidg_1.txt >hmidg_2.txt
sed 's/¥/Ñ/g' hmidg5_1.txt >hmidg5_2.txt

sed 's/¤/Ñ/g' hmidg_2.txt >hmidg_3.txt
sed 's/¤/Ñ/g' hmidg5_2.txt >hmidg5_3.txt

sed 's/;;/LL/g' hmidg_3.txt >hmidg_4.txt

recode -fv utf8..latin1 hmidg_4.txt
recode -fv utf8..latin1 hmidg5_3.txt

rm hmidg.txt
rm hmidg5.txt

cp hmidg_4.txt hmidg.txt
cp hmidg5_3.txt hmidg5.txt

rm hmidg_1.txt
rm hmidg_2.txt
rm hmidg_3.txt
rm hmidg_4.txt
rm hmidg5_1.txt
rm hmidg5_2.txt
rm hmidg5_3.txt
