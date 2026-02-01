import UIKit

//MARK: Writing functions
func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    
    print(message)
}

printHelp()

//MARK: Accepting parameters

func multiply(firstNumber: Int, secondNumber: Int) {
    print(firstNumber * secondNumber)
}

multiply(firstNumber: 5, secondNumber: 4)

func square(number: Int) -> Int{
    return number * number
}

let result = square(number: 8)
print("Sonuç \(result)")

///Neden Çok Fazla Parametre Bir Sorundur?
///Anlaşılırlık Azalır: Bir fonksiyonu çağırmak için 7-8 farklı değer sağlamanız gerektiğini hayal edin. Her bir parametrenin ne işe yaradığını ve doğru sırada olup olmadığını anlamak için sürekli fonksiyonun tanımına geri dönüp bakmanız gerekir. Bu, kodu okumayı ve anlamayı zorlaştırır.
///Değişim Zorlaşır (Kırılganlık Artar): Fonksiyona yeni bir parametre eklemeniz veya birini çıkarmanız gerektiğinde, bu fonksiyonun çağrıldığı her yeri bulup güncellemeniz gerekir. Büyük bir projede bu, onlarca hatta yüzlerce dosyayı değiştirmek anlamına gelebilir. Bu hem zaman alıcıdır hem de hata yapma olasılığını artırır.
///Test Etmek Kabusa Döner: 6 parametreli bir fonksiyon düşünün. Her parametrenin alabileceği farklı değer kombinasyonlarını test etmeye çalıştığınızda, test senaryolarının sayısı katlanarak artar. Bu durum, fonksiyonun tüm olası durumlar için doğru çalıştığından emin olmayı neredeyse imkansız hale getirir.

///Çözüm: Parametreleri Gruplamak
///
func registerUser(name: String, email: String, age: Int, city: String, country: String, hasAcceptedTerms: Bool) {
    // Kullanıcıyı kaydetme işlemleri...
    if hasAcceptedTerms {
        print("\(name) isimli kullanıcı (\(city), \(country)) başarıyla kaydedildi.")
    }
}

// Fonksiyonu çağırmak oldukça hantal:
registerUser(name: "Selin", email: "selin@example.com", age: 28, city: "Manisa", country: "Türkiye", hasAcceptedTerms: true)


struct User {
    let name: String
    let email: String
    let age: Int
    let city: String
    let country: String
    let hasAcceptedTerms: Bool
}

func registerUser2(user: User) {
    if user.hasAcceptedTerms {
        print("\(user.name) isimli kullanıcı (\(user.city), \(user.country)) başarıyla kaydedildi.")
    }
}

let newUser = User(name: "Dilara", email: "dilara@gmail.com", age: 24, city: "Manisa", country: "Türkiye", hasAcceptedTerms: true)
registerUser2(user: newUser)

//Bu yaklaşımın faydaları:
///Anlamlılık: registerUser(user: User) fonksiyon imzası, "bir kullanıcıyı kaydet" amacını çok net bir şekilde ifade eder.
///Sürdürülebilirlik: User yapısına yeni bir özellik (örneğin phoneNumber) eklemeniz gerektiğinde, registerUser fonksiyonunun imzasını değiştirmeniz gerekmez. Bu sayede mevcut çağrıları bozmazsınız.
///Yeniden Kullanılabilirlik: User struct'ını artık uygulamanızın başka yerlerinde de (örneğin showProfile(for: User)) kullanabilirsiniz.


//MARK: Returning values

///Swift'te fonksiyonlardan değer döndürmek için return anahtar kelimesini kullanırız, ancak gerekli olmadığı özel bir durum vardır: fonksiyonumuz yalnızca tek bir ifade (expression) içerdiğinde.
///Kodumuz true, false, “Hello” veya 19 gibi tek bir değere indirgenebildiğinde, buna bir ifade (expression) deriz. İfadeler, bir değişkene atanabilen veya print() kullanılarak yazdırılabilen şeylerdir. Diğer yandan, değişken oluşturma, döngü başlatma veya koşul kontrol etme gibi eylemler gerçekleştirdiğimizde, buna bir deyim (statement) deriz. Tüm bunlar önemlidir çünkü Swift, fonksiyonumuzda yalnızca tek bir ifade olduğunda return anahtar kelimesini kullanmayı atlamamıza izin verir. Dolayısıyla, bu iki fonksiyon aynı şeyi yapar:

// return ile
func doMath() -> Int {
    return 5 + 5
}

// return olmadan
func doMoreMath() -> Int {
    5 + 5
}

///Swift bu konuda gerçekten akıllıdır ve basit if ve switch ifadelerini de benzer şekilde kullanmamıza otomatik olarak izin verir – yeter ki yeni değişkenler oluşturmak yerine doğrudan değer döndürsünler.

func greet(name: String) -> String {
    if name == "Taylor Swift" {
        "Oh wow!"
    } else {
        "Hello, \(name)"
    }
}

///Bu koşulun her iki bölümünden de doğrudan bir string döndürülür, bu yüzden buna izin verilir. Ancak, şuna izin verilmez:

//func greet2(name: String) -> String {
//    if name == "Taylor Swift" {
//        "Oh wow!"
//    } else {
//        let greeting = "Hello, \(name)" //Bu bir statement
//        return greeting
//    }
//}

///Alttaki kabul edilir:

func greet3(name: String) -> String {
    let response = if name == "Taylor Swift" {
        "Oh wow!"
    } else {
        "Hello, \(name)"
    }

    return response
}

///Bunu ilk başta anlamak genellikle biraz zordur, ancak üçlü koşul operatörü (ternary conditional operator) gibi düşünmeye çalışın:

func greet4(name: String) -> String {
    let response = name == "Taylor Swift" ? "Oh wow!" : "Hello, \(name)"
    return response
}


///Bazen bir fonksiyondan tek bir değer yerine birbiriyle ilişkili birden fazla değeri geri almak istersiniz. Örneğin, bir kişinin hem adını hem de soyadını veya bir koordinatın hem X hem de Y değerini döndürmek isteyebilirsiniz.Swift'te bu durumlar için mükemmel bir çözüm vardır: tuple'lar. Tuple, birden çok değeri tek bir bileşik değer olarak gruplamanın bir yoludur. Bir fonksiyondan tuple döndürmek için, dönüş tipi olarak parantez içinde virgülle ayrılmış veri türlerini belirtirsiniz.

func getUser() -> (String, String) {
    return ("Taylor", "Swift")
}

let user = getUser()
print("İsim \(user.0), Soyisim \(user.1) ") //Döndürülen tuple'ın elemanlarına user.0 ve user.1 gibi sayısal indekslerle erişebiliriz. Ancak bu pek okunaklı değildir; 0 ve 1'in ne anlama geldiğini hatırlamak zordur.

//Neyse ki Swift, tuple elemanlarına isimler vermemize olanak tanır.(Named Tuples) Bu, kodumuzu çok daha anlaşılır hale getirir. Fonksiyonu şimdi de isimli bir tuple döndürecek şekilde güncelleyelim:

func getUser2() -> (firstName: String, lastName: String) {
    return (firstName: "Taylor", lastName: "Swift")
}

let user2 = getUser2()
print("İsim: \(user2.firstName), Soyisim: \(user2.lastName)")

//Tuple ile çalışmanın bir başka şık yolu da onu doğrudan ayrı sabitlere veya değişkenlere "ayırmaktır". Bu, tuple'ın her bir elemanını anında kendi sabitine atamanıza olanak tanır.(Decomposition)

let (firstName, lastName) = getUser2()
print("Merhaba, \(firstName) \(lastName)")
///Bu kod, getUser() fonksiyonunu çağırır, döndürülen tuple'ın birinci elemanını firstName sabitine, ikinci elemanını ise lastName sabitine atar. Bu yöntem, özellikle döndürülen değerleri hemen ayrı ayrı kullanmanız gerektiğinde çok kullanışlıdır.


func getStatusMessage(for code: Int) -> String {
    switch code {
    case 200:
        "Success"
    case 403:
        "Forbidden"
    case 404:
        "Not Found"
    default:
        "Unknown Code"
    }
}

print(getStatusMessage(for: 404)) // "Not Found" çıktısını verir.
print(getStatusMessage(for: 500)) // "Unknown Code" çıktısını verir.

//MARK: Parameter labels

///Swift, her parametre için bize iki isim sağlama imkanı tanır: biri fonksiyonu çağırırken harici (external) olarak kullanılacak, diğeri ise fonksiyonun içinde dahili (internal) olarak kullanılacak. Bu, aralarında bir boşluk bırakarak iki isim yazmak kadar basittir.

func sayHello(to name: String) {
    print("Hello \(name)")
}

sayHello(to: "Dilara")

//MARK: Omitting parameter labels
///print() fonksiyonunu çağırırken aslında herhangi bir parametre adı göndermediğimizi fark etmiş olabilirsiniz – print(message: "Hello") yerine print("Hello") deriz.
///Kendi fonksiyonlarınızda da aynı davranışı, harici parametre adı olarak bir alt çizgi (_) kullanarak elde edebilirsiniz, şu şekilde:

func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")


//MARK: Default parameters

///endi parametrelerinize varsayılan bir değer vermek için, türünden sonra bir = işareti ve ardından vermek istediğiniz varsayılan değeri yazmanız yeterlidir. Böylece, isteğe bağlı olarak hoş bir selamlama yazdırabilen bir greet() fonksiyonu yazabiliriz:

func greet(_ person : String, nicely : Bool = true) {
    if nicely {
        print("Hello, .\(person)!")
    } else {
        print("Oh no, it's \(person) again")
    }
}

greet("Dilara")
greet("Ayşe", nicely: false)

//MARK: Variadic functions
///Bazı fonksiyonlar variadic'tir; bu, aynı türden istenilen sayıda parametre kabul ettiklerini söylemenin süslü bir yoludur. print() fonksiyonu aslında variadic'tir: eğer çok sayıda parametre gönderirseniz, hepsi aralarında boşluklarla tek bir satırda yazdırılır:

print("Haters", "gonna", "hate")

///Herhangi bir parametreyi, türünden sonra ... yazarak variadic yapabilirsiniz. Yani, bir Int parametresi tek bir tam sayıdır, oysa Int... sıfır veya daha fazla tam sayıdır – potansiyel olarak yüzlerce olabilir.

func square(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}

square(numbers: 1, 2, 3, 4, 5)

//MARK: Writing throwing functions
///Bazen fonksiyonlar kötü girdi aldıkları için veya dahili bir sorun nedeniyle başarısız olur. Swift, fonksiyonları dönüş türünden önce throws olarak işaretleyerek ve bir şeyler ters gittiğinde throw anahtar kelimesini kullanarak hata fırlatmamıza (throw errors) olanak tanır.

enum PasswordError : Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

///Kendi kendinize “bu fonksiyon karşılaştığı hataları fırlatmalı mı, yoksa belki de kendi içinde mi ele almalı?” diye düşüneceksiniz. Bu çok yaygındır ve dürüst olmak gerekirse tek bir cevabı yoktur – hataları fonksiyonun içinde ele alabilir (böylece onu hata fırlatan bir fonksiyon olmaktan çıkarabilir), tüm hataları fonksiyonu çağıran yere geri gönderebilir (“hata yayılımı” veya “error propagation” olarak adlandırılır) ve hatta bazı hataları fonksiyon içinde ele alıp bazılarını geri gönderebilirsiniz. Bunların hepsi geçerli çözümlerdir ve bir noktada hepsini kullanacaksınız.

//MARK: Running throwing functions
///Swift, programınız çalışırken hata oluşmasından hoşlanmaz, bu da hata fırlatan bir fonksiyonu yanlışlıkla çalıştırmanıza izin vermeyeceği anlamına gelir. Bunun yerine, bu fonksiyonları üç yeni anahtar kelime kullanarak çağırmanız gerekir:
///do, sorun yaratabilecek bir kod bölümünü başlatır.
///try, hata fırlatabilecek her fonksiyondan önce kullanılır.
///catch, hataları düzgün bir şekilde ele almanızı sağlar.
///Eğer do bloğunun içinde herhangi bir hata fırlatılırsa, programın akışı anında catch bloğuna atlar.

do{
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
///Bu kod çalıştığında, “You can’t use that password” (Bu parolayı kullanamazsınız) yazdırılır, ancak “That password is good” (Bu parola iyi) yazdırılmaz – bu koda asla ulaşılamaz, çünkü hata fırlatılmıştır.
///Swift'in farklı olmasının nedeni oldukça basittir: bizi her hata fırlatan fonksiyondan önce try kullanmaya zorlayarak, kodumuzun hangi bölümlerinin hataya neden olabileceğini açıkça kabul etmiş oluyoruz. Bu, özellikle tek bir do bloğunda birkaç hata fırlatan fonksiyonunuz varsa kullanışlıdır, şu şekilde:
//do {
//try throwingFunction1()
//nonThrowingFunction1()
//try throwingFunction2()
//nonThrowingFunction2()
//try throwingFunction3()
//} catch {
//// hataları ele al
//}



//MARK: inout parameters
///Bir Swift fonksiyonuna aktarılan tüm parametreler sabittir (constant), bu yüzden onları değiştiremezsiniz. Eğer isterseniz, bir veya daha fazla parametreyi inout olarak aktarabilirsiniz; bu, onların fonksiyon içinde değiştirilebileceği ve bu değişikliklerin fonksiyon dışındaki orijinal değere yansıyacağı anlamına gelir.

func doubleInPlace(number: inout Int) {
    number *= 2
}

///Bunu kullanmak için, öncelikle değişken (variable) bir tam sayı oluşturmanız gerekir – inout ile sabit tam sayılar kullanamazsınız, çünkü değiştirilebilirler. Ayrıca, parametreyi doubleInPlace fonksiyonuna aktarırken adının önüne bir "ve" işareti (&) koymanız gerekir; bu, onun inout olarak kullanıldığının farkında olduğunuzu açıkça belirtir.
var myNum = 10
doubleInPlace(number: &myNum)

///Swift'in inout parametreleri çok yaygın olarak kullanılır, ancak daha az yaygın olarak oluşturulur.

//func +(leftNumber: Int, rightNumber: Int) -> Int {
//    // kod burada
//}

///Yani, 5 + 3 yazarken aslında + adında, solda bir tam sayı (5) ve sağda bir tam sayı (3) alan ve sonuç olarak yeni bir tam sayı döndüren bir fonksiyonu çağırıyoruz. Şimdi de hem toplama hem de atama işlemini aynı anda yapan += operatörünü düşünün. Bunun bir dönüş değeri yoktur, bunun yerine orijinal değeri doğrudan değiştirir. Sonuç olarak, biraz daha şuna benzer:

func +=(leftNumber: inout Int, rightNumber: Int) {
    // kod burada
}


//CHECKPOINT
enum SqrtError: Error {
    case outOfBounds
    case noRoot
}

func squareRoot(number :Int) throws -> Int {
    
    if number < 1 || number > 10_000 {
        throw SqrtError.outOfBounds
        }
    
    for i in 1...100 {
        if i * i == number {
            return i
        }
        if i * i > number {
            throw SqrtError.noRoot
        }
    }
    throw SqrtError.noRoot
}

try squareRoot(number: 5)


