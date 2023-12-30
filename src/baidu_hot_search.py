import requests
import hashlib  # Python itself includes it, no need to pip
import xml.dom.minidom  # Python itself includes it, no need to pip
from bs4 import BeautifulSoup  # attention: use "pip install beautifulsoup4"
from datetime import datetime


# ====== Preparation: Crawler ======

# 发送 HTTP 请求获取网页内容
url = "https://top.baidu.com/board?tab=realtime"
response = requests.get(url)
html_content = response.text

# 创建 Beautiful Soup 对象
soup = BeautifulSoup(html_content, "html.parser")

# 查找新闻热搜列表的父元素
hot_searches = soup.find("div", class_="container-bg_lQ801")

# 遍历热搜列表的子元素，提取热搜词

print("Baidu Hot Search")
print("Created By Beautiful Soup")
print("\n")


# ====== Part 1: Write to txt ======

# Accurate date and _fileName (to logs)
date = datetime.now()
fileName = f"data/Baidu_Hot_Search/logs/{date}.txt"
_fileName = fileName.replace(" ", "_")

# Init the index and the output
index = 0
output = ""

# Construct the output string (txt)
for item in hot_searches.find_all("div", class_="category-wrap_iQLoo horizontal_1eKyQ"):

    index += 1

    _hot_word_title = item.find("div", class_="c-single-text-ellipsis")
    hot_word_title = _hot_word_title.text.strip()

    _hot_word_index = item.find("div", class_="hot-index_1Bl1a")
    hot_word_index = _hot_word_index.text.strip()

    _hot_word_content = item.find("div", class_="hot-desc_1m_jR large_nSuFU")
    
    # if _hot_word_content is None:
    #     continue

    hot_word_content = ""

    try:
        hot_word_content = _hot_word_content.get_text("$$").split("$$")[
        0].strip()
    except:
        print(f"ERROR <div> label not existed at index = {index}")

    _hot_word_url = item.find("a", class_="img-wrapper_29V76")
    hot_word_url = _hot_word_url.get("href").strip()

    output += "- No. "+str(index)+" -\n"
    output += "- Title: "+hot_word_title+" -\n"
    output += "- Index: "+hot_word_index+" -\n"
    output += "- Content: "+hot_word_content+" -\n"
    output += "- URL: "+hot_word_url+" -\n"
    output += "\n"
print("\n")


# Print the output string
print(output)

# Write to logs
# with open(_fileName, "w") as file:
#     file.write(output)
#     file.close()

# Write to latest.txt
with open("data/Baidu_Hot_Search/latest.txt", "w") as file:
    file.write(output)
    file.close()


# ====== Part2: Write to xml ======

# Accurate date, filename and templateFileName (to latest.xml, from template.xml)
date = datetime.now()
fileName = "data/Baidu_Hot_Search/latest.xml"
templateFileName = "data/Baidu_Hot_Search/template.xml"

# Init the index and output
index = 0
output = ""

# Set the headings
with open(templateFileName, "r") as file:
    output = file.read()
    file.close()
output += "\n"
output += f"<lastBuildDate>{date}</lastBuildDate>\n"

# Construct the output string (xml)
for item in hot_searches.find_all("div", class_="category-wrap_iQLoo horizontal_1eKyQ"):

    index += 1

    _hot_word_title = item.find("div", class_="c-single-text-ellipsis")
    hot_word_title = _hot_word_title.text.strip()

    _hot_word_index = item.find("div", class_="hot-index_1Bl1a")
    hot_word_index = _hot_word_index.text.strip()

    _hot_word_content = item.find("div", class_="hot-desc_1m_jR large_nSuFU")
    hot_word_content = _hot_word_content.get_text("$$").split("$$")[
        0].strip()

    _hot_word_url = item.find("a", class_="img-wrapper_29V76")
    hot_word_url = _hot_word_url.get("href").strip()

    output += "<item>\n"
    output += f"<index><![CDATA[ {index} ]]></index>\n"
    output += f"<description><![CDATA[ {hot_word_content} ]]></description>\n"
    output += f"<title><![CDATA[ {hot_word_title} ]]></title>\n"
    output += f"<link><![CDATA[ {hot_word_url} ]]></link>\n"
    output += f"<guid isPermaLink=\"true\"><![CDATA[ {hashlib.md5((str(date)+str(index)).encode()).hexdigest()} ]]></guid>\n"
    output += "</item>\n"

output += "</channel>\n"
output += "</rss>\n"
output += "\n"

# Format the xml string
dom = xml.dom.minidom.parseString(output)
output = dom.toprettyxml(indent="    ", newl="")

# Print the output string
print(output)

# Write to xml
with open(fileName, "w") as file:
    file.write(output)
    file.close()
