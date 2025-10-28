//
//  PropertySetterMacro.swift
//  GetterSetterMacro
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct PropertySetterMacro: PeerMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        let accessPrefix = (extractConfiguredAccessLevel(from: node)?.rawValue ?? "") + " "
        
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              let binding = varDecl.bindings.first,
              let identifier = binding.pattern.as(IdentifierPatternSyntax.self) else {
            return []
        }
        
        let propertyName = identifier.identifier.text
        let capitalized = propertyName.prefix(1).uppercased() + propertyName.dropFirst()
        let type = binding.typeAnnotation?.type ?? "Any"
        
        let isClass = declaration.parent?.as(ClassDeclSyntax.self) != nil
        let mutatingKeyword = isClass ? "" : "mutating "
        
        return [
            """
            \(raw: accessPrefix)\(raw: mutatingKeyword)func set\(raw: capitalized)(_ newValue: \(type)) {
                self.\(raw: propertyName) = newValue
            }
            """
        ]
    }
}
