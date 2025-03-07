local Queue = require("jaestd.datastructures.queue")
local test_utils = require("tests.test_utils")

local function test_basic_operations()
    local queue = Queue.new()

    -- Test initial state
    assert(queue:isEmpty(), "Queue should be empty initially")
    assert(queue:getSize() == 0, "Queue size should be 0 initially")
    assert(queue:peek() == nil, "Peek should return nil for empty queue")
    assert(queue:dequeue() == nil, "Dequeue should return nil for empty queue")

    -- Test enqueue
    queue:enqueue("first")
    assert(not queue:isEmpty(), "Queue should not be empty after enqueue")
    assert(queue:getSize() == 1, "Queue size should be 1 after one enqueue")
    assert(queue:peek() == "first", "Peek should return the first item")

    queue:enqueue("second")
    queue:enqueue("third")
    assert(queue:getSize() == 3, "Queue size should be 3 after three enqueues")

    -- Test dequeue
    local item = queue:dequeue()
    assert(item == "first", "Dequeue should return items in FIFO order")
    assert(queue:getSize() == 2, "Queue size should decrease after dequeue")
    assert(queue:peek() == "second", "Peek should now return the new front item")

    item = queue:dequeue()
    assert(item == "second", "Dequeue should return the second item")

    item = queue:dequeue()
    assert(item == "third", "Dequeue should return the third item")

    assert(queue:isEmpty(), "Queue should be empty after all items are dequeued")

    return true
end

local function test_circular_behavior()
    -- Create a small queue to test circular behavior
    local queue = Queue.new(4)

    -- Fill the queue
    queue:enqueue("A")
    queue:enqueue("B")
    queue:enqueue("C")
    queue:enqueue("D")

    -- Remove some items
    assert(queue:dequeue() == "A", "First dequeue should be A")
    assert(queue:dequeue() == "B", "Second dequeue should be B")

    -- Add more items to wrap around
    queue:enqueue("E")
    queue:enqueue("F")

    -- Verify queue contents by dequeueing all
    assert(queue:dequeue() == "C", "Third dequeue should be C")
    assert(queue:dequeue() == "D", "Fourth dequeue should be D")
    assert(queue:dequeue() == "E", "Fifth dequeue should be E")
    assert(queue:dequeue() == "F", "Sixth dequeue should be F")

    return true
end

local function test_resize()
    local queue = Queue.new(3) -- Start with small capacity

    -- Fill beyond initial capacity
    queue:enqueue("A")
    queue:enqueue("B")
    queue:enqueue("C")
    queue:enqueue("D") -- This should trigger resize
    queue:enqueue("E")

    assert(queue:getSize() == 5, "Queue size should be 5")
    assert(queue:getCapacity() >= 5, "Queue capacity should have increased")

    -- Verify all elements were preserved
    assert(queue:dequeue() == "A", "First element should be A")
    assert(queue:dequeue() == "B", "Second element should be B")
    assert(queue:dequeue() == "C", "Third element should be C")
    assert(queue:dequeue() == "D", "Fourth element should be D")
    assert(queue:dequeue() == "E", "Fifth element should be E")

    return true
end

local function test_clear()
    local queue = Queue.new()

    -- Add some items
    queue:enqueue("A")
    queue:enqueue("B")
    queue:enqueue("C")

    -- Clear the queue
    queue:clear()

    -- Verify queue is empty
    assert(queue:isEmpty(), "Queue should be empty after clear")
    assert(queue:getSize() == 0, "Queue size should be 0 after clear")
    assert(queue:peek() == nil, "Peek should return nil after clear")

    -- Verify we can still use the queue
    queue:enqueue("D")
    assert(queue:getSize() == 1, "Should be able to enqueue after clear")
    assert(queue:peek() == "D", "Peek should return the new item after clear")

    return true
end

local function test_iterator()
    local queue = Queue.new()

    -- Add some items
    queue:enqueue("A")
    queue:enqueue("B")
    queue:enqueue("C")

    -- Verify iterator
    local items = {}
    for item in queue:iterator() do
        table.insert(items, item)
    end

    assert(#items == 3, "Iterator should yield 3 items")
    assert(items[1] == "A", "First item from iterator should be A")
    assert(items[2] == "B", "Second item from iterator should be B")
    assert(items[3] == "C", "Third item from iterator should be C")

    return true
end

-- Collect all tests
local tests = {
    ["Basic Operations"] = test_basic_operations,
    ["Circular Behavior"] = test_circular_behavior,
    ["Resize"] = test_resize,
    ["Clear"] = test_clear,
    ["Iterator"] = test_iterator
}

-- If this file is run directly, run the tests
if arg and arg[0]:match("queue_test.lua$") then
    test_utils.run_tests("Queue", tests)
end

-- Return the test suite for use by the test runner
return {
    module_name = "Queue",
    tests = tests
}
