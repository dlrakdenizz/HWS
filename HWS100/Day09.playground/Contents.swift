import UIKit

//MARK: CLOSURES

//MARK: How to create and use closures

func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()

//Bir fonksiyonu kopyalarken parantezleri yazmazsınız – var greetCopy = greetUser doğrudur, var greetCopy = greetUser() değildir. Eğer parantezleri eklerseniz fonksiyonu çağırmış olursunuz ve geri dönen değeri başka bir şeye atamış olursunuz. Burada şuna dikkat etmeliyiz: parantez yazılması demek o fonksiyonu çalıştır demektir, eğer fonksiyonu çalıştırılmış olarak yazarsak greetCopy fonksiyon çıkıntısı olur ama burada bizim amacımız fonksiyonun kendisini kopyalamak ve greetCopy fonksiyonunu da çağırabilmek.

let sayHello = {
    print("Hi there!")
}

sayHello()
//Swift buna gösterişli bir isim verir: closure expression (closure ifadesi). Bu aslında, istediğimiz zaman çağırabileceğimiz ve etrafta taşıyabileceğimiz bir kod bloğu oluşturduğumuz anlamına gelir. Bunun bir adı yoktur, ancak başka açılardan bakıldığında parametre almayan ve değer döndürmeyen bir fonksiyon gibidir.

let sayHello2 = { (name: String) -> String in
    "Hi, \(name)"
}


func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data : (Int) -> String = getUserData
let user = data(1989)
print(user)

//Fonksiyon bir Int alır ve String döndürür. Ancak fonksiyonu kopyaladığımızda tür, for gibi harici parametre adlarını içermez. Bu yüzden çağırırken data(1989) yazarız, data(for: 1989) değil.
//İlginç bir şekilde, aynı kural tüm closure’lar için de geçerlidir. Daha önce yazdığımız sayHello closure’ını çağırmamıştım, çünkü çağrı sırasında parametre adı olmaması sizi şaşırtabilirdi. Şimdi çağıralım:
sayHello2("Taylor")
//Gördüğünüz gibi parametre adı yok. Yani tekrar edelim: harici parametre adları yalnızca fonksiyonları doğrudan çağırırken önemlidir, closure’larda veya fonksiyon kopyalarında değil.


//Aşağıda takım kaptanı olan Suzanne bu hep en başta olsun diğerleri alfabetik sıralansın istediğimiz bir fonksiyonu nasıl yazabileceğimi görüyoruz:
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}

let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)
//Bu fonksiyon, sorted(by:) tarafından iki isim karşılaştırıldığında hangisinin önce gelmesi gerektiğine karar vermek için kullanılır. Fonksiyon önce bu iki isimden birinin “Suzanne” olup olmadığını kontrol eder: eğer name1 Suzanne ise true döndürerek onun öne geçmesini sağlar; eğer name2 Suzanne ise false döndürerek yine Suzanne’in öne alınmasını sağlar. Eğer iki isimden hiçbiri Suzanne değilse, bu kez normal alfabetik sıralama yapılır ve name1 < name2 sonucu döndürülür. Swift bu fonksiyonu liste sıralanana kadar tekrar tekrar çağırır ve her seferinde yalnızca iki elemanı karşılaştırarak, sonunda Suzanne’in başta olduğu doğru sıralamayı oluşturur.

//MARK: How to use trailing closures and shorthand syntax

//Yukarıdaki fonksiyonda, sorted() özel bir sıralama yapmak için her türden fonksiyonu kabul edebilir, ama tek bir kuralı vardır: Bu fonksiyon, ilgili diziden iki öğe almalı (burada iki String) ve ilk string’in ikinciden önce sıralanıp sıralanmaması gerektiğini söyleyen true ya da false bir Bool döndürmelidir. Bu durumda bizim bu closure'ı yazarken iki parametrenin tipini belirtmemize gerek yok, çünkü zaten string olmak zorundalar. Dönüş tipini de belirtmemize gerek yok, çünkü zaten Bool olmak zorunda.

let captainFirstTeam2 = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

//Swift’in closure’ları daha da sadeleştirmesinin son bir yolu daha var: Swift, bizim yerimize otomatik olarak parametre isimleri verebilir. Buna “shorthand syntax” denir. Bu sözdiziminde artık name1, name2 in yazmayız; bunun yerine Swift’in sağladığı özel isimleri kullanırız: ilk string için $0, ikincisi için $1.

let captainFirstTeam3 = team.sorted {
    if $0 == "Suzanne" {
          return true
      } else if $1 == "Suzanne" {
          return false
      }
    
    return $0 < $1
    
}

let reverseTeam = team.sorted {
    return $0 > $1
}

let reverseTeam2 = team.sorted { $0 > $1 }

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

//map() ile çalışırken, döndürdüğünüz tip başlangıçtaki tip ile aynı olmak zorunda değildir – örneğin, bir Int dizisini bir String dizisine dönüştürebilirsiniz.

// MAP FUNCTION

/*
 map ne yapar?
 map:
 Dizideki her elemanı tek tek alır
 Senin verdiğin closure’a sokar
 Closure’dan dönen yeni değeri alır
 Bunlardan yeni bir dizi oluşturur
 */

let names = ["Gloria", "Suzanne"] // [String]
let nameLengths = names.map { $0.count } // [Int]

//MARK: Why does Swift have trailing closure syntax?

func animate(duration : Double, animation : () -> Void) {
    print("Starting a \(duration) second animation…")
    animation()
}

animate(duration: 3, animation: {
    print("Fade out the image")
})

// Yukarıdaki fonksiyonda kullanıcının bir animate fonksiyonu var bu fonksiyon parametre olarak Double türünde bir duration ve animation closure'ını alıyor. Closure ise parametre almıyor ve Void dönüyor. Bu şekilde closure alan fonksiyonlarda yazım kolaylığını trailing closure kullanarak yapabiliriz.

animate(duration: 3) {
    print("Fade out the image")
}

