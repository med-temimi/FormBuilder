//
//  AdvancedFormField.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//


import SwiftUI

struct AdvancedFormField: View {
    @ObservedObject var viewModel: FormFieldViewModel

    var label: String
    var placeholder: String = ""
    var isRequired: Bool = false
    var icon: Image? = nil

    var borderColor: Color = Color.gray.opacity(0.3)
    var focusedBorderColor: Color = Color.accentColor
    var errorColor: Color = .red
    var textColor: Color = .primary
    var font: Font = .body

    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label + (isRequired ? " *" : ""))
                .font(.caption)
                .foregroundColor(.secondary)

            Group {
                switch viewModel.inputType {
                case .password:
                    HStack {
                        iconView
                        if isSecure {
                            SecureField(placeholder, text: $viewModel.text)
                                .focused($isFocused)
                        } else {
                            TextField(placeholder, text: $viewModel.text)
                                .focused($isFocused)
                        }
                        Button(action: { isSecure.toggle() }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }

                case .picker(let options):
                    Picker(selection: $viewModel.pickerSelection, label: Text(placeholder)) {
                        ForEach(options, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(10)

                case .date:
                    DatePicker("", selection: $viewModel.dateValue, displayedComponents: .date)
                        .labelsHidden()
                        .padding(10)

                default:
                    HStack {
                        iconView
                        TextField(placeholder, text: $viewModel.text)
                            .keyboardType(keyboardType(for: viewModel.inputType))
                            .focused($isFocused)
                    }
                }
            }
            .font(font)
            .foregroundColor(textColor)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.error != nil ? errorColor : (isFocused ? focusedBorderColor : borderColor), lineWidth: 1)
            )

            if let error = viewModel.error, !error.isEmpty {
                Text(error)
                    .font(.caption)
                    .foregroundColor(errorColor)
            }
        }
    }

    private var iconView: some View {
        Group {
            if let icon = icon {
                icon
                    .foregroundColor(.gray)
            }
        }
    }

    private func keyboardType(for type: InputType) -> UIKeyboardType {
        switch type {
        case .email: return .emailAddress
        case .number: return .numberPad
        default: return .default
        }
    }
}
