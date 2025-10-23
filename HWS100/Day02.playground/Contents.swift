import UIKit

let goodDogs = true
print(!goodDogs)

var gameOver = false
print(gameOver.toggle())

//Swift, dizileri birleştirmek için bize iki yol sunar: onları + kullanarak birleştirmek (String Concatenation) ve herhangi bir türdeki değişkenleri doğrudan dizilerin içine yerleştirebilen String Interpolation (Dizi İçine Değişken Ekleme) adı verilen özel bir teknik.

let firstPart = "Hello"
let secondPart = "World"
let result = firstPart + secondPart

let luggageCode = "1" + "2" + "3" + "4" + "5"
//Swift tüm bu dizileri tek seferde birleştiremez. Bunun yerine, ilk ikisini birleştirerek "12" yapar, sonra "12" ve "3"ü birleştirerek "123" yapar, sonra "123" ve "4"ü birleştirerek "1234" yapar ve son olarak "1234" ve "5"i birleştirerek "12345" yapar – kod bittiğinde nihayetinde kullanılmasalar bile "12", "123" ve "1234"ü tutmak için geçici diziler oluşturur. Bu yüzden çok güzel bir yöntem değil.

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and my age is \(age)"
print(message)

//String interpolation, dizileri tek tek birleştirmek için + kullanmaktan çok daha verimlidir, ancak başka bir önemli faydası daha var: tamsayıları, ondalık sayıları ve daha fazlasını ekstra bir çaba olmadan dahil edebilirsiniz. Şöyle ki, + kullanmak dizileri dizilere, tamsayıları tamsayılara ve ondalık sayıları ondalık sayılara eklememize izin verir, ancak tamsayıları dizilere eklememize izin vermez. Bu yüzden, bu tür bir koda izin verilmez:
let number = 11
//let missionMessageFalse = "Apollo " + number + " landed on the moon."


let missionMessageTrue1 = "Apollo " + String(number) + " landed on the moon."
let missionMessageTrue2 = "Apollo \(number) landed on the moon."


//CHECKPOINT

let celcius = 5.0
var fahrenheit = celcius * 9 / 5 + 32
print("Celcius is \(celcius)°C and fahrenheit is \(fahrenheit)°F") // ° -> Option+Shift+8

