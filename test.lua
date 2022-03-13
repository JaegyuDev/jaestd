function download_get(filename, url)
    local file = http.get(url)
    open(filename)
    write(file)
    close(filename)
end

function download_run(filename, url)
    download_get(filename, url)
    if lines(filename)[0] == '--success'
        os.run(filename)
    else
        error("error, corrupted or tampered file", 403)
    end 
end