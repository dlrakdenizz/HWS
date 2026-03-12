import UIKit

//MARK: How to create and use protocols

//Protokoller (Protocols) Swift’te biraz sözleşmelere (contracts) benzer: Bir veri türünün hangi tür işlevleri desteklemesini beklediğimizi tanımlamamıza izin verirler ve Swift de kodumuzun geri kalanının bu kurallara uyduğundan emin olur. Protokoller, kullanmak istediğimiz özellikleri (properties) ve metotları (methods) tanımlamamıza izin verir. Ancak bu özellikleri ve metotları uygulamazlar – yani içinde gerçek kod yoktur. Sadece var olmaları gerektiğini belirtirler. Bir nevi plan (blueprint) gibidirler.

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

//Bunu parçalayarak inceleyelim:
//Yeni bir protokol oluşturmak için protocol yazıp ardından protokol adını yazarız. Bu yeni bir tür olduğu için büyük harfle başlayan camelCase kullanılır.
//Protokolün içinde, bu protokolün çalışması için gerekli tüm metotları listeleriz.
//Bu metotların içinde herhangi bir kod bulunmaz. Sadece metot isimleri, parametreleri ve dönüş tipleri belirtilir. Gerekirse metotların throwing veya mutating olduğu da belirtilebilir.

//Artık bu protokolle çalışabilecek yeni veri türleri tasarlayabiliriz. Yani protokolün gereksinimlerini yerine getiren struct, class veya enum oluşturabiliriz. Buna protokolü benimsemek (adopting) veya protokole uymak (conforming) denir. Protokol, olması gereken tüm işlevleri değil, sadece minimum gereksinimleri tanımlar. Bu yüzden protokole uyan yeni türler, ihtiyaç duydukları başka özellikleri ve metotları da ekleyebilirler.

struct Car: Vehicle {
    
    let name = "Car"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}

//Bu kodda dikkat edilmesi gereken birkaç nokta var:
//Car’ın Vehicle protokolüne uyduğunu belirtmek için Car adından sonra iki nokta (:) kullanıyoruz.
//Vehicle içinde tanımladığımız tüm metotlar Car içinde birebir bulunmak zorundadır. İsimleri, parametreleri veya dönüş tipleri farklıysa Swift hata verir.
//Car içindeki metotlar protokolde tanımlanan metotların gerçek implementasyonudur.
//openSunroof() metodu protokolde yoktur. Ama sorun değil çünkü protokol yalnızca minimum gereksinimleri tanımlar.

func commute(distance: Int, using vehicle: Vehicle) { //vehicle için protokol kullandık!
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

//Artık commute() fonksiyonuna Car veya Bicycle gönderebiliriz. Swift otomatik olarak doğru metodu kullanır.
//Eğer car gönderirsek: "I'm driving"
//Eğer bike gönderirsek: "I'm cycling"
//Bu yüzden protokoller sayesinde:
//Belirli veri tipleri yerine, istediğimiz işlevleri tanımlarız.

print("********************************")

//Protokoller yalnızca metotları değil, özellikleri (properties) de tanımlayabilir.Bunun için var yazıp ardından okunabilir mi (get) yazılabilir mi (set) belirtiriz. (Burada önemli bir kural hiçbir zaman tek başına { set } yazılamaz, çünkü get olmayan şeyi set edemezsin zaten)

protocol Vehicle2 {
    var name: String { get }
    var currentPassengers: Int { get set }
    
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

//Burada iki property ekledik:
//name → sadece okunabilir (get)
//currentPassengers → okunabilir ve yazılabilir (get set)
//Protokolde varsayılan değer veremeyiz, bu yüzden tip belirtmek zorunludur.
// Bu değişiklikten sonra Swift bize Car ve Bicycle artık protokole uymuyor diye uyarı verir. Bu yüzden Car ve Bicycle için aşağıdakileri eklemeliyiz:

//let name = "Car"
//var currentPassengers = 1
//
//let name = "Bicycle"
//var currentPassengers = 1

//İstersen bunları computed property olarak da yazabilirsin. Ancak { get set } kullanıyorsan constant (let) kullanamazsın.

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

//Yukarıdaki fonksiyon Vehicle protokolüne uyan tüm türlerle çalışır:

getTravelEstimates(using: [car, bike], distance: 150)

//Fonksiyonlar parametre olarak protokol alabilir.
//Fonksiyonlar protokol döndürebilir.
//Bir tür birden fazla protokole aynı anda uyabilir: struct Car: Vehicle, Equatable, Codable
//Eğer bir class’tan kalıtım alıp protokole uyuyorsanız, önce parent class, sonra protokoller yazılır.

//MARK: How to use opaque return types

//Swift’te opaque return types (gizli dönüş tipleri) denen oldukça garip, karmaşık ama çok önemli bir özellik vardır. Bu özellik kodumuzdaki karmaşıklığı azaltmamıza yardımcı olur. Açıkçası tek bir sebepten dolayı başlangıç seviyesinde anlatılır: ilk SwiftUI projenizi oluşturduğunuz anda bu özelliği göreceksiniz.

func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}
//Bu durumda:
//getRandomNumber() → rastgele bir Int
//getRandomBool() → rastgele bir Bool
//döndürür.

//Hem Int hem de Bool, Swift’teki Equatable protokolüne uyar. Equatable şu anlama gelir: “Eşitlik karşılaştırması yapılabilir.” Bu yüzden şu kod çalışır:
print(getRandomNumber() == getRandomNumber())

//Ama aşağıdaki kod çalışmaz:
func getRandomNumber() -> Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> Equatable {
    Bool.random()
}
//Fonksiyonlardan protokol döndürmek aslında mümkündür ve çoğu zaman faydalıdır. Ancak Equatable farklıdır çünkü dönecek tipler farklıdır, Swift 5==true gibi bir karşılaştırma yapamaz. Bu yüzden Swift şöyle düşünür: Eğer fonksiyon sadece Equatable döndürüyorsa, dönen şeyin Int mi Bool mu olduğunu bilmiyorum. Bu yüzden karşılaştırma yapmak mümkün olmaz.

//Opaque return types bize şunu sağlar: Tipi kullanıcıdan gizleyebiliriz Ama Swift derleyicisi gerçek tipi bilir Bunun için some anahtar kelimesini kullanırız.

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

//SwiftUI’de ekranları şöyle tarif ederiz: Üstte toolbar, altta tab bar, ortada scroll olan grid, içinde ikonlar, altında yazılar… SwiftUI bu layout tanımının tamamını dönüş tipi olarak kullanır. Ama bu tip aşırı uzun olurdu. Bu yüzden SwiftUI şöyle kullanır:
//var body: some View
//Bu şu anlama gelir: Bir View döndüreceğim ama tam tipini yazmak istemiyorum. Swift ise arka planda gerçek tipi bilir.

//MARK: How to create and use extensions

//Extensions, bir tipe yeni özellikler eklememizi sağlar. Bu tip: bizim oluşturduğumuz bir tip olabilir başkasının oluşturduğu bir tip olabilir hatta Apple’ın kendi tiplerinden biri bile olabilir.

//Bunu göstermek için String üzerinde bulunan faydalı bir metodu inceleyelim: trimmingCharacters(in:) Bu metot bir string’in başındaki veya sonundaki bazı karakterleri kaldırır. Örneğin: harfler, sayılar, en yaygın olarak boşluklar (whitespace), satır sonları (new lines)

var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)
print(trimmed)
//Buradaki .whitespacesAndNewlines değeri Apple’ın Foundation API’sinden gelir. trimmingCharacters(in:) metodu da yine Foundation kütüphanesinin bir parçasıdır.
//Her seferinde bu uzun metodu yazmak biraz zahmetli. Bu yüzden bir extension yazabiliriz:
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

//extension → mevcut bir tipe yeni özellik eklemek istediğimizi söyler
//String → bu özelliği String’e ekliyoruz
//{ } → içindeki kodlar artık String’in bir parçası
let trimmed2 = quote.trimmed()
print(trimmed2)

//Şöyle bir fonksiyon da yazılabilirdi:
func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}

let trimmed3 = trim(quote)
print(trimmed3)

//Extension avantajları
//1️⃣ Xcode’da otomatik görünür
//quote. yazdığınızda Xcode size tüm string metotlarını gösterir.
//Extension ile eklediğimiz metotlar da listede görünür.
//2️⃣ Kod daha düzenli olur
//Global fonksiyonlar projeyi dağınık hale getirir.
//Extensions ise veri tipine göre gruplanır.
//3️⃣ Tipin iç verilerine erişebilir
//Extension içindeki metotlar:
//private property
//private method
//gibi şeylere erişebilir.
//4️⃣ Değeri doğrudan değiştirebilir
//Az önce yazdığımız trimmed() yeni bir string döndürüyordu.
//Ama string’i doğrudan değiştiren bir metot da yazabiliriz:
//mutating func trim() {
//    self = self.trimmed()
//}
//Burada mutating kullanmamız gerekir çünkü string değiştiriyoruz.
//Kullanımı:
//quote.trim()


//Swift’te bir kural vardır: Eğer fonksiyon: yeni değer döndürüyorsa → ed veya ing ile biter, değeri değiştiriyorsa → normal fiil kullanılır
//trimmed()    yeni string döndürür
//trim()    mevcut string’i değiştirir


//Extension ile property de ekleyebiliriz.
//Ama bir kural var:
//❌ stored property eklenemez
//✔ computed property eklenebilir
//Sebebi:
//Eğer stored property ekleseydik veri tipinin hafızadaki boyutu değişirdi.
//Bu da büyük sorunlara yol açardı.

extension String {
    var lines: [String] { //Bu property string’i satırlara ayırır.
        self.components(separatedBy: .newlines)
    }
}

//Swift struct’lar için otomatik olarak bir memberwise initializer oluşturur.
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

struct Book2 {
    let title: String
    let pageCount: Int
    let readingHours: Int

    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

//Swift artık otomatik initializer’ı kaldırır. Çünkü bizim özel mantığımızı kullanmak ister. Bunun çözümü: custom initializer’ı extension içinde yazmak.

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

//Extensions ayrıca kendi kodumuzu düzenlemek için de çok kullanışlıdır. Bunun birkaç yolu vardır, fakat burada iki önemli yönteme odaklanacağız: Conformance grouping, Purpose grouping

//1️⃣ Conformance Grouping (Protokol uyumunu gruplayarak)
//Bu yöntemde bir tipin protokole uyumunu extension içinde tanımlarız. Örneğin bir tip Printable protokolüne uyacaksa, bu protokolün gerektirdiği metotları ayrı bir extension içinde yazarız. Bunun avantajı: Kod okunurken geliştirici daha az şeyi aynı anda düşünmek zorunda kalır. Eğer extension Printable protokolünü desteklemek için yazılmışsa, geliştirici burada sadece print ile ilgili metotları görür. Yani farklı protokollere ait metotlar birbirine karışmaz.

//2️⃣ Purpose Grouping (Amaçlara göre gruplayarak)
//Bu yöntemde extension’lar belirli görevler için oluşturulur. Örneğin büyük bir veri tipi için şöyle extension’lar olabilir: biri veri yükleme (loading) işlemleri için, biri veri kaydetme (saving) işlemleri için, biri network işlemleri için. Bu yaklaşım özellikle çok büyük tiplerle çalışırken kodu daha düzenli hale getirir.
