gdalwarp -of GTiff -multi -wo NUM_THREADS=val/ALL_CPUS -cutline "PG:dbname='observatoire' host=localhost port=5432 user='observatoire' password='yourpasswordhere' sslmode=disable" -cl public.limite_lausanne -crop_to_cutline -dstalpha /home/cgil/PycharmProjects/observatoire-du-territoire/data/RGBVI_correct.tif /home/cgil/PycharmProjects/observatoire-du-territoire/data/RGBVI_correct_LAUSANNE_CLIPPED.tif
