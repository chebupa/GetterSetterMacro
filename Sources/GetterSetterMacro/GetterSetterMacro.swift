// The Swift Programming Language
// https://docs.swift.org/swift-book

///// A macro that produces both a value and a string containing the
///// source code that generated the value. For example,
/////
/////     #stringify(x + y)
/////
///// produces a tuple `(x + y, "x + y")`.
//@freestanding(expression)
//public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "GetterSetterMacroMacros", type: "StringifyMacro")

/// Access level options used by the macros to control the visibility of generated APIs.
/// Mirrors Swift access control modifiers. If omitted, macros default to `.internal`.
public enum AccessLevel {
    case `private`
    case `fileprivate`
    case `internal`
    case `package`
    case `public`
    case `open`
}



/// Member macro that generates getter methods for each stored property of the type.
/// The generated method is named `get<PropertyName>()` and returns the property's type.
/// Properties annotated with `@PropGetter` or `@NoPropGetter` are skipped.
/// - Parameter accessLevel: Optional access level for the generated methods. Defaults to `.internal`.
/// - Example:
/// ```swift
/// @ObjGetter(.public)
/// struct User { private var id: Int }
/// // Generates: public func getId() -> Int
/// ```
@attached(member, names: arbitrary)
public macro ObjGetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacroMacros", type: "ObjectGetterMacro")

/// Member macro that generates setter methods for each stored property of the type.
/// The generated method is named `set<PropertyName>(_:)` and assigns the property's value.
/// For value types (e.g. `struct`), the method is marked as `mutating`.
/// Properties annotated with `@PropSetter` or `@NoPropSetter` are skipped.
/// - Parameter accessLevel: Optional access level for the generated methods. Defaults to `.internal`.
/// - Example:
/// ```swift
/// @ObjSetter(.public)
/// struct User { private var id: Int }
/// // Generates: public mutating func setId(_ newValue: Int)
/// ```
@attached(member, names: arbitrary)
public macro ObjSetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacroMacros", type: "ObjectSetterMacro")

/// Peer macro that generates a getter method for the annotated stored property only.
/// The generated method is named `get<PropertyName>()` and returns the property's type.
/// - Parameter accessLevel: Optional access level for the generated method. Defaults to `.internal`.
/// - Example:
/// ```swift
/// @PropGetter(.public)
/// private var id: Int
/// // Generates: public func getId() -> Int
/// ```
@attached(peer, names: arbitrary)
public macro PropGetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacroMacros", type: "PropertyGetterMacro")

/// Peer macro that generates a setter method for the annotated stored property only.
/// The generated method is named `set<PropertyName>(_:)` and assigns the property's value.
/// For value types, the method is marked as `mutating`.
/// - Parameter accessLevel: Optional access level for the generated method. Defaults to `.internal`.
/// - Example:
/// ```swift
/// @PropSetter(.public)
/// private var id: Int
/// // Generates: public mutating func setId(_ newValue: Int)
/// ```
@attached(peer, names: arbitrary)
public macro PropSetter(_ accessLevel: AccessLevel? = .internal) = #externalMacro(module: "GetterSetterMacroMacros", type: "PropertySetterMacro")

/// Marker peer macro that prevents `@ObjGetter` from generating a getter for this property.
/// Generates no code by itself.
@attached(peer, names: arbitrary)
public macro NoPropGetter() = #externalMacro(module: "GetterSetterMacroMacros", type: "NoPropGetterMacro")

/// Marker peer macro that prevents `@ObjSetter` from generating a setter for this property.
/// Generates no code by itself.
@attached(peer, names: arbitrary)
public macro NoPropSetter() = #externalMacro(module: "GetterSetterMacroMacros", type: "NoPropSetterMacro")

