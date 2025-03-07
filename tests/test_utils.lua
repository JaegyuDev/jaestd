local test_utils = {}

-- Pads a string to a certain length with an optional character
-- @param _string String that will be padded
-- @param length Length to pad the given string to
-- @param character (optional) Character to use to pad, space is used by default
-- @return padded string or given string if #string >= length
function test_utils.rpad_string(_string, length, character)
    character = character or " "
    if #_string >= length then
        return _string
    end

    return _string .. string.rep(character, length - #_string)
end

-- Runs a collection of tests with formatted output
-- @param module_name Name of the module being tested
-- @param tests Table of test functions {["test name"] = test_function, ...}
-- @param pad_length (optional) Length to pad test names to for consistent formatting
-- @return true if all tests pass, false otherwise
function test_utils.run_tests(module_name, tests, pad_length)
    local passed = 0
    local failed = 0

    -- Find the longest test name if pad_length not provided
    local format_length = pad_length or 0
    if not pad_length then
        for name, _ in pairs(tests) do
            if #name > format_length then
                format_length = #name
            end
        end
    end

    print("Running " .. module_name .. " tests...")

    local test_names = {}
    for name, _ in pairs(tests) do
        table.insert(test_names, name)
    end
    table.sort(test_names)

    for _, name in ipairs(test_names) do
        local test_func = tests[name]
        local success, result = pcall(test_func)
        if success and result then
            print("  " .. test_utils.rpad_string(name, format_length) .. " PASSED")
            passed = passed + 1
        else
            print("  " .. test_utils.rpad_string(name, format_length) .. " ✗ FAILED")
            if not success then
                print("    Error: " .. result)
            end
            failed = failed + 1
        end
    end

    print(string.format("%s tests completed: %d passed, %d failed", module_name, passed, failed))
    return failed == 0, { passed = passed, failed = failed, format_length = format_length }
end

return test_utils
