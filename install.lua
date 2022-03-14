base_url = 'https://raw.githubusercontent.com/TylenolWasTaken/jaestd/master/jaestd/'

modules = {
    [console] = base_url .. 'console.lua',
    [download] = base_url .. 'download.lua',
    [http_handling] = base_url .. 'http_handling.lua',
    [mobility] = base_url .. 'mobility.lua',
    [networking] = base_url .. 'networking.lua'
}

-- Check to see if libdir is empty
if fs.exists('/jaestd/') == true then
    error("[ERROR] -> path /jaestd/ isn't empty", 0)
else
    print("[INSTALLER] -> initializing library dir")
    fs.makeDir('/jaestd/')
end

-- Check to see if the download tmp dir is empty
if fs.exists('/jstd_tmp/') == true then
    error("[ERROR] -> path /jstd_tmp/ not empty", 0)
else
    print("[INSTALLER] -> initializing tmp dir")
    fs.makeDir('/jstd_tmp')
end

-- Write handler
function write_data(filename, data)
    io.open('/jstd_tmp/' .. filename) -- opens file "filename" in write mode
    io.write(data)
    io.close()
end

-- Main download + errorchecking function
function download(url, filename)
    response = http.get("example.tweaked.cc")
    if response.getResponseCode()['number'] ~= 200 then
        print("[ERROR] -> malformed get request or other error, please contact jaestd authors!")
        print(response.getResponseCode())
        fs.delete('/jstd_tmp/')
        error("", 0)
    end
    write_data('/jaestd/ ' .. filename, respose.readAll())
end

-- Test

download(modules['http_handling'], http_handling)