## GetterSetterMacro — автогенерация getter/setter для Swift

Короткий набор Swift-макросов для автогенерации методов доступа для свойств:
- **@ObjGetter / @ObjSetter** — сгенерировать геттеры/сеттеры для всех свойств типа
- **@PropGetter / @PropSetter** — сгенерировать геттер/сеттер для конкретного свойства
- **@NoPropGetter / @NoPropSetter** — запретить генерацию для конкретного свойства

Поддерживаются `struct`, `class`, `actor`. Для `struct` сеттеры автоматически помечаются как `mutating`.

### Установка (Swift Package Manager)
Добавьте пакет в `Package.swift` вашего проекта:

```swift
dependencies: [
    .package(url: "https://github.com/aristarh/GetterSetterMacro", branch: "main")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["GetterSetterMacro"]
    )
]
```

Импортируйте библиотеку там, где используете макросы:

```swift
import GetterSetterMacro
```

### Доступность (Access Level)
Все макросы принимают необязательный параметр уровня доступа `AccessLevel`:
`private`, `fileprivate`, `internal`, `package`, `public`, `open`.
По умолчанию — `internal`.

Пример: `@ObjGetter(.public)` сделает сгенерированные методы публичными.

### Быстрые примеры

1) Генерация для всего типа
```swift
import GetterSetterMacro

@ObjGetter(.public)
@ObjSetter(.public)
struct User {
    private var name: String
    private var age: Int
}
// Сгенерируется: public func getName() -> String, public mutating func setName(_ newValue: String), и т.д.
```

2) Пропуск отдельных свойств
```swift
@ObjGetter()
@ObjSetter()
final class Config {
    @NoPropGetter() private var secret: String = ""
    private var title: String = ""
    @NoPropSetter() private var id: Int = 0
}
// Для secret не будет get, для id не будет set
```

3) Генерация для конкретного свойства
```swift
struct Session {
    @PropGetter(.public)
    @PropSetter(.public)
    private var token: String
}
// Сгенерируется: public func getToken() -> String
//                public mutating func setToken(_ newValue: String)
```

### Правила/поведение
- Имена методов: `get<Property>()` и `set<Property>(_: )`, где `<Property>` — имя свойства с заглавной буквы (например, `name` → `getName`/`setName`).
- Уровень доступа методов управляется аргументом макроса. Если не указан — `internal`.
- Макросы уровня типа `@ObjGetter/@ObjSetter` автоматически пропускают свойства, помеченные `@PropGetter/@PropSetter` и `@NoPropGetter/@NoPropSetter`, чтобы избежать дублирования.
- Для корректного вывода типов рекомендуется явно указывать типы свойств (иначе тип может быть сгенерирован как `Any`).
- Объявляйте свойства по одному (одна переменная на одно `var`), чтобы генерация была предсказуемой.

### Требования
- Swift 6 toolchain, SPM
- Платформы: macOS 10.15+, iOS 13+, tvOS 13+, watchOS 6+, macCatalyst 13+

Готово! Подключите пакет, примените нужные аннотации и получайте готовые методы доступа без рутины.
