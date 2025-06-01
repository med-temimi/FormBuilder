//
//  FormBuilderViewModel.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//


import SwiftUI
import Combine

class FormBuilderViewModel: ObservableObject {
    @Published var fields: [FormFieldViewModel]
    @Published var isFormValid: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init(fields: [FormFieldViewModel]) {
        self.fields = fields

        fields.publisher
            .flatMap { $0.$error }
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.isFormValid = self?.fields.allSatisfy { $0.error == nil } ?? false
            }
            .store(in: &cancellables)
    }

    func validateAll() -> Bool {
        var isAllValid = true
        for field in fields {
            field.validate()
            if field.error != nil {
                isAllValid = false
            }
        }
        isFormValid = isAllValid
        return isAllValid
    }

    func reset() {
        for field in fields {
            field.text = ""
            field.error = nil
            field.pickerSelection = ""
            field.dateValue = Date()
        }
    }
}
