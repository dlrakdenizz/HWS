import UIKit

//MARK: How to use type annotations
///Swift, bir sabitin veya değişkenin, ona ne atadığımıza bağlı olarak ne tür bir veri tuttuğunu anlayabilir. Ancak, bazen bir değeri hemen atamak istemeyiz veya bazen Swift'in tür seçimini geçersiz kılmak isteriz; işte bu noktada tür belirtme (type annotations) devreye girer.
var score: Double = 0
let playerName: String = "Roy"
var luckyNumber: Int = 13
let pi: Double = 3.141
var isAuthenticated: Bool = true
var albumss: [String] = ["Red", "Fearless"]
var user: [String: String] = ["id": "@twostraws"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])
var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]

//Boş başlatmak için
var teams: [String] = [String]()
var cities: [String] = []
var clues = [String]()

//MARK: For loops
let albums = ["Red", "1989", "Reputation"]

for album in albums{
    print("\(album), Apple Music'te")
}

///Eğer for döngülerinin size verdiği sabiti kullanmıyorsanız, Swift'in gereksiz değerler oluşturmaması için bunun yerine bir alt çizgi (_) kullanmalısınız:
for _ in 1...5 {
    print("Hello")
}

//MARK: While loops

var numberrr = 1

while numberrr <= 20 {
    print(numberrr)
    numberrr += 1
}
print("Önüm arkam saklanmayan sobe!")

///For ve while arasındaki fark?
///Temel fark, for döngülerinin genellikle sonlu dizilerle kullanılmasıdır: örneğin, 1'den 10'a kadar olan sayılar veya bir dizideki öğeler üzerinde döngü yaparız. Öte yandan, while döngüleri, herhangi bir keyfi koşul yanlış olana kadar dönebilir. Bu da biz durmalarını söyleyene kadar çalışmalarına olanak tanır. Bu, aynı kodu şu durumlara kadar tekrarlayabileceğimiz anlamına gelir:
///Kullanıcı bizden durmamızı isteyene kadar
///Bir sunucu bize durmamızı söyleyene kadar
///Aradığımız cevabı bulana kadar
///Yeterli veri üretene kadar


//MARK: Repeat loops
///Koşul repeat döngüsünün sonunda geldiği için, döngü içindeki kod her zaman en az bir kez çalıştırılacaktır, oysa while döngüleri koşullarını ilk çalıştırmadan önce kontrol eder.

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Önüm arkam saklanmayan sobe!")

///Swift'in for ve while döngüleri, döngü oluşturmanın ezici çoğunlukla en yaygın yollarıdır. Ancak, bir while döngüsüne benzeyen fakat döngü gövdesini her zaman en az bir kez çalıştıran repeat adında üçüncü bir seçeneğimiz de vardır. Bu fark o kadar küçük ki, ne anlamı olduğunu merak edebilirsiniz – eğer kodun her zaman en az bir kez çalışmasını istiyorsak, neden onu hem döngü gövdesinin içine hem de döngüden önce koymayalım ki? Cevap, kısmen programcıların "DRY" dediği bir şeydir: Kendini Tekrar Etme (Don't Repeat Yourself). Genellikle kodu bir kez ve sadece bir kez yazmayı tercih ederiz ve tekrarlanan kodu bir şeylerin yanlış gittiğinin bir işareti olarak görürüz.

let numberss = [1, 2, 3, 4, 5]
let random = numberss.shuffled()
 ///Yukarıdaki örnekte: 1, 2, 3, 4, 5'i karıştırmak, 5, 4, 3, 2, 1 elde edebileceğimiz anlamına gelebilir, 1, 4, 3, 5, 2 elde edebileceğimiz anlamına gelebilir veya başlangıçta verdiğimiz dizinin aynısı olan 1, 2, 3, 4, 5'i geri alabileceğimiz anlamına gelebilir.

let numberssss = [1, 2, 3, 4, 5]
var random2 = numberssss.shuffled()

while random2 == numberssss {
    random2 = numberssss.shuffled()
}
///Gördüğünüz gibi, yukarıda shuffled() metodunu iki yerde tekrar etmemize neden oldu.


let numbers = [1, 2, 3, 4, 5]
var random3: [Int]

repeat {
    random3 = numbers.shuffled()
} while random == numbers


//MARK: Exiting loops

///break anahtar kelimesini kullanarak bir döngüden istediğiniz zaman çıkabilirsiniz. Yani break kelimesinden sonra döngünün geri kalanı okunmaz.

var countDown = 10

while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("Döngüden çık!")
        break
    }

    countDown -= 1
}

//MARK: Exiting multiple loops

///Bir döngüyü başka bir döngünün içine koyarsanız buna iç içe döngü (nested loop) denir ve hem iç döngüden hem de dış döngüden aynı anda çıkmak istemek nadir bir durum değildir.

outerloop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        
        if product == 50 {
            print("You win!")
            break outerloop
        }
    }
}

//MARK: Skipping items
///Yalnızca mevcut öğeyi atlayıp bir sonrakine devam etmek istiyorsanız, bunun yerine continue kullanmalısınız.

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

///continue kullandığımızda, "döngünün mevcut adımıyla işim bitti" demiş oluruz. Swift, döngü gövdesinin geri kalanını atlar ve döngüdeki bir sonraki öğeye geçer.
///break dediğimizde ise, "bu döngüyle tamamen işim bitti, bu yüzden tamamen çık" demiş oluruz. Bu, Swift'in döngü gövdesinin geri kalanını atlayacağı ve aynı zamanda henüz gelmemiş olan diğer tüm döngü öğelerini de atlayacağı anlamına gelir.


//MARK: Infinite loops
///while döngülerini sonsuz döngüler (infinite loops) yapmak için kullanmak yaygındır: bunlar ya hiç bitmeyen ya da siz hazır olana kadar bitmeyen döngülerdir. iPhone'unuzdaki tüm uygulamalar sonsuz döngüler kullanır, çünkü çalışmaya başlarlar ve siz onları kapatmayı seçene kadar sürekli olarak olayları izlerler.
///Sonsuz bir döngü oluşturmak için koşul olarak true kullanmanız yeterlidir. true her zaman true olduğundan, döngü sonsuza kadar tekrar edecektir. Uyarı: Lütfen döngünüzden çıkan bir kontrol (break) olduğundan emin olun, aksi takdirde asla bitmez.

var counter = 0
while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    }
}


//CHECKPOINT

var checkpoint = ["a", "b", "c", "d", "a"]
print(checkpoint.count)
print(Set(checkpoint))

//CHECKPOINT

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5)  {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    }else if i.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(i)
    }
}
