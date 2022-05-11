//
//  InjectedValues.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import Foundation

struct InjectedValues {
    private static var current = InjectedValues()

    static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

// MARK: - List of injected values

private struct RemoteResultServiceKey: InjectionKey {
    static var currentValue: ResultService = FirebaseResultService()
}

private struct LocalResultServiceKey: InjectionKey {
    static var currentValue: LocalResultService = LocalResultService()
}

extension InjectedValues {
    var remoteResultService: ResultService {
        get { Self[RemoteResultServiceKey.self] }
        set { Self[RemoteResultServiceKey.self] = newValue }
    }

    var localResultService: LocalResultService {
        get { Self[LocalResultServiceKey.self] }
        set { Self[LocalResultServiceKey.self] = newValue }
    }
}
