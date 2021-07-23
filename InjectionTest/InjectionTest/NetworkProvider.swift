//
//  NetworkProvider.swift
//  InjectionTest
//
//  Created by kai jin on 2021/7/22.
//

import Foundation

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

//需要使用者实现的
//InjectionKey的实现
private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}
//InjectedValues中定义新的属性，计算属性中使用前一步的InjectionKey
extension InjectedValues {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set {
            Self[NetworkProviderKey.self] = newValue
        }
    }
}

