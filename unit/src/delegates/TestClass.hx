package delegates;

import hx.delegates.Delegate;

final class TestClass {
    
    public var delegate : Delegate<Void->Int>;

    public function new() { }

    public static var TestValue : Int = 5;
}
