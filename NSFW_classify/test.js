const nlp = require('./classify')
const a = nlp.classify_comment("Trump is an idiot")
console.log(a)
if( a == true){
    console.log("Toxic")
}
else if(a == false) {
    console.log("Not Toxic")
}
const link = 'https://miro.medium.com/max/875/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg'

console.log(nlp.classify_image(link))
