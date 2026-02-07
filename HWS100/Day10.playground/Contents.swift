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

