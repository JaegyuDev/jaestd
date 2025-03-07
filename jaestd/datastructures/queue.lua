local Queue = {}
Queue.__index = Queue

-- Create a new Queue
-- @param capacity (optional) Initial capacity of the queue
-- @return A new queue instance
function Queue.new(capacity)
    local self = setmetatable({}, Queue)
    self.capacity = capacity or 10
    self.items = {}
    self.size = 0

    self.head = 1
    self.tail = 1
    return self
end

function Queue:_resize()
    local newCapacity = self.capacity * 2
    local newItems = {}

    for i = 1, self.size do
        local index = (self.head + i - 2) % self.capacity + 1
        newItems[i] = self.items[index]
    end

    self.items = newItems
    self.head = 1
    self.tail = self.size + 1
    self.capacity = newCapacity
end

-- Add an item to the end of the queue
-- @param item The item to enqueue
function Queue:enqueue(item)
    if self.size == self.capacity then
        self:_resize()
    end

    self.items[self.tail] = item
    self.tail = (self.tail % self.capacity) + 1
    self.size = self.size + 1
end

-- Remove and return the item at the start of the queue
-- @return The first item, or nil if the queue is empty
function Queue:dequeue()
    if self.size == 0 then
        return nil
    end

    local item = self.items[self.head]
    self.items[self.head] = nil
    self.head = (self.head % self.capacity) + 1
    self.size = self.size - 1
    return item
end

-- Peek at the item at the front of the queue without removing it
-- @return The front item, or nil if queue is empty
function Queue:peek()
    if self.size == 0 then
        return nil
    end
    return self.items[self.head]
end

-- Check if the queue is empty
-- @return true if the queue is empty, false otherwise
function Queue:isEmpty()
    return self.size == 0
end

-- Get the current size of the queue
-- @return The number of items in the queue
function Queue:getSize()
    return self.size
end

-- Get the current capacity of the queue
-- @return The capacity of the queue
function Queue:getCapacity()
    return self.capacity
end

-- Clear all items from the queue
function Queue:clear()
    self.items = {}
    self.head = 1
    self.tail = 1
    self.size = 0
end

-- Iterator for the queue elements (from head to tail)
function Queue:iterator()
    local i = 0
    local n = self.size

    return function()
        if i < n then
            i = i + 1
            local index = (self.head + i - 2) % self.capacity + 1
            return self.items[index]
        end
    end
end

return Queue
