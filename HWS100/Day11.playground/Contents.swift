import UIKit


//MARK: How to limit access to internal data using access control

//Erişim kontrolü (access control), kodunuzun diğer bölümlerinin karışmaması gereken yerlere müdahale etmesini engelleme sanatıdır. Belirli özelliklere ve metotlara erişimi gizlemek, kodumuzu daha iyi hale getirebilir çünkü ona erişebilen yerlerin sayısı azalır.
//Varsayılan olarak Swift’teki struct’lar, özelliklerine (properties) ve metotlarına serbestçe erişmemize izin verir. Ancak çoğu zaman istediğiniz bu değildir – bazen bazı verileri dış erişimden gizlemek istersiniz. Örneğin, özelliklere dokunmadan önce belirli bir mantık çalıştırmanız gerekebilir ya da bazı metotların belirli bir sırayla çağrılması gerektiğini biliyor olabilirsiniz. Bu yüzden dışarıdan doğrudan erişilmelerini istemezsiniz.

struct BankAccount {
    var funds = 0
    
    mutating func deposit (amount: Int) {
        funds += amount
    }
    
    mutating func withdraw (amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Parayı başarıyla çektiniz")
} else {
    print("Para çekilemedi")
}

//Ancak funds özelliği dışarıya açık durumda.
account.funds -= 1000 //Bu, insanların sahip olduklarından daha fazla para çekmesini engellemek için yazdığımız mantığı tamamen devre dışı bırakır ve programımızın garip şekillerde davranmasına neden olabilir.Bunu çözmek için Swift’e funds özelliğinin yalnızca struct’ın içinde erişilebilir olması gerektiğini söyleyebiliriz – yani sadece struct’a ait metotlar, hesaplanmış özellikler (computed properties), property observer’lar vb. tarafından erişilebilir olsun.

private var funds = 0

//Artık funds özelliğine struct dışından erişilemez, ancak deposit() ve withdraw() metotlarının içinden erişilebilir. Struct dışından funds’u okumaya veya yazmaya çalışırsanız Swift kodunuzu derlemeyi reddeder. Buna erişim kontrolü (access control) denir, çünkü bir struct’ın özellik ve metotlarına dışarıdan nasıl erişilebileceğini kontrol eder.

//Swift bize birkaç farklı seçenek sunar, ancak öğrenme aşamasında genellikle şu birkaçını bilmeniz yeterlidir:
//private: “Struct dışındaki hiçbir şey buna erişemesin.”
//fileprivate: “Bu dosya dışındaki hiçbir şey buna erişemesin.”
//public: “Herkes, her yerden erişebilsin.”
//Öğrenenler için bazen faydalı olan bir ek seçenek daha vardır: private(set). Bu şu anlama gelir: “Herkes bu özelliği okuyabilsin, ama sadece benim metotlarım yazabilsin.” Eğer BankAccount’ta bunu kullansaydık, struct dışından account.funds değerini yazdırabilirdik; ancak değeri yalnızca deposit() ve withdraw() değiştirebilirdi.
//Bu durumda, funds için en iyi seçenek bence private(set) olur: banka hesabının mevcut bakiyesini her zaman okuyabilirsiniz, ancak değeri benim mantığımdan geçmeden değiştiremezsiniz.


//Önemli: Eğer bir veya daha fazla özellik için private erişim kontrolü kullanırsanız, büyük ihtimalle kendi initializer’ınızı (başlatıcınızı) oluşturmanız gerekecektir.
//Erişim kontrolünün bir diğer avantajı da başkalarının kodumuzu nasıl gördüğünü kontrol etmemizi sağlamasıdır. Buna kodun “yüzey alanı” (surface area) denir. Düşünün: Size kullanmanız için bir struct versem ve içinde 30 tane public özellik ve metot olsa, hangilerinin gerçekten sizin kullanmanız için tasarlandığını, hangilerinin ise iç kullanım için olduğunu anlamakta zorlanabilirsiniz. Öte yandan, bunların 25’ini private olarak işaretlersem, dışarıdan kullanılmaması gerektiği hemen anlaşılır.


//MARK: Static properties and methods

//Ancak bazen – sadece bazen – bir özelliği ya da metodu belirli bir struct örneğine değil, doğrudan struct’ın kendisine eklemek istersiniz. Bu sayede onlara doğrudan struct üzerinden erişebilirsiniz. Bu tekniği SwiftUI ile özellikle iki amaç için sık kullanırım: örnek veri oluşturmak ve uygulamanın çeşitli yerlerinden erişilmesi gereken sabit verileri saklamak.

@MainActor //Bunu concurrency hatası aldığımız için yaptık. Swift burada static var şeklinde studentCount oluşturunca dedi ki buna her yerden ulaşıp aynı anda değiştirmeye çalışabilirsin o zaman race condition olur mesela iki farklı yerde studentCount += 1 yazarsan gibi, o yüzden buna MainActor dedik yanı bu ana threadde yapılacak, başka thread çağırırsa da await yazmamız gerekecek.
struct School {
    static var studentCount = 0
    
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

//Burada gördüğünüz static anahtar kelimesi, hem studentCount özelliğinin hem de add() metodunun belirli bir struct örneğine değil, doğrudan School struct’ına ait olduğu anlamına gelir.

School.add(student: "Taylor Swift")
print(School.studentCount)

//Burada School için bir örnek (instance) oluşturmadım – add() ve studentCount’u doğrudan struct üzerinden kullanabiliyoruz. Bunun sebebi ikisinin de static olmasıdır; yani struct örneklerine özgü değillerdir. Bu durum ayrıca studentCount özelliğini değiştirirken metodun mutating olarak işaretlenmesine gerek olmamasını da açıklar. mutating, yalnızca normal struct metotlarında, struct bir sabit olarak oluşturulduğunda ve o örneği değiştirmek istediğimizde gereklidir. Burada ise herhangi bir örnek (instance) yok.

//Static içinden normal property kullanamazsın! Yani aşağıdaki örnekte:

//struct Test {
//    var name = "Ahmet"
//
//    static func printName() {
//        print(name) // ❌ Hata! Hangi name? Hangi Test nesnesi?
//    }
//}

//Ama normal methodda static property kullanabilir:

@MainActor
struct Test {
    static var count = 0
    
    func increase() {
        Test.count += 1
    }
}

//self vs Self farkı
//self, struct’ın mevcut değerini ifade eder. Self, mevcut türü ifade eder. self ve Self arasındaki farkı unutmak kolaydır, ancak Swift’te tür isimlerinin büyük harfle başladığını düşünün (Int, Double, Bool vb.). Bu yüzden Self’in de büyük harfle başlaması mantıklıdır.
@MainActor
struct Person {
    static var total = 0
    
    func add() {
        Self.total += 1
    }
}

//MARK: CHECKPOINT

struct Car {
    
    // Sabit özellikler (değişmez)
    let model: String
    let seatCount: Int
    
    // Dışarıdan değiştirilemesin ama okunabilsin
    private(set) var currentGear: Int
    
    // Özel initializer
    init(model: String, seatCount: Int, startingGear: Int = 1) {
        self.model = model
        self.seatCount = seatCount
        
        // Güvenlik kontrolü
        if startingGear >= 1 && startingGear <= 10 {
            self.currentGear = startingGear
        } else {
            self.currentGear = 1
        }
    }
    
    // Vites artırma
    mutating func gearUp() {
        if currentGear < 10 {
            currentGear += 1
            print("Vites artırıldı: \(currentGear)")
        } else {
            print("Zaten maksimum vitesteyiz!")
        }
    }
    
    // Vites azaltma
    mutating func gearDown() {
        if currentGear > 1 {
            currentGear -= 1
            print("Vites düşürüldü: \(currentGear)")
        } else {
            print("Zaten minimum vitesteyiz!")
        }
    }
}

var myCar = Car(model: "BMW M3", seatCount: 5)

myCar.gearUp()
myCar.gearUp()
myCar.gearDown()

print(myCar.currentGear)
