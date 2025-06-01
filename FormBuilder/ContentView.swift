//
//  ContentView.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - ViewModels
    @StateObject private var usernameField = FormFieldViewModel()
    @StateObject private var emailField = FormFieldViewModel()
    @StateObject private var phoneInputVM = CountryPhoneInputViewModel()
    @StateObject private var passwordField = FormFieldViewModel()
    @StateObject private var genderField = FormFieldViewModel()
    @StateObject private var birthdateField = FormFieldViewModel()

    @StateObject private var formBuilder: FormBuilderViewModel

    // MARK: - Init
    init() {
        let username = FormFieldViewModel()
        username.inputType = .text
        username.validation = { text in
            if text.isEmpty { return "username is required" }
            return nil
        }

        let email = FormFieldViewModel()
        email.inputType = .email
        email.validation = { text in
            if text.isEmpty { return "Email is required" }
            if !text.contains(["@", "."]) { return "Invalid email address" }
            return nil
        }

//        let phone = FormFieldViewModel()
//        phone.inputType = .number
//        phone.validation = { text in
//            if !text.isEmpty && text.count < 8 { return "Invalid phone number" }
//            return nil
//        }

        let password = FormFieldViewModel()
        password.inputType = .password
        password.validation = { text in
            if text.count < 6 { return "Password must be at least 6 characters" }
            return nil
        }

        let gender = FormFieldViewModel()
        gender.inputType = .picker(options: ["Male", "Female", "Other"])
        gender.validation = { $0.isEmpty ? "Please select a gender" : nil }

        let birthdate = FormFieldViewModel()
        birthdate.inputType = .date
        birthdate.validation = { _ in nil } // Optional field

        _usernameField = StateObject(wrappedValue: username)
        _emailField = StateObject(wrappedValue: email)
//        _phoneField = StateObject(wrappedValue: phone)
        _passwordField = StateObject(wrappedValue: password)
        _genderField = StateObject(wrappedValue: gender)
        _birthdateField = StateObject(wrappedValue: birthdate)
        _formBuilder = StateObject(wrappedValue: FormBuilderViewModel(fields: [username, email, password, gender, birthdate]))
    }

    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    AdvancedFormField(
                        viewModel: usernameField,
                        label: "Username",
                        placeholder: "Temimi___",
                        isRequired: true,
                        icon: Image(systemName: "person")
                    )
                    AdvancedFormField(
                        viewModel: emailField,
                        label: "Email",
                        placeholder: "example@domain.com",
                        isRequired: true,
                        icon: Image(systemName: "envelope")
                    )

                    PhoneInputView(viewModel: phoneInputVM)

//                    AdvancedFormField(
//                        viewModel: phoneField,
//                        label: "Phone number",
//                        placeholder: "00000000",
//                        isRequired: false,
//                        icon: Image(systemName: "phone")
//                    )

                    AdvancedFormField(
                        viewModel: passwordField,
                        label: "Password",
                        placeholder: "Enter secure password",
                        isRequired: true,
                        icon: Image(systemName: "lock")
                    )

                    AdvancedFormField(
                        viewModel: genderField,
                        label: "Gender",
                        placeholder: "Select gender",
                        isRequired: true
                    )

                    AdvancedFormField(
                        viewModel: birthdateField,
                        label: "Date of Birth",
                        isRequired: false
                    )

                    Button(action: {
                        [
                            usernameField,
                            emailField,
                            passwordField,
                            genderField,
                            birthdateField
                        ].forEach { $0.markInteractedAndValidate() }

                        if formBuilder.validateAll() {
                            print("✅ Valid form")
                            print("Username: \(usernameField.text)")
                            print("Email: \(emailField.text)")
//                            print("Phone: \(phoneField.text)")
                            print("Password: \(passwordField.text)")
                            print("Gender: \(genderField.pickerSelection)")
                            print("Birthdate: \(birthdateField.dateValue)")
                        } else {
                            print("❌ Invalid form")
                        }
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!formBuilder.isFormValid)
                }
                .padding()
            }
            .navigationTitle("Register")
        }
    }
}
