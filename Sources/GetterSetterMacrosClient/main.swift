import GetterSetterMacros


@ObjGetter()
@ObjSetter()
struct TestStruct {
    
    private var prop1: Int = 1
    private var prop2: Int = 1
    private var prop3: Int = 1
    private var prop4: Int = 1
    private var prop5: Int = 1
    private var prop6: Int = 1
    private var prop7: Int = 1
    private var prop8: Int = 1
}

let testStruct = TestStruct()


@ObjGetter()
@ObjSetter()
class TestClass {
    
    private var prop1: Int
    private var prop2: Int
    private var prop3: Int
    private var prop4: Int
    private var prop5: Int
    private var prop6: Int
    private var prop7: Int
    private var prop8: Int
    
    init(
        prop1: Int = 0,
        prop2: Int = 0,
        prop3: Int = 0,
        prop4: Int = 0,
        prop5: Int = 0,
        prop6: Int = 0,
        prop7: Int = 0,
        prop8: Int = 0
    ) {
        self.prop1 = prop1
        self.prop2 = prop2
        self.prop3 = prop3
        self.prop4 = prop4
        self.prop5 = prop5
        self.prop6 = prop6
        self.prop7 = prop7
        self.prop8 = prop8
    }
}

let testClass = TestClass()
