
function virar(time){
    const cards  =document.querySelectorAll(".card.card--clickable")
    cards.forEach(e=> e.classList.replace("card--clickable", "flipped"));
    console.log(cards)
    setTimeout(
        cards.forEach(e=>e.classList.replace("flipped", ".card.card--clickable"), time))
    }
    
function virarCartas(time) {
    const cards = document.querySelectorAll(".card.card--clickable");    
    cards.forEach(e => e.classList.replace("card--clickable", "flipped"));
    console.log(cards);
    setTimeout(() => {
        cards.forEach(e => e.classList.replace("flipped", "card--clickable"));
    }, time);
}
