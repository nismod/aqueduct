# Clip Ghana, Vietnam, Argentina, Tanzania
bash clip.sh GHA  -3.262509   4.737128   1.187968  11.162937
bash clip.sh VNM 102.118655   8.565579 109.472423  23.366275
bash clip.sh ARG -73.588036 -55.052016 -53.661552 -21.786938
bash clip.sh TZA  29.321032 -11.731272  40.449392  -0.98583

# Threshold and polygonize
for adm3 in GHA VNM ARG TZA
do
    bash threshold.sh $adm3 0.0    0.25
    bash threshold.sh $adm3 0.25   0.5
    bash threshold.sh $adm3 0.5    1.0
    bash threshold.sh $adm3 1.0    2.0
    bash threshold.sh $adm3 2.0    3.0
    bash threshold.sh $adm3 3.0   10.0
    bash threshold.sh $adm3 10.0 999.0
done
