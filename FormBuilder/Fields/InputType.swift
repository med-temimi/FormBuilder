//
//  InputType.swift
//  FormBuilder
//
//  Created by Macbook Pro  M'ed on 01/06/25.
//


import Foundation

enum InputType {
    case text
    case email
    case number
    case password
    case date
    case picker(options: [String])
}
