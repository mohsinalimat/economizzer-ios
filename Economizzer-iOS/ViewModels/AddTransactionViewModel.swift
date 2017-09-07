//
//  AddTransactionViewModel.swift
//  Economizzer-iOS
//
//  Created by Guilherme Souza on 06/09/17.
//  Copyright © 2017 Guilherme Souza. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

final class AddTransactionViewModel {

    enum State: Int {
        case income
        case outcome
        case transfer
    }

    let stateProperty: MutableProperty<State>
    let value: Signal<Double, NoError>

    init(state: State) {
        stateProperty = MutableProperty(state)

        value = valueStringProperty.signal
            .map { NSString(string: $0).doubleValue / 100 }
    }

    func transactionTypeChanged(to value: Int) {
        guard let newState = State(rawValue: value) else { return }
        stateProperty.value = newState
    }

    private let valueStringProperty = MutableProperty<String>("")
    func valueTextField(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            valueStringProperty.value += string
        default:
            if string.characters.count == 0 && valueStringProperty.value.characters.count != 0 {
                valueStringProperty.value = String(valueStringProperty.value.characters.dropLast())
            }
        }
        return false
    }
}
