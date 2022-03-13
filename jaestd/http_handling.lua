response_error = {
    [400] = error("HTTP 400: Bad request; malformed syntax"),
    [401] = error("HTTP 401: Unathorized; requires permission"),
    [402] = error("HTTP 402: should never get this, idk what you did"),
    [403] = error("HTTP 403: Forbidden; [server] understands but doesn't want to fulfill"),
    [404] = error("HTTP 404: Not Found; [server] can't find the page")

}



http_handling = {}



function check_response(response)
    if response != 200 then
        if response == 400 then
            
        elseif response == 401 then

        elseif response == 402 then
            
        elseif response == 403 then
            error("")
        elseif response == 404 then
            
        elseif response == 405 then
            error("HTTP 405: ")

return http_handling
