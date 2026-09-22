let delegation = document.querySelector("#color-buttons");
let input = document.querySelector("#input-color");
let enterBtn = document.querySelector("#enter");
let randomcolor = document.querySelector("#randomcolorBtn");


document.body.style.backgroundColor = "orange";

delegation.addEventListener("click", function(e) {
    if(e.target.tagName === "BUTTON"){
        let text = e.target.innerText;
        document.body.style.backgroundColor = text;
    }

})


enterBtn.addEventListener("click", function(){
    let newInput = input.value;
    if(newInput === "") return;
    document.body.style.backgroundColor = newInput;
})


randomcolor.addEventListener("click", function(){
    let random = Math.floor(Math.random() * 1000);
    document.body.style.backgroundColor = "#"+random;
})

