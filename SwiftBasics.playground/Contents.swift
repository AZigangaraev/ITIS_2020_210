import UIKit
/*
struct MainStruct {
    private struct Substruct {
    }

    private func doSomething() {
        let substruct = Substruct()
        print(substruct)
    }

    private func description(of person: Person) {
        print("\(person.name) is \(person.age)")
    }
}

// Зачем нужен fileprivate?
private extension Person {
}

// Other file

struct Person {
    let name: String
    let age: Int?
}

enum WithAssociatedValue: String {
    case one = "One"
    case two = "Two"
    case three
}

enum SomeData {
    case int(Int?)
    case person(Person)
    case date(Date)
    case function(() -> Void)
}

let someValue = SomeData.function({ print("Hello, world") })

switch someValue {
    case .int(.some(1..<50)):
        print("From 1 to 49")
    case .int(let int?):
        print(int)
    case .person(let person) where person.name.count > 5:
        print("Person is \(person.age)")
    case .person(let person):
        print("Person")
    default:
        break
}

class Box<T> {
    var b: T

    init(_ b: T) {
        self.b = b
    }
}

struct Foo {
    private var _box: Box<Int> = Box(0)

    var b: Int {
        get {
            _box.b
        }
        set {
            if isKnownUniquelyReferenced(&_box) {
                _box.b = newValue
            } else {
                _box = Box(newValue)
            }
        }
    }
}

var foo = Foo()
foo.b = 42
var bar = foo
bar.b = 44

*/
/*
protocol PrintingDescription {
    func printDescription()
}

protocol SomeCollection {
    associatedtype Element

    var array: [Element] { get }
    func printDescription()
}

extension SomeCollection {
    func printDescription() {
        print(array.count)
    }
}

struct AnySomeCollection: SomeCollection {
    var array: [Any]

    init<T: SomeCollection>(collection: T) {
        array = collection.array
    }
}

protocol Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool
}

class PrintingDescriptionClass {
    let foo: AnySomeCollection

    init(foo: AnySomeCollection) {
        self.foo = foo
    }
}
*/

class AsyncDictionary<K: Hashable, V> {
    private var dictionary: [K: V] = [:]
    private let queue = DispatchQueue(label: "com.itis.asyncdictionary", attributes: .concurrent)

    func getElement(key: K) -> V? {
        var result: V?
        queue.sync {
            result = dictionary[key]
        }
        return result
    }

    func getElement(key: K, completion: @escaping (V?) -> Void) {
        queue.async {
            completion(self.dictionary[key])
        }
    }

    func set(value: V, for key: K) {
        queue.async(flags: .barrier) {
//        queue.async {
            self.dictionary[key] = value
        }
    }
}
