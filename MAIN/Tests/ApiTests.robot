*** Settings ***
Resource    resource.robot
Test Teardown    Clear API Responses Directory

*** Test Cases ***
Get All Products List
    [Tags]    Critical
    ${res}    ${json}=    API - Get Products
    Should Be Equal As Integers    ${json['responseCode']}    200
    ${test_file}=    Save JSON To File    ${res.text}
    Compare Two JSON Files    products_sample.json    ${test_file}

Get User Account Details By Email
    [Tags]    Critical
    ${res}    ${json}=    API - Get User Details By Email    ${login_tester}
    Should Be Equal As Integers    ${json['responseCode']}    200
    Verify Dictionary Is Not Empty    ${json['user']}

Verify Login with invalid details
    [Tags]    High
    ${res}    ${json}=    API - Login    wron@wrong.com    ${password}
    Should Be Equal As Integers    ${json['responseCode']}    404
    Should Be Equal    ${json['message']}    User not found!

Create/Register User Account
    [Tags]    Critical
    ${user}=    Generate New User API Data
    ${res}    ${json}=    API - Create User Account    ${user}
    Should Be Equal As Integers    ${json['responseCode']}    201
    Should Be Equal    ${json['message']}     User created!