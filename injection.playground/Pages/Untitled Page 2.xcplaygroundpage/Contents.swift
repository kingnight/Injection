//: [Previous](@previous)

import Foundation

public protocol InjectionKey {
    associatedtype Value
    //default value for the dependency injection key
    static var currentValue:Self.Value {get set}
}

struct InjectionValues{
    
    private static var current = InjectionValues()
    
    static subscript<K>(key:K.Type) -> K.Value where K:InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath:WritableKeyPath<InjectionValues,T>) ->T {
        get{ current[keyPath: keyPath] }
        set{ current[keyPath: keyPath] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath:WritableKeyPath<InjectionValues,T>
    
    var wrappedValue:T {
        get { InjectionValues[keyPath] }
        set { InjectionValues[keyPath] = newValue }
    }
    
    init(_ keyPath:WritableKeyPath<InjectionValues,T>) {
        self.keyPath = keyPath
    }
}


protocol NetworkProviding{
    func requestData()
}

struct NetworkProvider:NetworkProviding {
    func requestData() {
        print("Data requested using the `NetworkProvider`")
    }
}

struct MockedNetworkProvider:NetworkProviding{
    func requestData() {
        print("Data requested using the `MockedNetworkProvider`")
    }
}

struct NetworkProviderKey:InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}

extension InjectionValues {
    var networkProvider:NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] }
    }
}




//: [Next](@next)
