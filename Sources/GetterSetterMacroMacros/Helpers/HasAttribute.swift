//
//  File.swift
//  GetterSetterMacro
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax

func hasAttribute(_ decl: VariableDeclSyntax, named name: String) -> Bool {
    for member in decl.attributes {
        if let attr = member.as(AttributeSyntax.self),
           attr.attributeName.description.trimmingCharacters(in: .whitespacesAndNewlines) == name {
            return true
        }
    }
    return false
}
