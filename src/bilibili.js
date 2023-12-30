// ==UserScript==
// @name         Get Bilibili User Info
// @namespace    https://github.com/Zeyu-Xie/Hydrangea-Info-Gatherer
// @version      1.0
// @description  Generate a file showing your bilibili user info.
// @author       Acan
// @match        https://space.bilibili.com/*
// @grant        none
// @run-at       document-idle
// ==/UserScript==

const enter_keydown = new KeyboardEvent('keydown', {
    key: 'Enter',
    code: 'Enter',
    keyCode: 13,
    which: 13,
    bubbles: true,
})
const enter_keyup = new KeyboardEvent('keyup', {
    key: 'Enter',
    code: 'Enter',
    keyCode: 13,
    which: 13,
    bubbles: true,
})

// following list
if(window.location.pathname.endsWith("/fans/follow") && window.confirm("Do you want to generate your following list? ")) {
    
    let array = []
    setTimeout(() => {
    
        const page_text = document.querySelector("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.be-pager > span.be-pager-total").innerText

        const page_num = parseInt(page_text.slice(2, page_text.length - 2))
            
        const _input_page = document.querySelector("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.be-pager > span.be-pager-options-elevator > input")
    
        let tot = 1
    
        let interval = setInterval(() => {
    
            const follows = document.querySelectorAll("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.relation-list > li > div.content > a")
    
            console.log(`Inspecting page ${tot}`)
            Array.from(follows).forEach(item => {
                array.push({
                    url: item.href,
                    name: item.innerText,
                    description: item.parentElement.querySelector("p").innerText
                })
            })
    
            console.log(array)
    
            tot++
    
            if (tot > page_num) {
                console.log("Finished")
                console.log(array)

                const dateData = new Date()
                const day = dateData.getDate()
                const month = dateData.getMonth()+1
                const year = dateData.getFullYear()

                const file = new File([JSON.stringify(array)], `${year}-${month}-${day}-Following List.json`, {
                    type: "application/json"
                })
                const url = URL.createObjectURL(file)
                window.open(url, "_blank")

                clearInterval(interval)
            }
    
            _input_page.value = tot
            _input_page.dispatchEvent(enter_keydown)
            _input_page.dispatchEvent(enter_keyup)
    
        }, 1500);
    
    }, 1500)
}

if(window.location.pathname.endsWith("/fans/fans") && window.confirm("Do you want to generate your followed list? ")) {
    let array = []
    setTimeout(() => {
    
        const page_text = document.querySelector("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.be-pager > span.be-pager-total").innerText

        const page_num = parseInt(page_text.slice(2, page_text.length - 2))
    
        const _input_page = document.querySelector("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.be-pager > span.be-pager-options-elevator > input")
    
        let tot = 1
    
        let interval = setInterval(() => {
    
            const follows = document.querySelectorAll("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.relation-list > li > div.content > a")
    
            console.log(`Inspecting page ${tot}`)
            Array.from(follows).forEach(item => {
                array.push({
                    url: item.href,
                    name: item.innerText,
                    description: item.parentElement.querySelector("p").innerText
                })
            })
    
            console.log(array)
    
            tot++
    
            if (tot > page_num) {
                console.log("Finished")
                console.log(array)

                const dateData = new Date()
                const day = dateData.getDate()
                const month = dateData.getMonth()+1
                const year = dateData.getFullYear()

                const file = new File([JSON.stringify(array)], `${year}-${month}-${day}-Followed List.json`, {
                    type: "application/json"
                })
                const url = URL.createObjectURL(file)
                window.open(url, "_blank")

                clearInterval(interval)
            }
    
            _input_page.value = tot
            _input_page.dispatchEvent(enter_keydown)
            _input_page.dispatchEvent(enter_keyup)
    
        }, 1500);
    
    }, 1500)
}
