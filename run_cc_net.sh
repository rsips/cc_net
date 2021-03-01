#pcluster create ccnetloader
python -m cc_net --config reproduce --dump 2019-09
#pcluster delete ccnetloader
python UploadDirS3.py /app/data myt-ai-datasets /ccnet201909