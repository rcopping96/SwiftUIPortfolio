//
//  Binding-OnChange.swift
//  Portfolio
//
//  Created by Rob Copping on 07/01/2021.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping() -> Void) -> Binding<Value> {
        Binding(
            get: {self.wrappedValue},
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
