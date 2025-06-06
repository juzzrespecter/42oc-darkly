import requests
from bs4 import BeautifulSoup as bs
import sys

test_urls = []

def recursive_search(url, level):
    if level == 8:
        return
    r = requests.get(url)
    soup = bs(r.text)
    links = soup.find_all('a', href=True)
    for link in links:
        if link['href'] == '../':
            continue
        if link['href'] == 'README':
            r = requests.get(url + link['href'])
            if 'flag' in r.text:
                print(r.text)
            continue
        request_url = url + link['href']
        if request_url in test_urls:
            print("wtf")
            raise 'e'
        test_urls.append(request_url)
        recursive_search(request_url, level+1)

if __name__ == '__main__':
    if len(sys.argv[1:]) != 1:
        print("Bad arguments")
        sys.exit(1)
    base_url = sys.argv[1]
    recursive_search(base_url, 0)
