import os
import requests
from bs4 import BeautifulSoup  # attention: use "pip install beautifulsoup4"
from datetime import datetime

# Html request
url = "https://www.mfa.gov.cn/wjbxw_new/"
response = requests.get(url)
response.encoding = "utf-8"
html_content = response.text

# Accurate date and filename (to logs)
date = datetime.now()
fileName = f"data/Mfc_Cn/logs/{date}.txt".replace(" ", "_")

# Create the beautiful soup object
soup = BeautifulSoup(html_content, "html.parser")

# Find the <div> element, then find the array of <ul> elements
div = soup.find("div", class_="newsBd")
uls = div.find_all("ul")

# Init the index and the output
index = 0
output = ""

# Output preparation
for ul in uls:

    index += 1
    _index = 0

    # Find the array of <li> elements
    lis = ul.find_all("li")

    # Index of ul
    output += f"- No. {str(index)} -\n"

    for li in lis:
        _index += 1
        a = li.find("a")
        output += f"{str(_index)}. {os.path.join(a.text)} {os.path.join(url, a.get('href')[2:])}\n"

    output += "\n"

# Write to Mfc_Cn/logs/<Current Time>.txt
# with open(fileName, "w") as file:
#     file.write(output)
#     file.close()

# Write to Mfc_Cn/latest.txt
with open("data/Mfc_Cn/latest.txt", "w") as file:
    file.write(output)
    file.close()
    