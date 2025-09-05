//
//  ExtractConfiguredAccessLevel.swift
//  GetterSetterMacros
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax

func extractConfiguredAccessLevel(from node: AttributeSyntax) -> AccessLevelModifier? {
    
    guard let arguments = node.arguments?.as(LabeledExprListSyntax.self)
    else { return nil }
    
    // NB: Search for the first argument whose name matches an access level name
    for labeledExprSyntax in arguments {
        if let identifier = labeledExprSyntax.expression.as(MemberAccessExprSyntax.self)?.declName,
           let accessLevel = AccessLevelModifier(rawValue: identifier.baseName.trimmedDescription)
        {
            return accessLevel
        }
    }
    
    return nil
}
