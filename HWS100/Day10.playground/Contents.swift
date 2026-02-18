import UIKit

//MARK: STRUCTS

//MARK: How to create your own structs
struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

//Dikkat ettiyseniz Album büyük harfle başlıyor. Bu Swift’te standarttır ve aslında başından beri bunu kullanıyoruz – String, Int, Bool, Set gibi. Bir veri tipinden bahsederken, ilk harfi büyük olan camel case kullanırız; ama tipin içindeki bir şeye (örneğin bir değişken ya da fonksiyon) referans verirken, ilk harfi küçük olan camel case kullanırız. Çoğunlukla bunun bir kuraldan ziyade bir konvansiyon olduğunu unutmayın, ama uyması oldukça faydalıdır. Bu noktada Album, String ya da Int gibidir – onları oluşturabilir, değer atayabilir, kopyalayabiliriz vb.

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.artist)

red.printSummary()
wings.printSummary()

//Gördüğünüz gibi red ve wings aynı Album struct’ından geliyor, ama oluşturulduktan sonra iki ayrı String oluşturmak gibi tamamen bağımsızdırlar. Bunu, her struct üzerinde printSummary() çağırdığımızda net bir şekilde görebilirsiniz; çünkü bu fonksiyon title, artist ve year değerlerine başvurur. Her iki durumda da doğru değerler yazdırılır: red için “Red (2012) by Taylor Swift”, wings için ise “Wings (2016) by BTS”. Swift, printSummary() fonksiyonu red üzerinde çağrıldığında, red’e ait title, artist ve year sabitlerini kullanması gerektiğini bilir.

//İşler, değişebilen değerlere sahip olmak istediğimizde daha ilginç hale gelir. Örneğin, gerektiğinde izin kullanabilen bir Employee struct’ı oluşturabiliriz:

//struct Employee {
//    let name: String
//    var vacationRemaining: Int
//    
//    func takeVacation(days: Int) {
//        if vacationRemaining > days {
//            vacationRemaining -= days
//            print("I'm going on vacation!")
//            print("Days remaining: \(vacationRemaining)")
//        } else {
//            print("Oops! There aren't enough days remaining.")
//        }
//    }
//}

//Ancak bu kod aslında çalışmaz – Swift, bu kodu derlemeyi reddeder. Şöyle ki: Eğer bir çalışanı let kullanarak sabit olarak oluşturursak, Swift o çalışanı ve içindeki tüm verileri sabit yapar. Fonksiyonları çağırabiliriz, ama bu fonksiyonların struct’ın verisini değiştirmesine izin verilmez; çünkü onu sabit olarak tanımladık. Bu yüzden Swift bizden ek bir adım ister: Sadece veri okuyan fonksiyonlar olduğu gibi kalabilir, ancak struct’a ait veriyi değiştiren fonksiyonlar özel bir mutating anahtar kelimesiyle işaretlenmelidir:

struct Employee {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

//Artık kod sorunsuz şekilde derlenir, ancak Swift bu sefer de sabit struct’lar üzerinde takeVacation() çağırmamıza izin vermez.
var dilara = Employee(name: "Dilara", vacationRemaining: 12)
dilara.takeVacation(days: 5)
print(dilara.vacationRemaining)

//Ama var dilara yerine let dilara yazarsanız, Swift yine kodu derlemeyi reddeder – sabit bir struct üzerinde mutating bir fonksiyon çağırmaya çalışıyoruz ki bu izin verilmez.
//Bazı terimler:
//Struct’lara ait değişken ve sabitlere property (özellik) denir.
//Struct’lara ait fonksiyonlara method (metot) denir.
//Bir struct’tan bir sabit veya değişken oluşturduğumuzda, buna o struct’ın bir instance’ı (örneği) denir – örneğin Album struct’ından bir düzine farklı instance oluşturabilirsiniz.
//Struct instance’larını şu şekilde bir initializer kullanarak oluştururuz: Album(title: "Wings", artist: "BTS", year: 2016)

//Bu son kısım ilk başta biraz garip gelebilir, çünkü struct’ı bir fonksiyon gibi kullanıp parametre gönderiyoruz. Bu, syntactic sugar (sözdizimsel şekerleme) denen şeyin bir parçasıdır – Swift, struct’ın içinde sessizce init() adında özel bir fonksiyon oluşturur ve struct’taki tüm property’leri bu fonksiyonun parametreleri olarak kullanır. Sonrasında Swift, aşağıdaki iki kodu otomatik olarak aynı kabul eder:

var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)

//Swift, initializer’ları oluştururken oldukça zekidir; property’lere varsayılan değerler atadığımızda, bunları otomatik olarak ekler.

//let name: String
//var vacationRemaining = 14

//Swift, vacationRemaining için varsayılan değeri 14 olan bir initializer oluşturur ve aşağıdaki iki kullanım da geçerli olur:

//let kane = Employee(name: "Lana Kane")
//let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)

//Eğer bir constant property’ye varsayılan bir değer atarsanız, bu property initializer’dan tamamen çıkarılır. Varsayılan bir değer atayıp, gerektiğinde bunun üzerine yazabilmek istiyorsanız, variable property (var) kullanmalısınız.


//MARK: What’s the difference between a struct and a tuple?
//Swift’te tuple’lar, tek bir değişken içinde birden fazla ve isimlendirilmiş değeri saklamamıza izin verir. Struct’lar da neredeyse aynı şeyi yapar.Yeni öğrenirken farkı şöyle düşünebilirsiniz: tuple, aslında adı olmayan bir struct gibidir — yani anonim bir struct.

// (name: String, age: Int, city: String)

// Aşağıdaki struct ile aynı işi yapar:

struct User {
    var name: String
    var age: Int
    var city: String
}
//Ancak tuple’ların bir sorunu vardır: tek seferlik kullanımlar için harikadırlar, özellikle de bir fonksiyondan birden fazla veri döndürmek istediğinizde. Fakat aynı yapıyı tekrar tekrar kullanmanız gerektiğinde can sıkıcı hale gelirler. Bir düşünün: Kullanıcı bilgileriyle çalışan birden fazla fonksiyonunuz varsa, hangisini yazmayı tercih ederdiniz?


//func authenticate(_ user: User) { ... }
//func showProfile(for user: User) { ... }
//func signOut(_ user: User) { ... }

//Yoksa bu mu?

//func authenticate(_ user: (name: String, age: Int, city: String)) { ... }
//func showProfile(for user: (name: String, age: Int, city: String)) { ... }
//func signOut(_ user: (name: String, age: Int, city: String)) { ... }

//Şimdi şunu hayal edin: User struct’ına yeni bir property eklemek ne kadar zor?
//Cevap: çok kolay.
//Peki aynı şeyi tuple için her kullanıldığı yerde yapmak ne kadar zor?
//Cevap: çok zor ve hataya çok açık.
//Özetle:
//Bir fonksiyondan iki ya da daha fazla, geçici ve rastgele değeri döndürmek istiyorsanız tuple kullanın.
//Aynı veri yapısını birden fazla yerde, tekrar tekrar göndermek ya da almak istiyorsanız struct tercih edin.


//MARK: What’s the difference between a function and a method?

//Açıkçası, tek gerçek fark şudur: metotlar bir tipe aittir (örneğin struct, enum veya class), fonksiyonlar ise herhangi bir tipe ait değildir. Hepsi bu — fark sadece bundan ibarettir. Her ikisi de istenilen sayıda parametre alabilir (variadic parametreler dahil) ve her ikisi de değer döndürebilir. Hatta o kadar benzerdirler ki, Swift bir metodu tanımlarken bile hâlâ func anahtar kelimesini kullanır. Elbette, struct gibi belirli bir tipe bağlı olmak metotlara önemli bir “süper güç” kazandırır: Aynı tipin içindeki diğer property’lere ve metotlara erişebilirler. Bu sayede, örneğin bir User tipi için kullanıcının adını, yaşını ve şehrini yazdıran bir describe() metodu yazabilirsiniz. Metotların bir avantajı daha vardır, ama bu biraz daha ince bir detaydır: namespace (isim alanı) kirliliğini önlerler. Bir fonksiyon oluşturduğumuzda, o fonksiyonun adı kodumuzda genel bir anlam kazanır — örneğin wakeUp() yazdığımızda, bu fonksiyon her yerden çağrılabilir. 100 fonksiyon yazarsanız 100 tane, 1000 fonksiyon yazarsanız 1000 tane “rezerve edilmiş” isim oluşur. Bu durum çok hızlı bir şekilde karmaşık hale gelebilir. Ancak işlevselliği metotlar içine koyduğumuzda, bu isimlerin nerelerde kullanılabileceğini sınırlandırmış oluruz. Artık wakeUp() tek başına rezerve edilmiş bir isim değildir; yalnızca someUser.wakeUp() yazdığımızda anlam kazanır. Bu da sözde isim kirliliğini azaltır; çünkü kodumuzun büyük kısmı metotlardan oluşuyorsa, yanlışlıkla isim çakışmaları yaşama ihtimalimiz düşer.

//MARK: How to compute property values dynamically

//Struct’ler iki tür özelliğe (property) sahip olabilir: stored property bir struct örneğinin içinde bir veri parçasını tutan değişken ya da sabittir; computed property ise her erişildiğinde değerini dinamik olarak hesaplar. Bu da computed property’lerin, stored property’ler ile fonksiyonların bir karışımı olduğu anlamına gelir: stored property gibi erişilirler, ama fonksiyon gibi çalışırlar.

struct Person {
    var age: Int
}

var person = Person(age: 20)
print(person.age)   // 20

person.age = 25     // doğrudan yazıyoruz

//Burada olan şey çok net:
//age bellekte saklanan bir değer
//Okurken bellektekini alıyoruz
//Yazarken bellektekini değiştiriyoruz
//➡️ Hiç ekstra mantık yok

struct Rectangle {
    var width: Int
    var height: Int

    var area: Int {
        width * height
    }
}

let rect = Rectangle(width: 10, height: 5)
print(rect.area)

//area bellekte saklanmıyor. Swift şunu yapıyor: “Biri area isterse → width * height hesapla, sonucu ver”

//var area: Int {
//    get {
//        width * height
//    }
//}

//rect.area = 100 ❌
//Swift diyor ki:
//“Ben bu değeri nasıl yazacağımı bilmiyorum.”
//Çünkü:
//area hesaplanıyor
//Ama nereye yazılacağı belli değil
//width mi değişsin?
//height mı değişsin?
//ikisi birden mi?
//İşte burada setter devreye giriyor.

struct Rectangle2 {
    var width: Int
    var height: Int

    var area: Int {
        get {
            width * height
        }
        set {
            width = newValue / height
        }
    }
}

//Burada:
//newValue → atanmaya çalışılan değer
//rect.area = 100 yazarsan:
//newValue = 100

//var rect = Rectangle(width: 10, height: 5)
//
//print(rect.area) // 50
//
//rect.area = 100
//
//print(rect.width)  // 20
//print(rect.area)   // 100

//Ne zaman getter–setter yazmalıyım?
//✔️ Şu durumlarda:
//Bir değer başka değerlerden hesaplanıyorsa
//Yazıldığında özel bir mantık çalışmalıysa
//Veri tutarlılığı önemliyse
//❌ Şu durumlarda gerekmez:
//Sadece saklanacak basit bir değer varsa



//MARK: How to take action when a property changes

//Swift, property observer (özellik gözlemcisi) oluşturmamıza izin verir. Bunlar, bir property değiştiğinde çalışan özel kod parçalarıdır. İki türü vardır:
//didSet: Property değiştikten sonra çalışır.
//willSet: Property değişmeden hemen önce çalışır.

struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now \(game.score)")
game.score -= 5
print("Score is now \(game.score)")
game.score += 2

//Bu kod bir Game struct’ı oluşturur ve score değerini birkaç kez değiştirir. Her değişiklikten sonra print() ile yeni skoru yazdırıyoruz. Ancak burada bir hata var: En sonda skor değişti ama yazdırılmadı.
//Property observer kullanarak bu sorunu çözebiliriz. didSet ile print() çağrısını doğrudan property’ye bağlayabiliriz. Böylece değer ne zaman ve nerede değişirse değişsin, otomatik olarak belirli bir kod çalıştırılır.

struct Game2 {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game2 = Game2()
game.score += 10
game.score -= 3
game.score += 1

//İsterseniz Swift, didSet içinde otomatik olarak oldValue sabitini de sağlar. Bu, değişiklikten önceki değeri tutar ve özel işlemler yapmak istediğinizde kullanabilirsiniz.
//Ayrıca bir de willSet vardır. Bu, property değişmeden önce çalışır ve atanacak yeni değeri newValue adıyla sağlar. Böylece yeni değere göre farklı işlemler yapabilirsiniz.

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

//Bir diziye (array) eleman eklemek (append) hem willSet hem de didSet’i tetikler. Bu yüzden kod çalıştığında oldukça fazla çıktı üretir.
//Pratikte willSet, didSet’e göre daha az kullanılır; ancak yine de zaman zaman karşınıza çıkabilir, bu yüzden varlığını bilmek önemlidir.

//Property değiştiğinde ilgili fonksiyonu çağırmayı hatırlamak tamamen size kalmıştır. Eğer unutursanız, kodunuzda gizemli hatalar oluşabilir. Öte yandan, işlevselliği didSet kullanarak doğrudan property’ye bağlarsanız, bu her zaman gerçekleşir. Böylece kontrolü Swift’e devretmiş olursunuz ve zihninizi daha ilginç problemlere odaklayabilirsiniz.
//Ancak property observer kullanmanın kötü bir fikir olduğu bir durum vardır: içine yavaş (maliyetli) işlemler koyduğunuzda. Örneğin User adında bir struct’ınız ve içinde age adında bir Int property olduğunu düşünün. age değerini değiştirmenin neredeyse anında gerçekleşmesini beklersiniz – sonuçta bu sadece bir sayı. Eğer didSet içine zaman alan ağır işlemler koyarsanız, basit bir tamsayı değişikliği bile beklediğinizden çok daha uzun sürebilir ve bu da çeşitli performans sorunlarına yol açabilir.


//MARK: How to create custom initializers

//Initializer’lar (başlatıcılar), yeni bir struct örneğini kullanıma hazır hale getirmek için tasarlanmış özel metotlardır. Daha önce, bir struct içine koyduğumuz özelliklere (property) göre Swift’in bizim için sessizce bir initializer oluşturduğunu görmüştük. Ancak tek bir altın kurala uyduğunuz sürece kendi initializer’ınızı da yazabilirsiniz: initializer sona erdiğinde tüm özellikler bir değere sahip olmalıdır.

struct Player {
    let name: String
    let number: Int
}

let player = Player(name: "Megan R", number: 15)

//Bu kod, iki özelliği için değer sağlayarak yeni bir Player örneği oluşturur. Swift buna memberwise initializer der; yani her özelliği tanımlandığı sıraya göre parametre olarak alan bir initializer.

struct Player2 {
    let name2: String
    let number2: Int
    
    init(name: String, number: Int) {
        self.name2 = name
        self.number2 = number
    }
}

//func anahtar kelimesi yoktur. Sözdizimi olarak bir fonksiyona benzer, ancak Swift initializer’ları özel olarak ele alır.
//Yeni bir Player örneği oluşturmasına rağmen initializer’ların açıkça bir dönüş tipi (return type) yoktur – her zaman ait oldukları türü döndürürler.
//Parametreleri property’lere atarken self kullandım. Bu, “name parametresini benim name property’me ata” anlamını netleştirir.

struct Player3 {
    let name3: String
    let number3: Int
    
    init(name: String) {
        self.name3 = name
        number3 = Int.random(in: 1...99)
    }
}

let player3 = Player3(name: "Megan R")
print(player3.number3)

//Yine altın kuralı unutmayın: initializer sona erdiğinde tüm property’ler bir değere sahip olmalıdır. Eğer number için initializer içinde bir değer atamasaydık, Swift kodu derlemeyi reddederdi.Önemli: Struct içindeki diğer metotları initializer içinde çağırabilirsiniz, ancak bunu tüm property’lere değer atamadan önce yapamazsınız – Swift her şeyin güvenli olduğundan emin olmak ister.

//İsterseniz struct’larınıza birden fazla initializer ekleyebilir, ayrıca dış parametre isimleri (external parameter names) ve varsayılan değerler gibi özelliklerden yararlanabilirsiniz. Ancak kendi custom initializer’ınızı yazdığınız anda, Swift’in otomatik olarak oluşturduğu memberwise initializer’ı kaybedersiniz (onu korumak için ekstra adımlar atmadığınız sürece). Bu kasıtlıdır: Eğer özel bir initializer yazdıysanız, Swift sizin property’leri özel bir şekilde başlatmanız gerektiğini varsayar ve bu nedenle varsayılan initializer’ı artık sunmaz.


