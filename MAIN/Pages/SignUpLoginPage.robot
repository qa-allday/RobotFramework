*** Settings ***
Resource    resource.robot

*** Variables ***
### Initial page elements
${login_email_input}=    css:input[data-qa='login-email']
${login_password_input}=    css:input[data-qa='login-password']
${login_btn}=    css:button[data-qa='login-button']
${signup_name_input}=    css:input[data-qa='signup-name']
${signup_email_input}=    css:input[data-qa='signup-email']
${signup_btn}=    css:button[data-qa='signup-button']
### Signup Step#2 page elements
${signup2_name_input}=    css:input[data-qa='name']
${signup2_email_input}=    css:input[data-qa='email']
${signup2_password_input}=    css:#password

${signup2_firstname_input}=    css:#first_name
${signup2_lastname_input}=    css:#last_name
${signup2_address1_input}=    css:#address1
${signup2_country_dropdown}=    css:#country
${signup2_state_input}=    css:#state
${signup2_city_input}=    css:#city
${signup2_zipcode_input}=    css:#zipcode
${signup2_mobilenumber_input}=    css:#mobile_number
${signup2_create_account_btn}=    css:button[data-qa='create-account']

### Signup Final page elements
${signup2_continue_btn}=    css:a[data-qa='continue-button']

### MESSAGES
${account_created_title}=    //h2/*[contains(text(),'Account Created')]
${account_deleted_title}=    //h2/*[contains(text(),'Account Deleted')]

*** Keywords ***
Login To Application
    [Arguments]    ${email}    ${password}
    Input Text Surely    ${login_email_input}    ${email}
    Input Text Surely    ${login_password_input}    ${password}
    Wait For And Click Element    ${login_btn}
    
Register New User
    [Arguments]    ${name}    ${email}
    Input Text Surely    ${signup_name_input}    ${name}
    Input Text Surely    ${signup_email_input}    ${email}
    Wait For And Click Element    ${signup_btn}

Start Registration
    [Arguments]    ${user}
    Input Text Surely    ${signup_name_input}    ${user}[name]
    Input Text Surely    ${signup_email_input}    ${user}[email]
    Wait For And Click Element    ${signup_btn}
    
Fill In Registration Form
    [Arguments]    ${user}
    Input Text Surely    ${signup2_password_input}    ${user}[password]
    Input Text Surely    ${signup2_firstname_input}    ${user}[firstName]
    Input Text Surely    ${signup2_lastname_input}    ${user}[lastName]
    Input Text Surely    ${signup2_address1_input}    ${user}[address1]
    Select From List By Value    ${signup2_country_dropdown}    ${user}[country]
    Input Text Surely    ${signup2_state_input}    ${user}[state]
    Input Text Surely    ${signup2_city_input}    ${user}[city]
    Input Text Surely    ${signup2_zipcode_input}    ${user}[zipcode]
    Input Text Surely    ${signup2_mobilenumber_input}    ${user}[mobile]