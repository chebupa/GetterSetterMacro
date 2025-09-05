import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct GetterSetterMacroPlugin: CompilerPlugin {
    
    let providingMacros: [Macro.Type] = [
        ObjectGetterMacro.self,
        ObjectSetterMacro.self,
        PropertyGetterMacro.self,
        PropertySetterMacro.self,
        NoPropGetterMacro.self,
        NoPropSetterMacro.self
    ]
}
