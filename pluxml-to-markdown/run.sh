#!/bin/sh
rm -rf peli pelinc octo simp
mkdir peli pelinc octo simp
echo "SimpleMD"
./pluxml-to-md.py --pluxml-datas pluxml-datas --md-datas simp --converter SimpleMD
echo "PelicanMD"
./pluxml-to-md.py --pluxml-datas pluxml-datas --md-datas peli --converter PelicanMD
echo "PelicanNCMD"
./pluxml-to-md.py --pluxml-datas pluxml-datas --md-datas pelinc --converter PelicanncMD
echo "OctopressMD"
./pluxml-to-md.py --pluxml-datas pluxml-datas --md-datas octo --converter OctopressMD
