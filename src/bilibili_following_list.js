// ==UserScript==
// @name         Get Bilibili Following List
// @namespace    https://github.com/Zeyu-Xie/Hydrangea-Info-Gatherer
// @version      1.0
// @description  Generate a file showing your bilibili following list.
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

let array = []

setTimeout(() => {

    const page_num = parseInt(document.querySelector("#page-follows > div > div.follow-main > div.follow-content.section > div.content > ul.be-pager > li:nth-child(6) > a").innerText)

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
            clearInterval(interval)
        }

        _input_page.value = tot
        _input_page.dispatchEvent(enter_keydown)
        _input_page.dispatchEvent(enter_keyup)

    }, 1500);

}, 1500);

