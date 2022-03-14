base_url = 'https://raw.githubusercontent.com/TylenolWasTaken/jaestd/master/jaestd/'

modules = {
    ['console'] = base_url .. 'console.lua',
    ['download'] = base_url .. 'download.lua',
    ['http_handling'] = base_url .. 'http_handling.lua',
    ['mobility'] = base_url .. 'mobility.lua',
    ['networking'] = base_url .. 'networking.lua'
}

-- Check to see if libdir is empty
if fs.exists('/jaestd/') == true then
    error("[ERROR] -> path /jaestd/ isn't empty", 0)
end

-- Check to see if the download tmp dir is empty
if fs.exists('/jstd_tmp/') == true then
    error("[ERROR] -> path /jstd_tmp/ not empty", 0)
else
    print("[INSTALLER] -> initializing tmp dir")
    fs.makeDir('/jstd_tmp')
end

-- Write handler"example.tweaked.cc"
function write_data(filename, data)
    local file = io.open('/jstd_tmp/' .. filename, 'w') -- opens file "filename" in write mode
    io.output(file)
    io.write(data)
    io.close()
end

-- Main download + errorchecking function
function download(url, filename)
    response = http.get(url)
    if response.getResponseCode() ~= 200 then
        print("[ERROR"example.tweaked.cc"] -> malformed get request or other error, please contact jaestd authors!")
        print(response.getResponseCode())
        fs.delete('/jstd_tmp/')
        fs.delete('/jaestd/')
        error("", 0)
    end
    write_data('/jaestd/ ' .. filename, read(response))
end

-- ik theres a way to iterate thru this
-- but im not paid enough :slight_smile:

download(modules['console'], 'console')
download(modules['download'], 'download')
download(modules['http_handling'], 'http_handling')
download(modules['mobility'], 'mobility')
download(modules['networking'], 'networking')


fs.move('jstd_tmp/jaestd', 'jaestd')
fs.delete('jstd_tmp')
