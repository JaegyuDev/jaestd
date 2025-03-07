local Heap = {}
Heap.__index = Heap

-- Create a new heap
-- @param comparator (optional) Function that compares two values, returns true if first has higher priority
-- @return A new heap instance
function Heap.new(comparator)
    local self = setmetatable({}, Heap)
    self.items = {}
    self.size = 0
    self.comparator = comparator or function(a, b) return a < b end
    return self
end

function Heap:_parent(index)
    return math.floor(index / 2)
end

function Heap:_leftChild(index)
    return 2 * index
end

function Heap:_rightChild(index)
    return 2 * index + 1
end

function Heap:_swap(i, j)
    self.items[i], self.items[j] = self.items[j], self.items[i]
end

function Heap:_siftUp(index)
    local parent = self:_parent(index)

    if index > 1 and self.comparator(self.items[index], self.items[parent]) then
        self:_swap(index, parent)
        self:_siftUp(parent)
    end
end

function Heap:_siftDown(index)
    local left = self:_leftChild(index)
    local right = self:_rightChild(index)
    local largest = index

    if left <= self.size and self.comparator(self.items[left], self.items[largest]) then
        largest = left
    end

    if right <= self.size and self.comparator(self.items[right], self.items[largest]) then
        largest = right
    end

    if largest ~= index then
        self:_swap(index, largest)
        self:_siftDown(largest)
    end
end

-- Insert a new item into the heap
-- @param item The item to insert
function Heap:push(item)
    self.size = self.size + 1
    self.items[self.size] = item
    self:_siftUp(self.size)
end

-- Remove and return the highest priority item
-- @return The highest priority item or nil if the heap is empty
function Heap:pop()
    if self.size == 0 then
        return nil
    end
    
    local topItem = self.items[1]
    self.items[1] = self.items[self.size]
    self.items[self.size] = nil
    self.size = self.size - 1
    
    if self.size > 0 then
        self:_siftDown(1)
    end
    
    return topItem
end

-- Peek at the highest priority item without removing it
-- @return The highest priority item or nil if the heap is empty
function Heap:peek()
    if self.size == 0 then
        return nil
    end
    return self.items[1]
end

-- Get the current size of the heap
-- @return The number of items in the heap
function Heap:getSize()
    return self.size
end

-- Check if the heap is empty
-- @return true if the heap is empty, false otherwise
function Heap:isEmpty()
    return self.size == 0
end

-- Clear all items from the heap
function Heap:clear()
    self.items = {}
    self.size = 0
end

return heap