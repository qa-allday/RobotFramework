*** Settings ***
Resource    resource.robot

*** Variables ***
${BROWSER}        Chrome
${HEADLESS}    headlesschrome
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
        Set Selenium Timeout    ${timeout}
        Set Selenium Speed    ${seleniumTimeout}
        Open Browser    ${WEB_URL}    ${HEADLESS}
    END
    Register Keyword To Run On Failure    Save Selenium Screenshot

End Web Test
    Close Browser

Save Selenium Screenshot
    ${screenshot_index}=    Get Variable Value    ${screenshot_index}    ${0}
    Set Global Variable    ${screenshot_index}    ${screenshot_index.__add__(1)}
    ${time}=    Evaluate    str(time.time())    time
    Capture Page Screenshot    selenium-screenshot-${time}-${screenshot_index}.png