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

