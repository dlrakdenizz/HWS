import UIKit

//MARK: How to create your own classes

/**
 Ortak Özellikler:
 Hem sınıflar hem de yapılar aşağıdaki özellikleri paylaşır:
 Özellikler ve Yöntemler: Her ikisi de veri (özellik) tutabilir ve bu verilere işlemler yapan fonksiyonlar (yöntemler) ekleyebilir.
 Özel Başlatıcılar: Yeni bir örnek oluşturduğunuzda, her ikisinde de verilerinizi başlangıçta ayarlayabilen özel başlatıcılar (init) oluşturabilirsiniz.
 
 Sınıfların Yapılardan Farklı Olan Özellikleri:
 1) Kalıtım (Inheritance):
 Özellik: Bir sınıf, başka bir sınıfın özelliklerini ve yöntemlerini alabilir. Yani, bir sınıf başka bir sınıfın temellerini alıp onun üzerine yeni özellikler ekleyebilir.
 Örnek: Animal adında bir sınıfınız olduğunu varsayalım, bu sınıftan Dog adında bir sınıf türetirsiniz ve köpeklerin de "yürüyebilme" özelliğini almasını sağlarsınız.
 2) Kopyalama Farkı:
 Özellik: Bir sınıfın kopyasını aldığınızda, her iki kopya da aynı verilere sahip olur. Bir kopyada değişiklik yaparsanız, diğer kopya da değişir. Yapılarda ise her kopya kendi verisine sahiptir.
 Örnek: Diyelim ki bir BankAccount sınıfınız var ve bu sınıfı kopyaladınız. Eğer bir kopyada para yatırırsanız, diğer kopyada da bu para değişikliği yansır. Yapılarda ise her kopya bağımsız olur.
 3) Deinitializator:
 Özellik: Bir sınıfın son kopyası silindiğinde, Swift özel bir fonksiyon olan deinitializator'ı çalıştırabilir. Bu, sınıfın kaynaklarını temizlemek için kullanılır.
 Örnek: Bir sınıfın son örneği bellekten silindiğinde, özel bir temizlik işlemi yapmak istiyorsanız, bu fonksiyon devreye girer.
 4) Sabir Sabitler Üzerinde Değişiklik:
 Özellik: Bir sınıfı sabit (let) yapabilirsiniz, ancak onun içindeki değişken özellikleri hala değiştirebilirsiniz.
 Örnek: let game = Game() yazdığınızda, game sabit olur, ancak game.score değerini değiştirebilirsiniz. Yapılarda ise, sabit bir yapıyı değiştiremezsiniz.
 */

//Bir sınıfı başka bir sınıf üzerine inşa edebilmek, Apple’ın eski UI framework'ü UIKit'inde gerçekten önemliydi, ancak SwiftUI uygulamalarında çok daha az yaygındır. UIKit’te, sınıf A'nın sınıf B'ye dayandığı, sınıf B'nin sınıf C'ye dayandığı, sınıf C'nin sınıf D'ye dayandığı gibi uzun sınıf hiyerarşileri oluşturmak yaygındı.
//Bir üye başlangıç fonksiyonunun olmaması sinir bozucu olabilir, ancak bunun neden zor olacağını görmek umarım kolaydır, çünkü bir sınıf başka bir sınıfa dayanabilir – eğer sınıf C ekstra bir özellik ekleseydi, C, B ve A'nın tüm başlangıç fonksiyonlarını bozardı.
//Sabit bir sınıfın değişkenlerini değiştirebilmek, sınıfların çoklu kopya davranışıyla bağlantılıdır: sabit bir sınıf, kopyamızın hangi potaya işaret ettiğini değiştiremeyeceğimiz anlamına gelir, ancak özellikler değişken olduğunda veriyi hala değiştirebiliriz. Bu, her kopyasının benzersiz olduğu ve kendi verisini taşıdığı yapılarla farklıdır.
//Bir sınıf örneği birkaç yerde referans alınabileceği için, son kopyanın ne zaman yok edildiğini bilmek önemli hale gelir. İşte burada deinitializator devreye girer: son kopya yok olduğunda tahsis ettiğimiz özel kaynakları temizlememize olanak tanır.

//MARK: How to make one class inherit from another

//Swift, mevcut sınıflara dayalı yeni sınıflar oluşturma imkanı sunar; bu işleme kalıtım (inheritance) denir. Bir sınıf, başka bir sınıfın işlevselliğini miras aldığında (bu sınıfın "ebeveyn" veya "super" sınıfı), Swift, yeni sınıfa (yani "çocuk sınıfı" veya "subclass") ebeveyn sınıfından özellikler ve yöntemlere erişim sağlar. Bu sayede, yeni sınıfın davranışını özelleştirmek için küçük eklemeler veya değişiklikler yapabiliriz.
//Bir sınıfın başka bir sınıftan kalıtım almasını sağlamak için, çocuk sınıfının adından sonra iki nokta üst üste (:) yazılır ve ardından ebeveyn sınıfının adı eklenir. Örneğin, aşağıda bir Employee (Çalışan) sınıfı bulunmaktadır; bu sınıf bir özellik ve bir başlatıcıya (initializer) sahiptir:

class Employee {
    let hours : Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

//Buradan iki tane Employee sınıfından türemiş alt sınıf oluşturabiliriz, her biri hours özelliği ve başlatıcısını kazanacaktır:

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
    
}

//Bu iki çocuk sınıfının doğrudan hours'a nasıl başvurabildiğine dikkat edin – sanki bu özellikleri kendileri eklemiş gibi, ancak sürekli tekrar etmek zorunda kalmıyoruz. Her iki sınıf da Employee sınıfından miras alır, ancak her biri kendi özelleştirmelerini ekler. Yani, her birinden bir örnek oluşturup work() metodunu çağırırsak, farklı sonuçlar alırız:

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

//Özellikleri paylaşmanın yanı sıra, yöntemleri de paylaşabilirsiniz; bu yöntemler daha sonra çocuk sınıflarından çağrılabilir. Örnek olarak, Employee sınıfına şu metodu ekleyelim. Çünkü Developer sınıfı Employee'den miras alır, artık Developer örneklerinde printSummary() metodunu çağırabiliriz, şöyle:
let novall = Developer(hours: 8)
novall.printSummary()

//Bir yöntemi miras aldıktan sonra değiştirmek istediğinizde işler biraz daha karmaşıklaşır. Örneğin, az önce printSummary() metodunu Employee sınıfına ekledik, ancak belki çocuk sınıflardan biri bu metodu biraz farklı şekilde davranacak şekilde değiştirmek istiyor.İşte burada Swift basit bir kural uygular: Eğer bir çocuk sınıfı, ebeveyn sınıfından bir metodu değiştirmek istiyorsa, çocuk sınıfındaki sürümde override anahtar kelimesi kullanılmalıdır. Bu iki şeyi yapar:
//Eğer override kullanmadan bir metodu değiştirmeye çalışırsanız, Swift kodunuzu derlemenizi engeller. Bu, yanlışlıkla bir metodu geçersiz kılmanızı engeller.
//Eğer override kullanırsanız ama metniniz aslında ebeveyn sınıfından bir metodu geçersiz kılmıyorsa, Swift kodunuzu derlemenizi engeller çünkü muhtemelen bir hata yapmışsınızdır.


//Yani, eğer Developer sınıfının özgün bir printSummary() metoduna sahip olmasını istiyorsak, bunu Developer sınıfına şu şekilde ekleriz.
//Swift, metodun nasıl geçersiz kılındığı konusunda akıllıdır: Eğer ebeveyn sınıfınızda parametre almayan bir work() metodu varsa, ancak çocuk sınıfınızda bu metodun bir string parametre almasını istiyorsanız, bu durumda override kullanmanız gerekmez çünkü ebeveyn metodunu değiştirmiyorsunuz.

//İpucu: Eğer sınıfınızın kalıtım almasını kesinlikle istemiyorsanız, onu final olarak işaretleyebilirsiniz. Bu, sınıfın başka şeylerden miras alabileceği, ancak başka sınıflar tarafından miras alınamayacağı anlamına gelir.

//MARK: How to add initializers for classes

//Daha önce belirttiğim gibi, Swift, sınıflar için otomatik olarak üye başlatıcıları (memberwise initializers) oluşturmaz. Bu, kalıtım olup olmamasına bakılmaksızın geçerlidir – asla sizin için bir üye başlatıcı oluşturmaz. Bu nedenle, ya kendi başlatıcınızı yazmanız gerekir ya da sınıfın tüm özellikleri için varsayılan değerler sağlamanız gerekir.

class Vahicle {
    let isElectric : Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

//Bu sınıfın tek bir Boolean özelliği ve bu özelliğin değerini ayarlamak için bir başlatıcı fonksiyonu vardır. Unutmayın, burada self kullanmamız, isElectric parametresini aynı isimdeki özelliğe atadığımızı açıkça belirtir.

class Car: Vahicle {
    let isConvertible : Bool
    
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

//Swift’in bizden beklediği şey, Car sınıfına hem isElectric hem de isConvertible özelliklerini içeren bir başlatıcı sağlamamızdır. Ancak isElectric değerini kendimiz saklamak yerine, onu iletmemiz gerekir – yani ebeveyn sınıfının başlatıcısını çağırmalıyız. super, Swift’in bize otomatik olarak sağladığı bir diğer değerdir; self gibi, ebeveyn sınıfımıza ait metodları çağırmamızı sağlar, örneğin başlatıcıları. İsterseniz diğer metodlarla da kullanabilirsiniz; sadece başlatıcılarla sınırlı değildir.

let teslaX = Car(isElectric: true, isConvertible: true)

//İpucu: Eğer bir alt sınıfın kendi başlatıcıları yoksa, otomatik olarak ebeveyn sınıfının başlatıcılarını miras alır.

class Instrument {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Piano: Instrument {
    var isElectric: Bool
    init(isElectric: Bool) {
        self.isElectric = isElectric
        super.init(name: "Piano")
    }
}

//Yukarıdaki gibi bir tanımda child class init'te parametre olarak almadan değer vererek de yapabiliriz.

//MARK: How to copy classes

//Swift'te, bir sınıf örneğinin tüm kopyaları aynı veriyi paylaşır, yani bir kopyada yaptığınız herhangi bir değişiklik diğer kopyaları da otomatik olarak değiştirir. Bunun nedeni, sınıfların Swift'te referans türleri olmasıdır, bu da bir sınıfın tüm kopyalarının aynı veriye işaret etmesi anlamına gelir.

class User2 {
    var username = "Anonymous"
}

//Bu sadece bir özelliğe sahip, ancak bir sınıf içinde saklandığı için tüm kopyalar arasında paylaşılacaktır.

var user1 = User2()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)
//Bu bir hata gibi görünebilir, ancak aslında bir özellik – ve gerçekten önemli bir özellik, çünkü uygulamanın tüm bölümlerinde ortak verileri paylaşmamıza olanak tanır. Gördüğünüz gibi, SwiftUI çok fazla sınıf kullanır çünkü verileri bu kadar kolay paylaşabilmesi çok önemlidir.
//Buna karşılık, yapılar (struct) verilerini kopyalar arasında paylaşmaz, yani kodumuzdaki class User'ı struct User olarak değiştirirsek farklı bir sonuç alırız: “Anonymous” ve “Taylor”yı yazdırır çünkü kopyayı değiştirmek orijinali de değiştirmez.

//Bir sınıf örneğinin benzersiz bir kopyasını oluşturmak isterseniz – buna bazen derin kopya (deep copy) denir – yeni bir örnek oluşturup tüm verilerin güvenli bir şekilde kopyalanmasını sağlamalısınız.

class User3 {
    var username = "Anonymous"

    func copy() -> User3 {
        let user = User3()
        user.username = username
        return user
    }
}

//Bu ayrımın teknik terimi "değer türleri (value types) vs referans türleri (reference types)"dir. Yapılar değer türleridir, yani 5 gibi bir sayı veya "merhaba" gibi bir string gibi basit değerleri tutarlar. Yapınızın ne kadar çok özelliği veya metodu olursa olsun, hala bir sayı gibi tek bir basit değer olarak kabul edilir. Öte yandan, sınıflar referans türleridir; yani başka bir yerdeki bir değere atıfta bulunurlar.
//Birçok programlama konusunda olduğu gibi, yaptığınız seçimler bir miktar mantığınızı da yansıtmalıdır. Bu durumda, bir sınıf yerine bir yapı kullanmak, verinin bir şekilde paylaşılmasını istediğinizi ve birçok farklı kopya yerine tek bir paylaşılmış veri kullanmak istediğinizi güçlü bir şekilde ileten bir mesajdır.

//MARK: How to create a deinitializer for a class

//Swift’te class’lara isteğe bağlı olarak bir deinitializer (yıkıcı) eklenebilir. Bu, initializer (başlatıcı)’ın tam tersine benzer: initializer nesne oluşturulurken çağrılır, deinitializer ise nesne yok edilirken çağrılır.

//Bununla ilgili birkaç küçük kural vardır:
//Tıpkı initializer’larda olduğu gibi, deinitializer yazarken func kullanılmaz – bunlar özel yapılardır.
//Deinitializer’lar parametre alamaz ve veri döndüremez. Bu yüzden parantez bile kullanılmaz.
//Bir class örneğinin son kopyası yok edildiğinde, deinitializer otomatik olarak çağrılır. Örneğin, bir fonksiyon içinde oluşturulan bir nesne fonksiyon bittiğinde yok olabilir.
//Deinitializer’ları asla doğrudan çağırmayız; sistem onları otomatik olarak çalıştırır.
//Struct’ların deinitializer’ı yoktur, çünkü onları kopyalayamazsınız.

//Büyük resme baktığınızda, bunların hepsinin scope oluşturmak için süslü parantez {} kullandığını görürsünüz: koşullar, döngüler ve fonksiyonların hepsi yerel kapsam oluşturur.
//Bir değer scope dışına çıktığında, oluşturulduğu bağlam ortadan kalkıyor demektir.
//Struct’larda bu, verinin tamamen yok edilmesi anlamına gelir.
//Class’larda ise yalnızca veriye işaret eden referanslardan biri yok olur; başka referanslar hâlâ var olabilir.
//Ama son referans da yok olduğunda (yani o class örneğine işaret eden son değişken veya sabit silindiğinde), o zaman:
//alttaki veri tamamen yok edilir
//kullandığı bellek sistem tarafından geri alınır

class UserDeinit {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = UserDeinit(id: i)
    print("User \(user.id): I'm in control!")
}

print("**************************************")

var users = [UserDeinit]()

for i in 1...3 {
    let user = UserDeinit(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")


//Deinitializer ne işe yarar? Deinitializer’ın görevi, bir class örneğinin yok edildiği anı bize bildirmektir. Struct’larda bu oldukça basittir: Bir struct, onu tutan şey artık var olmadığında yok edilir. Örneğin: Eğer bir struct’ı bir metodun içinde oluşturursanız metod bittiğinde struct da yok edilir.
//Class’larda durum neden daha karmaşıktır? Class’ların kopyalanma davranışı daha karmaşıktır. Programın farklı yerlerinde aynı class’ın birden fazla kopyası bulunabilir. Ancak bu kopyaların hepsi aynı alttaki veriyi işaret eder. Bu yüzden gerçek class örneğinin ne zaman yok edildiğini anlamak zorlaşır. Gerçek yok oluş şu anda gerçekleşir: O class’a işaret eden son değişken de ortadan kalktığında.

//ARC (Automatic Reference Counting) Swift arka planda ARC (Automatic Reference Counting) adı verilen bir sistem kullanır. ARC’nin görevi: Her class örneğinin kaç referansı olduğunu takip etmek.
//Şöyle çalışır:
//Bir class’ın kopyasını aldığınızda → referans sayısı +1
//Bir kopya yok edildiğinde → referans sayısı −1
//Referans sayısı 0 olduğunda: Artık kimse o class’ı kullanmıyor demektir. Swift deinitializer’ı çağırır. Nesne tamamen yok edilir

//Struct’larda neden deinitializer yok? Basit sebep: Struct’ların her biri kendi verisinin ayrı bir kopyasına sahiptir. Bu yüzden bir struct yok edildiğinde özel bir işlem yapılmasına gerek yoktur.
//Pratikte çoğu geliştirici deinitializer’ı class’ın en sonunda yazar.


//MARK: How to work with variables inside classes

//Swift’te class’lar birer işaret tabelası (signpost) gibi çalışır: Bir class örneğinin yaptığımız her kopyası, aslında aynı temel veriye işaret eden bir tabeladır. Bu çoğunlukla bir kopyayı değiştirdiğimizde diğerlerinin de değişmesinde önemlidir, ama aynı zamanda class’ların değişken özellikleri (variable properties) nasıl ele aldığı konusunda da önemlidir.

class UserChangeProperty {
    var name = "Paul"
}

let user = UserChangeProperty()
user.name = "Taylor"
print(user.name)

//Bu kod sabit (constant) bir User nesnesi oluşturur, ama sonra onu değiştirir – yani sabit bir değeri değiştiriyor gibi görünür. Aslında sabit değer değişmiyor. Evet, class içindeki veri değişti, ama class örneğinin kendisi değişmedi. Oluşturduğumuz nesne hâlâ aynı nesne ve biz onu let ile sabit yaptığımız için zaten değiştirilemez.Bunu şöyle düşünebilirsiniz: Biz bir kullanıcıyı gösteren sabit bir tabela koyduk. Ama kullanıcının isim etiketini silip yeni bir isim yazdık. Kullanıcının kendisi değişmedi – hâlâ aynı kişi – sadece içindeki bir bilgi değişti. Eğer name özelliğini de let ile sabit yapsaydık, o zaman değiştirilemezdi. Yani kullanıcıyı gösteren sabit bir tabela var ve ismi kalıcı mürekkeple yazılmış, artık silinemez.


//Eğer hem user nesnesini hem de name özelliğini değişken (var) yaparsak, o zaman: özelliği değiştirebiliriz istersek tamamen yeni bir User nesnesiyle değiştirebiliriz. Bunu tabela benzetmesiyle düşünürsek, tabelayı başka bir kişiyi gösterecek şekilde çevirmek gibidir.

class UserChangeProperty2 {
    var name = "Paul"
}

var userX = UserChangeProperty2()
userX.name = "Taylor"
userX = UserChangeProperty2()
print(userX.name)

//Bu kod "Paul" yazdırır. Çünkü: Önce name değerini "Taylor" yaptık. Sonra user nesnesini tamamen yeni bir User ile değiştirdik. Yeni nesne tekrar "Paul" değeriyle başlar.

//Eğer nesne değişken ama özellik sabit olursa: yeni bir User oluşturabiliriz ama oluşturulduktan sonra özellikleri değiştirilemez.


//Böylece dört farklı kombinasyon oluşur
//Sabit nesne, sabit özellik
//→ Hep aynı kullanıcıyı gösteren tabela, ismi hiç değişmez.

//Sabit nesne, değişken özellik
//→ Tabela hep aynı kullanıcıyı gösterir, ama kullanıcının adı değişebilir.

//Değişken nesne, sabit özellik
//→ Tabela farklı kullanıcıları gösterebilir, ama isimleri değişmez.

//Değişken nesne, değişken özellik
//→ Tabela farklı kullanıcıları gösterebilir ve isimleri de değişebilir.


//Struct’larda bu durum farklıdır çünkü:
//Struct’lar tabelaya benzemez, veriyi doğrudan içinde tutar.
//Bu yüzden sabit bir struct’ın özellikleri değiştirilemez, özellikler var olsa bile.
//Çünkü struct içindeki bir değeri değiştirmek demek struct’ın kendisini değiştirmek demektir. Ama struct sabitse bu mümkün değildir.

//Bu durumun bir avantajı da vardır:
//Class’larda veri değiştiren metotlar için mutating yazmamıza gerek yoktur.
//Bu anahtar kelime struct’lar için önemlidir çünkü:
//sabit struct’ların özellikleri değiştirilemez
//bu yüzden Swift, mutating bir metot sabit struct üzerinde çağrılırsa hata verir.
//Class’larda ise:
//nesnenin var veya let olması önemli değildir
//önemli olan özelliğin kendisinin var mı let mi olduğudur.









//MARK: CHECKPOINT 7
class Animal {
    var legCount : Int
    init(legCount: Int) {
        self.legCount = legCount
    }
}

//Dog
class Dog: Animal {
    func speak() {
        print("Woof!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Arf!")
    }
}

class Poddle: Dog {
    override func speak() {
        print("Bark!")
    }
}

//Cat
class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool, legCount: Int) {
        self.isTame = isTame
        super.init(legCount: legCount)
    }
    
    func speak() {
        print("Meow!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meowwww")
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar")
    }
}

let corgi = Corgi(legCount: 4)
print(corgi.legCount)
corgi.speak()

let lion = Lion(isTame: false, legCount: 4)
print(lion.legCount)
lion.speak()
