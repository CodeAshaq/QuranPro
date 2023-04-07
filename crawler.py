import requests
import json

def get_surah(surah):
    resp = requests.get(f'https://equran.id/api/surat/{surah}')
    if resp.status_code == 200:
        data = resp.text
        f = open(f'assets/datas/{surah}.json', 'a')
        f.write(data)
        f.close()

        json_data = json.loads(data)
        if json_data['surat_selanjutnya']:
            get_surah(json_data['nomor'] + 1)

get_surah(1)