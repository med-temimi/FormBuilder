# 📋 FormBuilder - Advanced SwiftUI Form Input Handler

FormBuilder is a customizable and lightweight SwiftUI utility that simplifies complex form input handling with support for:

- Custom validation logic
- Real-time and deferred validation
- Support for various input types (text, email, password, picker, date, phone)
- Country phone code picker with flags 🇹🇳
- Seamless integration in SwiftUI apps

## 🚀 Features

- ✅ Reusable form field view model
- 📦 Built-in validation for common types (email, password, etc.)
- 🌍 Country picker for phone input with flag emojis and dialing codes
- 🔒 Supports secure inputs and required field indicators
- 🧠 Tracks user interaction for intelligent validation feedback

## 🧱 Structure

- `FormFieldViewModel`: Handles the state, validation, and interaction logic per field.
- `FormBuilderViewModel`: Manages multiple fields, global validation state.
- `AdvancedFormField`: SwiftUI component that binds directly to a `FormFieldViewModel`.
- `CountryPhonePickerView`: UI for selecting country flags and codes.
- `CountryPhoneCodes.json`: A full list of countries, ISO codes, and dialing codes.

## 📦 Installation

Simply copy the `FormBuilder` directory into your SwiftUI project.

## 🛠 Usage

```swift

@StateObject var username = FormFieldViewModel()
username.inputType = .text
username.validation = { $0.isEmpty ? "Username required" : nil }

AdvancedFormField(viewModel: username, label: "Username", placeholder: "Your username")

```
For full example, see ContentView.swift.

🌐 Country Phone Code Example:

```swift

phoneField.inputType = .phone
phoneField.validation = { number in
    number.count < 8 ? "Too short" : nil
}

```

