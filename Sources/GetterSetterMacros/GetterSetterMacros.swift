// The Swift Programming Language
// https://docs.swift.org/swift-book

///// A macro that produces both a value and a string containing the
///// source code that generated the value. For example,
/////
/////     #stringify(x + y)
/////
///// produces a tuple `(x + y, "x + y")`.
//@freestanding(expression)
//public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "GetterSetterMacrosMacros", type: "StringifyMacro")

public enum AccessLevel {
    case `private`
    case `fileprivate`
    case `internal`
    case `package`
    case `public`
    case `open`
}



@attached(member, names: arbitrary)
public macro ObjGetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacrosMacros", type: "ObjectGetterMacro")

@attached(member, names: arbitrary)
public macro ObjSetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacrosMacros", type: "ObjectSetterMacro")

@attached(peer, names: arbitrary)
public macro PropGetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacrosMacros", type: "PropertyGetterMacro")

@attached(peer, names: arbitrary)
public macro PropSetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacrosMacros", type: "PropertySetterMacro")

@attached(peer, names: arbitrary)
public macro NoPropGetter() = #externalMacro(module: "GetterSetterMacrosMacros", type: "NoPropGetterMacro")

@attached(peer, names: arbitrary)
public macro NoPropSetter() = #externalMacro(module: "GetterSetterMacrosMacros", type: "NoPropSetterMacro")

