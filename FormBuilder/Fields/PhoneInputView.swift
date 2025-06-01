//
//  PhoneInputView.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//

import SwiftUI


struct PhoneInputView: View {
    @ObservedObject var viewModel: CountryPhoneInputViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Menu {
                    ForEach(viewModel.countries, id: \.id) { country in
                        Button(action: {
                            viewModel.selectedCountry = country
                        }) {
                            Text("\(country.flag) \(country.name) (\(country.dialCode))")
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedCountry?.flag ?? "🌐")
                        Text(viewModel.selectedCountry?.dialCode ?? "+000")
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                TextField("Phone Number", text: $viewModel.phoneNumber)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .frame(height: 44)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
            }

            if !viewModel.fullPhoneNumber.isEmpty {
                Text("Full number: \(viewModel.fullPhoneNumber)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
