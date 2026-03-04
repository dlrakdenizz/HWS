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
