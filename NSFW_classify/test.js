const nlp = require('./classify')

async function main() {
  const a = await nlp.classify_comment("Trump is an idiot")
  if( a == true){
      console.log("Toxic")
   }
  else if(a == false) {
    console.log("Not Toxic")
  }
   const link = 'https://miro.medium.com/max/875/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg'
   b =  await nlp.classify_image(link)
   console.log(b)
}

main()
