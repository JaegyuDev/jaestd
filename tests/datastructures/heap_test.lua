local Heap = require("jaestd.datastructures.heap")
local test_utils = require("tests.test_utils")

local function test_min_heap()
    local heap = Heap.new()

    heap:push(5)
    heap:push(3)
    heap:push(7)
    heap:push(1)

    assert(heap:peek() == 1, "Min heap should have smallest element at the top")
    assert(heap:pop() == 1, "First pop should return smallest element")
    assert(heap:pop() == 3, "Second pop should return next smallest element")
    assert(heap:pop() == 5, "Third pop should return next smallest element")
    assert(heap:pop() == 7, "Fourth pop should return next smallest element")
    assert(heap:pop() == nil, "Pop on empty heap should return nil")

    return true
end

local function test_max_heap()
    local heap = Heap.new(function(a, b) return a > b end)

    heap:push(5)
    heap:push(3)
    heap:push(7)
    heap:push(1)

    assert(heap:peek() == 7, "Max heap should have largest element at the top")
    assert(heap:pop() == 7, "First pop should return largest element")
    assert(heap:pop() == 5, "Second pop should return next largest element")
    assert(heap:pop() == 3, "Third pop should return next largest element")
    assert(heap:pop() == 1, "Fourth pop should return next largest element")

    return true
end


-- Collect all tests
local tests = {
    ["Min Heap"] = test_min_heap,
    ["Max Heap"] = test_max_heap
}

-- If this file is run directly, run the tests
if arg and arg[0]:match("heap_test.lua$") then
    test_utils.run_tests("Heap", tests)
end

-- Return the test suite for use by the test runner
return {
    module_name = "Heap",
    tests = tests
}
