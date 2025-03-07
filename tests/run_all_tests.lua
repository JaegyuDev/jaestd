local test_utils = require("tests.test_utils")

local test_modules = {
    require("tests.datastructures.queue_test"),
    require("tests.datastructures.heap_test")
}

local function run_all_tests()
    local total_passed = 0
    local total_failed = 0
    local max_format_length = 0

    for _, module in ipairs(test_modules) do
        for name, _ in pairs(module.tests) do
            if #name > max_format_length then
                max_format_length = #name
            end
        end
    end

    max_format_length = max_format_length + 2

    print("==================================================")
    print("RUNNING ALL TESTS")
    print("==================================================")

    for _, module in ipairs(test_modules) do
        local _, results = test_utils.run_tests(module.module_name, module.tests, max_format_length)
        total_passed = total_passed + results.passed
        total_failed = total_failed + results.failed
        print("--------------------------------------------------")
    end

    print("==================================================")
    print(string.format("ALL TESTS COMPLETED: %d passed, %d failed", total_passed, total_failed))
    print("==================================================")

    return total_failed == 0
end

return run_all_tests()
