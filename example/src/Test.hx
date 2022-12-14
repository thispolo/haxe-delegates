import haxe.Timer;
import hx.delegates.Delegate;
import hx.delegates.DelegateBuilder;

class Test {

    private var outer : Int;
    private var testFunc : (Int, Int) -> Int;
    private var testDelegate : Delegate<(Int, Int) -> Int>;

    public function new() {
        outer = 5;
    }

    public function runNoninlined() {
        trace('*** Running without inlines ***');
        testFunc = myFunction;
        testDelegate = DelegateBuilder.from(myFunction);
        doTest();
    }

    public function runInlined() {
        trace('*** Running with inlines ***');
        testFunc = myInlinedFunction;
        testDelegate = DelegateBuilder.from(myInlinedFunction);
        doTest();
    }

    public function myFunction(a : Int, b : Int) : Int {
        return a + b + outer;
    }

    public inline function myInlinedFunction(a : Int, b : Int) : Int {
        return a + b + outer;
    }

    public function doTest() {
        var N = 1000000;
        var t = Timer.stamp();
        for(i in 0...N) {
            testFunc(i, i);
        }
        trace(Timer.stamp() - t);

        var t = Timer.stamp();
        for(i in 0...N) {
            testDelegate.call(i, i);
        }
        trace(Timer.stamp() - t);

    }
}