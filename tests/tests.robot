*** Settings ***
Library    RequestsLibrary
Library    BuiltIn

*** Variables ***
${color_yellow}     \x1b[33m
${color_reset}      \x1b[0m
${user_mail}        newuser2@example.com
${user_password}    securepassword123

*** Test Cases ***
Users Register
    Create Session    api    http://localhost:8080    verify=False
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${user_mail}    password=${user_password}

    ${response}=    POST On Session    api    /users/register    headers=${headers}    json=${payload}
    ${json}=    Evaluate    json.loads('''${response.content}''')    json
    Should Be Equal As Strings    ${json["success"]}    True
    
    Log To Console    . 
    Log To Console    Success: ${color_yellow}${json["success"]}${color_reset}
    Log To Console    Message: ${color_yellow}${json["message"]}${color_reset}

Users Login
    Create Session    api    http://localhost:8080    verify=False
    ${headers}=    Create Dictionary    Accept=application/json
    ${payload}=    Create Dictionary    email=${user_mail}    password=${user_password}

    ${response}=    POST On Session    api    /users/login    headers=${headers}    json=${payload}
    ${json}=    Evaluate    json.loads('''${response.content}''')    json
    
    ${token}=    Set Variable    ${json["token"]}
    Set Suite Variable    ${token}
    Should Be Equal As Strings    ${json["success"]}    True
    Log To Console    .
    Log To Console    .
    Log To Console    Success: ${color_yellow}${json["success"]}${color_reset}
    Log To Console    Message: ${color_yellow}${json["message"]}${color_reset}

Purchase History
    ${headers}=    Create Dictionary    Accept=application/json    Authorization=Bearer ${token}

    ${response}=    GET On Session    api    url=/purchase-history    headers=${headers}
    ${json}=    Evaluate    json.loads('''${response.content}''')    json
    Should Be Equal As Strings    ${json["success"]}    True

    Log To Console    .
    Log To Console    Success: ${color_yellow}${json["success"]}${color_reset}
    Log To Console    Data: ${color_yellow}${json["data"]}${color_reset}



Products
    Create Session    api    http://localhost:8080    verify=False
    ${headers}=    Create Dictionary    Accept=application/json

    ${response}=    GET On Session    api    url=/products?page=1&limit=1000    headers=${headers}
    ${json}=    Evaluate    json.loads('''${response.content}''')    json
    Should Be Equal As Strings    ${json["success"]}    True

    Log To Console    . 
    Log To Console    Success: ${color_yellow}${json["success"]}${color_reset}
    Log To Console    Data: ${color_yellow}${json["data"][0]}${color_reset}

