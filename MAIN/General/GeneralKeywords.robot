*** Settings ***
Resource    resource.robot

*** Variables ***
${BROWSER}        Chrome
${timeout}    20s
${seleniumTimeout}    0.1s
${sleep_Timeout}    20s

*** Keywords ***
Begin Web Test
    IF    '${METHOD}' == '${EMPTY}'
        Set Selenium Timeout    ${timeout}
        Set Selenium Speed    ${seleniumTimeout}
        Open Browser    ${WEB_URL}    ${BROWSER}
        Maximize Browser Window
    ELSE
        ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
        ${headless_arg}=    Set Variable    headless=new
        ${winsize}=    Set Variable    window-size=1920,1080
        ${proxy-list}=    Set Variable    proxy-bypass-list=*
        ${proxy-server}=    Set Variable    proxy-server='direct://'
        Call Method  ${chrome_options}  add_argument  --${winsize}
        Call Method  ${chrome_options}  add_argument  --${headless_arg}
        Call Method  ${chrome_options}  add_argument  --ignore-certificate-errors
        Call Method  ${chrome_options}  add_argument  --disable-gpu
        Call Method  ${chrome_options}  add_argument  --allow-running-insecure-content
        Call Method  ${chrome_options}  add_argument  --start-maximized
        Call Method  ${chrome_options}  add_argument  --${proxy-list}
        Call Method  ${chrome_options}  add_argument  --disable-dev-shm-usage
        Call Method  ${chrome_options}  add_argument  --no-sandbox
        Call Method  ${chrome_options}  add_argument  --disable-extensions
        Call Method  ${chrome_options}  add_argument  --${proxy-server}
        Create Webdriver  Chrome  options=${chrome_options}
        Set Selenium Timeout    ${timeout}
        Set Selenium Speed    ${seleniumTimeout}
        Go To    ${WEB_URL}
    END
    Register Keyword To Run On Failure    Save Selenium Screenshot

End Web Test
    Close Browser

Save Selenium Screenshot
    ${screenshot_index}=    Get Variable Value    ${screenshot_index}    ${0}
    Set Global Variable    ${screenshot_index}    ${screenshot_index.__add__(1)}
    ${time}=    Evaluate    str(time.time())    time
    Capture Page Screenshot    selenium-screenshot-${time}-${screenshot_index}.png