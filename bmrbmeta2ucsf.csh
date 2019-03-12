#!/bin/csh
# Made by Joonhyeok Choi 2019.03.12
# Directly convert BMRB metadata to ucsf file  

## insert data
set file='data.txt' 		# file name
set dim = '2' 			# Dimension
set matr = '1024 2048' 		# Matrix size
set ind = '136.368 10.001' 	# ppm at index 0,0
set nulc = 'N H' 		# Nuclei (H,N or C)
set nf = '60.775 599.708' 	# nucleus frequencies (MHz)
set sw = '2200.0 2703.287' 	# Spectral widths(Hz)

## Processing
fgrep 'N      N' $file | awk '{print $11}' > ndata
fgrep 'H      H' $file | awk '{print $11}' > hdata
paste ndata hdata > merge_data.txt 
rm ndata hdata
sed -i -e 's\$\	1.0e7	3	15\ ' merge_data.txt
sed -i -e "1 i\$dim\ " merge_data.txt
sed -i -e "2 i\$matr\ " merge_data.txt
sed -i -e "3 i\$ind\ " merge_data.txt
sed -i -e "4 i\$nulc\ " merge_data.txt
sed -i -e "5 i\$nf\ " merge_data.txt
sed -i -e "6 i\$sw\ " merge_data.txt

## Convert
peaks2ucsf BMRB_target.ucsf < merge_data.txt
rm merge_data.txt
