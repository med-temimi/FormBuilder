    //
    //  FormFieldViewModel.swift
    //  FormBuilder
    //
    //  Created by Macbook Pro  M'ed on 01/06/25.
    //


import SwiftUI
import Combine

class FormFieldViewModel: ObservableObject, Identifiable {
    @Published var text: String = ""
    @Published var error: String? = nil
    @Published var dateValue: Date = Date()
    @Published var hasInteracted: Bool = false
    @Published var pickerSelection: String = ""
    
    var validation: ((String) -> String?)?
    let id = UUID()
    var inputType: InputType = .text
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $text
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _value in
                guard let self = self else { return }
                if self.hasInteracted {
                    self.validate()
                }
            }
            .store(in: &cancellables)
        
        
        $pickerSelection
            .sink { [weak self] _value in
                guard let self = self else { return }
                if self.hasInteracted {
                    self.validate()
                }
            }
            .store(in: &cancellables)
        
        $dateValue
            .sink { [weak self] _value in
                guard let self = self else { return }
                if self.hasInteracted {
                    self.validate()
                }
            }
            .store(in: &cancellables)
    }
    
    func validate() {
        switch inputType {
            case .picker:
                error = validation?(pickerSelection)
            case .date:
                error = validation?(dateValue.description)
            default:
                error = validation?(text)
        }
    }
    
    var isValid: Bool {
        error == nil
    }
    
    func markInteractedAndValidate() {
        hasInteracted = true
        validate()
    }
}
