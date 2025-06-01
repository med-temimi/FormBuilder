//
//  CountryPhoneInputViewModel.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//

import Foundation
import Combine


class CountryPhoneInputViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var selectedCountry: Country?
    @Published var phoneNumber: String = ""

    var fullPhoneNumber: String {
        guard let code = selectedCountry?.dialCode else { return phoneNumber }
        return "\(code) \(phoneNumber)"
    }

    init() {
        loadCountries()
        selectedCountry = countries.first
    }

    private func loadCountries() {
        if let url = Bundle.main.url(forResource: "CountryPhoneCodes", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([Country].self, from: data) {
            countries = decoded.sorted { $0.name < $1.name }
        }
    }
}

struct Country: Identifiable, Codable, Hashable {
    let id: String // country code like "TN"
    let name: String
    let dialCode: String

    var flag: String {
        id
            .uppercased()
            .unicodeScalars
            .map { UnicodeScalar(127397 + $0.value)! }
            .map { String($0) }
            .joined()
    }
}
