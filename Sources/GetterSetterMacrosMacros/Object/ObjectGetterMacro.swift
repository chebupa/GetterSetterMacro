//
//  ObjectGetterMacro.swift
//  GetterSetterMacros
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

//public struct ObjectGetterMacro: MemberMacro {
//    
//    public static func expansion(
//        of node: AttributeSyntax,
//        providingMembersOf decl: some DeclGroupSyntax,
//        in context: some MacroExpansionContext
//    ) throws -> [DeclSyntax] {
//
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
//            return """
//        func get\(raw: capitalized)() -> \(binding.typeAnnotation?.type ?? "Any") {
//            return self.\(raw: propertyName)
//        }
//        """
//        }
//    }
//}

public struct ObjectGetterMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        let accessPrefix = (extractConfiguredAccessLevel(from: node)?.rawValue ?? "") + " "
        
        //        decl already works for structs, classes, and actors
        return decl.memberBlock.members.compactMap { member in
            guard let varDecl = member.decl.as(VariableDeclSyntax.self),
                  let binding = varDecl.bindings.first,
                  let identifier = binding.pattern.as(IdentifierPatternSyntax.self)
            else {
                return nil
            }
            
            guard !hasAttribute(varDecl, named: "PropGetter") else { return nil }

            
            let propertyName = identifier.identifier.text
            let capitalized = propertyName.prefix(1).uppercased() + propertyName.dropFirst()
            
            return """
                \(raw: accessPrefix)func get\(raw: capitalized)() -> \(binding.typeAnnotation?.type ?? "Any") {
                    return self.\(raw: propertyName)
                }
                """
        }
        
//        return decl.memberBlock.members.compactMap { member in
//            guard
//                let varDecl = member.decl.as(VariableDeclSyntax.self),
//                let binding = varDecl.bindings.first,
//                let identifier = binding.pattern.as(IdentifierPatternSyntax.self)
//            else { return nil }
//            
//            let propertyName = identifier.identifier.text
//            let capitalized = propertyName.prefix(1).uppercased() + propertyName.dropFirst()
//            let returnType = binding.typeAnnotation?.type.description
//                .trimmingCharacters(in: .whitespacesAndNewlines) ?? "Any"
//            
//            // если accessKeyword пустой — это internal: опускаем модификатор
//            let accessPrefix = accessKeyword.isEmpty ? "" : "\(accessKeyword) "
//            
//            return DeclSyntax("""
//            \(raw: accessPrefix)func get\(raw: capitalized)() -> \(raw: returnType) {
//                self.\(raw: propertyName)
//            }
//            """)
//        }
    }
}
