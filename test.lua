function download_get(filename, url)
    local file = http.get(url)
    if file[0] == nil then
        for i in file do
            print(i)
        end
        error("file url issue ig kys faggot", 0)
    end

    open(filename)
    write(file)
    close(filename)
end

function download_run(filename, url)
    download_get(filename, url)
    if lines(filename)[0] == '--success' then
        os.run(filename)
    else
        error("error, corrupted or tampered file", 403)
    end 
end