import UIKit

var greeting = "Hello, playground"
var name = "Dilara"
name = "Alara"

let id = 123456789
//id = 987654321

print(name)
print(id)

//Convention : Swift dilinde camelCase kullnamka daha yaygındır.

var favoriteShow = "Orange is the New Black"
favoriteShow = "The Good Place"
favoriteShow = "Doctor Who"

//Şimdi, her üç satırda da var olduğunu hayal edin – her seferinde var favoriteShow kullandınız. Bu pek mantıklı olmazdı, çünkü "favoriteShow adında yeni bir değişken oluştur" demiş olurdunuz ve değişken, ilk denemenizden sonra açıkça yeni değildir. Swift, bunu bir hata olarak işaretleyecektir, bu da değişkenleriniz için farklı bir ad seçene kadar kodunuzu çalıştırmanıza izin vermeyeceği anlamına gelir.

let actor = "Denzel Washington"
let filename = "paris.jpg"
let result = "⭐️ You win!"

let quote = "Dilara says \"Swift is really enjoy programming language\"."
//Dizinizin içinde başka çift tırnak işaretleri bile kullanabilirsiniz, yeter ki Swift'in o tırnak işaretlerinin diziyi bitirmek yerine dizinin içinde olduğunu anlaması için onlardan önce bir ters eğik çizgi (\) koymaya dikkat edin

let movie = """
A day
the life of an
Apple developer.
"""

print(movie.count) //Değişkenin veya sabitin adından sonra .count yazarak bir dizinin uzunluğunu okuyabilirsiniz
print(name.uppercased())
//Burada açma ve kapama parantezlerine ihtiyaç vardır ancak count ile ihtiyaç yoktur. Bunun nedeni, siz öğrendikçe daha netleşecektir, ancak Swift öğreniminizin bu erken aşamasında ayrım en iyi şöyle açıklanır: Swift'ten bazı verileri okumasını istiyorsanız parantezlere ihtiyacınız yoktur, ancak Swift'ten bazı işleri yapmasını istiyorsanız ihtiyacınız vardır.

print(actor.hasPrefix("A")) //Bir dizinin seçtiğimiz bazı harflerle başlayıp başlamadığını bilmemizi sağlar.
print(actor.hasSuffix("n")) //Bir dizinin bazı metinlerle bitip bitmediğini kontrol eden hasSuffix() karşılığı da vardır.

//var henley = """I am the master of my fate
//I am the captain of my soul"""
///Bu yazım multi-line string oluşturmaz! Tırnaklar ayrı satırda olmalıdır.


let score = 10
let reallyBig = 100_000_000 //Sayıları istediğiniz şekilde ayırmak için alt çizgileri (_) kullanabilirsiniz. Swift aslında alt çizgilerle ilgilenmez, bu yüzden isterseniz şunu da yazabilirsiniz:
let reallyBig2 = 1__000__000_00

var counter = 10
counter += 5
print(counter)

let number = 120
print(number.isMultiple(of: 3)) //120, 3'ün katı mıdır?

let x = 0.1 + 0.2
print(x) //Bu çalıştığında 0.3 yazdırmayacaktır. Bunun yerine, 0.30000000000000004 yazdıracaktır – yani 0.3, ardından 15 sıfır ve sonra bir 4 çünkü... dediğim gibi, karmaşık.

///İlk olarak, bir kayan nokta sayısı oluşturduğunuzda, Swift bunu bir Double olarak kabul eder. Bu, "çift duyarlıklı kayan nokta sayısı" (double-precision floating-point number) anlamına gelir ki, bunun oldukça tuhaf bir isim olduğunun farkındayım – kayan nokta sayılarını ele alış şeklimiz yıllar içinde çok değişti ve Swift bunu basitleştirmede iyi bir iş çıkarsa da, bazen daha karmaşık olan eski kodlarla karşılaşabilirsiniz. Bu durumda, Swift'in bazı eski dillerin yapacağından iki kat daha fazla depolama alanı tahsis ettiği anlamına gelir, bu da bir Double'ın kesinlikle çok büyük sayıları saklayabileceği anlamına gelir. İkincisi, Swift ondalık sayıları tamsayılardan tamamen farklı bir veri türü olarak kabul eder, bu da onları karıştıramayacağınız anlamına gelir. Ne de olsa, tamsayılar her zaman %100 doğrudur, oysa ondalık sayılar değildir, bu yüzden Swift, siz özellikle olmasını istemedikçe ikisini bir araya getirmenize izin vermez.

let a = 1
let b = 0.2
//let sum = a + b //HATA: Binary operator '+' cannot be applied to operands of type 'Int' and 'Double' (type safety)
let sum = Double(a) + b


///Tip güvenliği ile birleştiğinde, bu, Swift bir sabitin veya değişkenin hangi veri tipini tutacağına karar verdikten sonra, her zaman aynı veri tipini tutması gerektiği anlamına gelir. Bu şu kodun hatalı olduğu anlamına gelir:
///var age = 18
///age = "eighteen"  //HATA : Cannot assign value of type 'String' to type 'Int'

