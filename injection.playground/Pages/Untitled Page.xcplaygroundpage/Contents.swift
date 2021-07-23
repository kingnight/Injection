import UIKit

protocol NetworkProviding {
    func requestData()
}

struct NetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `NetworkProvider`")
    }
}

struct MockedNetworkProvider: NetworkProviding {
    func requestData() {
        print("Data requested using the `MockedNetworkProvider`")
    }
}

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}
//
private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}

/// Provides access to injected dependencies.
struct InjectedValues {
    
    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript accessor for updating and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

extension InjectedValues {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

struct DataController {
    @Injected(\.networkProvider) var networkProvider: NetworkProviding
    
    func performDataRequest() {
        networkProvider.requestData()
    }
    
    func printNetworkProvider() {
        print(networkProvider)
    }
}


var dataController = DataController()
dataController.printNetworkProvider()
//print(dataController.networkProvider) // prints: NetworkProvider()

InjectedValues[\.networkProvider] = MockedNetworkProvider()
dataController.printNetworkProvider()
//print(dataController.networkProvider) // prints: MockedNetworkProvider()

dataController.networkProvider = NetworkProvider()
dataController.printNetworkProvider()
//print(dataController.networkProvider) // prints 'NetworkProvider' as we overwritten the property wrapper wrapped value

dataController.performDataRequest() // prints: Data requested using the 'NetworkProvider'
