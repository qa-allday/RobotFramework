*** Settings ***
Resource    ../resource.robot

*** Keywords ***
Disable SSL Warnings
    Evaluate    __import__('urllib3').disable_warnings(__import__('urllib3').exceptions.InsecureRequestWarning)

Send API Request
    [Arguments]    ${method}    ${endpoint}    ${params}=${EMPTY}    ${data}=${EMPTY}    ${json}=${EMPTY}    ${headers}=${EMPTY}
    Disable SSL Warnings
    Create Session    mysession    ${API_URL}
    IF    '${method}' == 'GET'
        ${response}=    GET On Session    mysession    ${endpoint}    params=${params}    headers=${headers}
    ELSE IF    '${method}' == 'POST'
        ${response}=    POST On Session    mysession    ${endpoint}    params=${params}    data=${data}    json=${json}    headers=${headers}
    ELSE IF    '${method}' == 'PUT'
        ${response}=    PUT On Session    mysession    ${endpoint}    data=${data}    json=${json}    headers=${headers}
    ELSE IF    '${method}' == 'DELETE'
        ${response}=    DELETE On Session    mysession    ${endpoint}    params=${params}    headers=${headers}
    ELSE
        Fail    Unsupported HTTP method: ${method}
    END
    RETURN    ${response}
    
Save JSON To File
    [Arguments]    ${json}
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d_%H-%M-%S
    Create Directory    ${CURDIR}/api_responses
    Create File    ${CURDIR}/api_responses/response_${timestamp}.json    ${json}
    RETURN    ${CURDIR}/api_responses/response_${timestamp}.json

Clear API Responses Directory
    Empty Directory    ${CURDIR}/api_responses
    
Compare Two JSON Files
    [Arguments]    ${sample}    ${testfile}
    ${json1}=    Load JSON From File    ${CURDIR}/api_samples/${sample}
    ${json2}=    Load JSON From File    ${testfile}
    Should Be Equal    ${json1}    ${json2}

API - Get Products
    ${response}=    Send API Request    method=GET    endpoint=productsList
    ${json}=    Convert string to JSON    ${response.text}
    RETURN    ${response}    ${json}

API - Get Brands
    ${response}=    Send API Request    method=GET    endpoint=brandsList
    ${json}=    Convert string to JSON    ${response.text}
    RETURN    ${response}    ${json}

API - Get User Details By Email
    [Arguments]    ${email}
    ${params}=    Create Dictionary    email=${email}
    ${response}=    Send API Request    method=GET    endpoint=getUserDetailByEmail    params=${params}
    ${json}=    Convert string to JSON    ${response.text}
    RETURN    ${response}    ${json}

API - Login
    [Arguments]    ${email}    ${password}
    ${data}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    Send API Request    method=POST    endpoint=verifyLogin    data=${data}
    ${json}=    Convert string to JSON    ${response.text}
    RETURN    ${response}    ${json}

API - Create User Account
    [Arguments]    ${user}
    ${response}=    Send API Request    method=POST    endpoint=createAccount    data=${user}
    ${json}=    Convert string to JSON    ${response.text}
    RETURN    ${response}    ${json}