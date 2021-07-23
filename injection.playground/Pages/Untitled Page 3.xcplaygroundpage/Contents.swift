//: [Previous](@previous)

import Foundation

class Person: NSObject {
    // 创建参数
    @objc var name : String?
    var address : String?
    var contact : [Person] = []
    // 初始化
    init(name:String , address:String) {
        super.init()
        self.name = name
        self.address = address
    }
}

let NetWork = Person.init(name: "NetWork小贱", address: "北京-朝阳")
let NetWork1 = Person.init(name: "NetWork小贱-All", address: "北京-朝阳-高碑店")

//let name1 = NetWork.value(forKey: #keyPath(Person.name))
//print(name1!)

let name1 = NetWork.value(forKey: #keyPath(Person.name))
print(name1!)

type(of: \Person.name)
//: [Next](@next)
