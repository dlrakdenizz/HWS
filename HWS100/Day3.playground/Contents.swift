import UIKit

//MARK: Arithmetic Operators
let first = 12
let second = 5

let total = first + second
let difference = first - second
let product = first * second
let divided = first / second
let remainder = first % second


///Swift Neden Bir Double ile Bir Int'i Toplayamaz?
///Swift'in bu farklı sayısal türlere sahip olmasının nedeni, verilerini farklı şekillerde saklamalarıdır. Örneğin, hem Double hem de Int sayılarını saklamak için aynı miktarda bellek kullanır, ancak Int yalnızca tam sayıları saklarken Double ondalık basamaktan sonraki değerleri de saklayabilir. Dolayısıyla, en basit düzeyde, bir Double'ı bir Int'e eklemenin güvenli olmadığını görebilirsiniz, çünkü Double, Int'in saklayamayacağı şeyleri saklayabilir ve bu değerler sonuçta elde edilecek tam sayıda kaybolur.
///Sorun şu ki, Double değerini saklamak için Int ile aynı miktarda bellek kullansa da, verilerini saklama şekli biraz "bulanık"tır – küçük sayılarla gerçekten harika bir hassasiyete sahiptir, ancak büyük sayılarla çalışmaya başladığınızda bu hassasiyet giderek azalır. Aslında, Double'ın tutamadığı belirli sayılar bile vardır, bu yüzden bunun yerine çok az farklı bir değeri saklar.

let value: Double = 90000000000000001 //Bunu derlediğinizde, Swift bir uyarı gösterir: '90000000000000001' bir 'Double' olarak tam olarak temsil edilemez; '90000000000000000' olur.
///Tam sayılar (Integer), kesirli değerleri saklama yeteneğini kaybeder, ancak kesin değerleri saklama yeteneği kazanır. Bu, aşağıdaki kodun bir uyarı üretmeyeceği anlamına gelir, çünkü sayı tam olarak saklanabilir:
let value2: Int = 90000000000000001

//MARK: Operator overloading

let name = "Dilara"
let surname = "Akdeniz"
let fullName = name + surname

let numbers = [1,2,3,4]
let numbers2 = [5,6,7,8]
let karma = numbers + numbers2
//let result = false + false Bu hatalıdır, iki Bool + ile birleştirilemez

//MARK: Compound assignment operators

var score = 95
score -= 5 //Bu şekilde yazmaya "Compound assignment operator" denir.

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"


//MARK: Comparison operators

let firstScore = 6
let secondScore = 4

firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

"Taylor" <= "Swift" ///Bunların her biri string'lerle de çalışır, çünkü string'lerin doğal bir alfabetik sırası vardır

///Ayrıca Swift'te enum'larınız için de karşılaştırma yapmasını isteyebilirsiniz :
enum Sizes: Comparable {
    case small
    case medium
    case large
}

let a = Sizes.small
let b = Sizes.large

a < b //Bu kod “true” çıktısı verecektir, çünkü enum'un case listesinde small, large'dan önce gelir.

//MARK: Conditions

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 2 {
    print("İki as – şanslısın!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Sıradan kartlar")
}


//MARK: Combining Conditions

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Her ikisi de 18 yaşından büyük")
}

if age1 > 18 || age2 > 18 {
    print("En az biri 18 yaşından büyük")
}

//MARK: The ternary operator

let firstCardd = 11
let secondCardd = 10

print(firstCardd == secondCardd ? "Kartlar aynı" : "Kartlar farklı")

//MARK: Switch statements

let weather = "sunny"

switch weather {
case "rain":
    print("Şemsiye al")
case "snow":
    print("Sıkı giyin")
case "sunny":
    print("Güneş kremi sür")
    fallthrough //Swift, yalnızca eşleşen case'in içindeki kodu çalıştırır. Eğer programın çalışmaya bir sonraki case ile devam etmesini istiyorsanız, fallthrough anahtar kelimesini kullanın. Bu kodda weather "sunny" olduğu için önce "Güneş kremi sür" yazdırılır, ardından fallthrough komutuyla bir sonraki case'e geçilir ve "Günün tadını çıkar!" da yazdırılır.
default:
    print("Günün tadını çıkar!")
}
///Neden switch case kullanılır?
///Swift geliştiricileri, kodlarında birden fazla değeri kontrol etmek için hem switch hem de if kullanabilirler ve genellikle birini diğerine tercih etmek için kesin bir neden yoktur. Bununla birlikte, if yerine switch kullanmayı düşünmeniz için üç neden vardır:
///Kapsamlılık (Exhaustiveness): Swift, switch ifadelerinin kapsamlı olmasını gerektirir. Bu, ya kontrol edilecek her olası değer için bir case bloğunuzun olması (örneğin bir enum'un tüm durumları) ya da bir default bloğunuzun olması gerektiği anlamına gelir. Bu durum if ve else if için geçerli değildir, bu nedenle yanlışlıkla bir durumu gözden kaçırabilirsiniz. 🧠
///Verimlilik: Bir değeri birden fazla olası sonuç için kontrol etmek amacıyla switch kullandığınızda, bu değer yalnızca bir kez okunur. Oysa if kullanırsanız, birden çok kez okunacaktır. Bu durum, bazıları yavaş olabilen fonksiyon çağrılarını kullanmaya başladığınızda daha önemli hale gelir.
///Gelişmiş Desen Eşleştirme (Advanced Pattern Matching): Swift'in switch case'leri, if ile kullanılması hantal olan gelişmiş desen eşleştirme özelliklerine olanak tanır.



//MARK: Range operators

//Swift bize aralık (range) oluşturmanın iki yolunu sunar: .. <ve ... operatörleri. ↔️ Yarı açık aralık operatörü (..<), son değeri hariç tutarak bir aralık oluştururken, kapalı aralık operatörü (...) son değeri dahil ederek bir aralık oluşturur.

let puan = 85
switch puan {
case 0..<50 :
    print("Çok kötü bir şekilde başarısız oldun.")
case 50..<85:
    print("Fena değil.")
default:
    print("Harika iş çıkardın!")
}



