//
//  PropertyGetterMacro.swift
//  GetterSetterMacro
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct PropertyGetterMacro: PeerMacro {
    
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

        
        return [
            """
            \(raw: accessPrefix)func get\(raw: capitalized)() -> \(type) {
                return self.\(raw: propertyName)
            }
            """
        ]
    }
}
