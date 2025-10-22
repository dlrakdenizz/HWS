import UIKit

//MARK: How to store ordered data in arrays

var beatles = ["John", "Paul", "George", "Ringo"]
var temperatures = [25.3, 28.2, 26.4]

print(beatles[0])
print(temperatures[2])

///Eğer diziniz değişkense (variable), oluşturduktan sonra onu değiştirebilirsiniz. Örneğin, yeni öğeler eklemek için append() kullanabilirsiniz:
beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")

var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

var albums2 = [String]()
albums2.append("Folklore")
albums2.append("Fearless")
albums2.append("Red")

///Tıpkı string'lerde yaptığınız gibi, bir dizide kaç öğe olduğunu okumak için .count özelliğini kullanabilirsiniz:
print(albums.count)

///İkinci olarak, remove(at:) kullanarak belirli bir indeksteki bir öğeyi kaldırabilir veya removeAll() kullanarak her şeyi kaldırabilirsiniz:

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

///Üçüncü olarak, contains() kullanarak bir dizinin belirli bir öğeyi içerip içermediğini kontrol edebilirsiniz, şu şekilde:
let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))

///Dördüncü olarak, sorted() kullanarak bir diziyi sıralayabilirsiniz, şu şekilde:
let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())
///Bu, öğeleri artan düzende (string'ler için alfabetik, sayılar için sayısal olarak) sıralanmış yeni bir dizi döndürür – orijinal dizi değişmeden kalır.

///Son olarak, reversed() çağırarak bir diziyi tersine çevirebilirsiniz:
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)


//MARK: How to store and find data in dictionaries
///Sözlükler, öğeleri diziler gibi konumlarına göre saklamaz, bunun yerine öğelerin nerede saklanacağına bizim karar vermemize izin verir.

let employee2 = ["name": "Taylor Swift", "job": "Singer", "location": "Nashville"]
print(employee2["name"])
print(employee2["job"])
print(employee2["location"])
//Bunu bir playground'da denerseniz, Xcode'un “Expression implicitly coerced from 'String?' to 'Any’” (İfade dolaylı olarak 'String?' türünden 'Any' türüne zorlandı) gibi çeşitli uyarılar verdiğini göreceksiniz. Daha da kötüsü, playground'unuzun çıktısına bakarsanız, sadece Taylor Swift yerine Optional("Taylor Swift") yazdırdığını göreceksiniz – neler oluyor?
print(employee2["password"])
print(employee2["status"])
print(employee2["manager"])
//Bunların hepsi geçerli Swift kodudur, ancak kendilerine bağlı bir değeri olmayan sözlük anahtarlarını okumaya çalışıyoruz. Elbette, Swift burada da, tıpkı var olmayan bir dizi indeksini okursanız çökeceği gibi çökebilirdi, ancak bu, çalışmayı çok zorlaştırırdı – en azından 10 öğeli bir diziniz varsa, 0'dan 9'a kadar olan indeksleri okumanın güvenli olduğunu bilirsiniz.
//Bu yüzden, Swift bir alternatif sunar: Bir sözlüğün içindeki verilere eriştiğinizde, size “bir değer geri alabilirsiniz, ancak hiçbir şey de geri alamayabilirsiniz” der. Swift bunlara opsiyoneller (optionals) der çünkü verinin varlığı isteğe bağlıdır (opsiyoneldir) - orada olabilir de, olmayabilir de.
//Bir sözlükten okuma yaparken, anahtar mevcut değilse kullanılacak bir varsayılan (default) değer sağlayabilirsiniz.
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])


var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

//MARK: How to use sets for fast data lookup
///Verileri gruplamanın küme (set) adı verilen üçüncü çok yaygın bir yolu daha vardır – bunlar dizilere benzerler, ancak yinelenen (duplicate) öğeler ekleyemezsiniz ve öğelerini belirli bir sırada saklamazlar.
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people) //Küme, öğelerinin hangi sırada geldiğini umursamaz.
///Bunun aslında önce bir dizi oluşturduğuna, sonra bu diziyi kümeye koyduğuna dikkat ettiniz mi? Bu kasıtlıdır ve sabit veriden bir küme oluşturmanın standart yolu budur. Unutmayın, küme yinelenen değerleri otomatik olarak kaldıracak ve dizide kullanılan tam sırayı hatırlamayacaktır.


var people2 = Set<String>()
people2.insert("Denzel Washington")
people2.insert("Tom Cruise")
people2.insert("Nicolas Cage")
people2.insert("Samuel L Jackson")
//insert() kullandığımıza dikkat ettiniz mi? Bir string dizimiz olduğunda, append() çağırarak öğe ekliyorduk, ancak bu isim burada mantıklı değil – öğeyi kümenin sonuna eklemiyoruz, çünkü küme öğeleri istediği sırada saklayacaktır.
//Bir küme üzerinde contains() çağırmak o kadar hızlı çalışır ki, bunu anlamlı bir şekilde ölçmekte zorlanırsınız. Hatta, kümede bir milyon öğeniz, hatta 10 milyon öğeniz olsa bile, anında çalışır; oysa bir dizinin aynı işi yapması dakikalar veya daha uzun sürebilir.


//MARK: How to create and use enums

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday

enum Weekday2 {
    case monday, tuesday, wednesday, thursday, friday
}

///Bir değişkene veya sabite bir değer atadığınızda, veri türünün sabitlendiğini hatırlayın – bir değişkeni önce bir string, daha sonra bir tam sayı olarak ayarlayamazsınız. Enum'lar için bu, ilk atamadan sonra enum adını atlayabileceğiniz anlamına gelir, şu şekilde:
var day2 = Weekday.monday
day2 = .tuesday
day2 = .friday


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



