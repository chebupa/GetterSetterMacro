//
//  NoPropGetterMacro.swift
//  GetterSetterMacros
//
//  Created by aristarh on 05.09.2025.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct NoPropGetterMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Маркерный макрос: не генерирует код, служит для фильтрации в ObjectGetterMacro
        return []
    }
}


