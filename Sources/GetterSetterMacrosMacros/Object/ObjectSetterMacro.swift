//
//  ObjectSetterMacro.swift
//  GetterSetterMacros
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObjectSetterMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let accessPrefix = (extractConfiguredAccessLevel(from: node)?.rawValue ?? "") + " "
        // decl already works for structs, classes, and actors
        return decl.memberBlock.members.compactMap { member in
            guard let varDecl = member.decl.as(VariableDeclSyntax.self),
                  let binding = varDecl.bindings.first,
                  let identifier = binding.pattern.as(IdentifierPatternSyntax.self) else {
                return nil
            }
            
            guard !hasAttribute(varDecl, named: "PropSetter") else { return nil }
            
            let propertyName = identifier.identifier.text
            let capitalized = propertyName.prefix(1).uppercased() + propertyName.dropFirst()
            
            return """
        \(raw: accessPrefix)func set\(raw: capitalized)() -> \(binding.typeAnnotation?.type ?? "Any") {
            self.\(raw: propertyName) = newValue
        }
        """
        }
    }
}

//public struct ObjectSetterMacro: MemberMacro {
//    
//    public static func expansion(
//        of node: AttributeSyntax,
//        providingMembersOf decl: some DeclGroupSyntax,
//        in context: some MacroExpansionContext
//    ) throws -> [DeclSyntax] {
//        
//        
//        let accessKeyword = parseAccessLevel(from: node) // "" если internal
//        
//        // decl already works for structs, classes, and actors
//        return decl.memberBlock.members.compactMap { member in
//            guard let varDecl = member.decl.as(VariableDeclSyntax.self),
//                  let binding = varDecl.bindings.first,
//                  let identifier = binding.pattern.as(IdentifierPatternSyntax.self) else {
//                return nil
//            }
//            
//            let propertyName = identifier.identifier.text
//            let capitalized = propertyName.prefix(1).uppercased() + propertyName.dropFirst()
//            
//            // если accessKeyword пустой — это internal: опускаем модификатор
//            let accessPrefix = accessKeyword.isEmpty ? "" : "\(accessKeyword) "
//            
//            return """
//        \(raw: accessPrefix)func set\(raw: capitalized)() -> \(binding.typeAnnotation?.type ?? "Any") {
//            self.\(raw: propertyName) = newValue
//        }
//        """
//        }
//    }
//}
