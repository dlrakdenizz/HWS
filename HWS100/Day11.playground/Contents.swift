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
