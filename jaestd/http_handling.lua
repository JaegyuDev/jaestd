response_error = {
    [400] = error("HTTP 400: Bad request; malformed syntax"),
    [401] = error("HTTP 401: Unauthorized; requires permission"),
    [402] = error("HTTP 402: should never get this, idk what you did"),
    [403] = error("HTTP 403: Forbidden; [server] understands but doesn't want to fulfill"),
    [404] = error("HTTP 404: Not Found; [server] can't find the page")

}



http_handling = {}

function http_handling.checkResponse(response)
    if response ~= 200 then
        local func = c_tbl[choice]
        if(func) then
            func()
        else
            print("something happened, not sure what though")
        end
    end
end

return http_handling
