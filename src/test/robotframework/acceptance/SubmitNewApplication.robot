*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BROWSER}    Chrome
${URL}  https://automationinterface1.front.staging.optimy.net/en/
${UploadFile}           css:[type='file']
*** Test Cases ***
Open Application
    [Documentation]    Open the application using the specified browser
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Wait and click Accept Cookies
    [Documentation]    Wait and click Accept Cookies
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#cookie-allow-all-button
    Click Element    css:#cookie-allow-all-button
Click Login button
    [Documentation]    Click Login button
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:body > div.page-wrapper.min-vh-100.d-flex.flex-column > header > div > div > a
    Click Element    css:body > div.page-wrapper.min-vh-100.d-flex.flex-column > header > div > div > a
Input e-mail address
    [Documentation]    Input e-mail address
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#login-email
    Input Text    css:#login-email    optimyautomationtester@gmail.com
Input password
    [Documentation]    Input password
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#login-password
    Input Password    css:#login-password    yRMhojb7
    Click Element    css:#login-form > div.position-relative > button
Click Submit a new application
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > a
    Click Element    css:#content > div > div > div > div > a
Check if Continue with the submission of the application is present else click Submit a New Application
    # Check if the first selector is visible, click it if true, else click the second selector
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > section > div > a
    Wait Until Page Contains Element    css:#content > div > div > div > div > section > div > a    timeout=30s
    ${first_selector}=    Set Variable    css:#content > div > div > div > div > section > ul > li:nth-child(1) > a
	${second_selector}=    Set Variable    css:#content > div > div > div > div > section > div > a
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${first_selector}
    Run Keyword If    ${element_present}    Click Element    ${first_selector}
    Run Keyword Unless    ${element_present}    Click Element    ${second_selector}
Fill out the form
    Sleep    2s
	${first_name}=    Get Text    css:[aria-label='First name']
	${last_name}=    Get Text    css:[aria-label='Last name']
	${unithousestreet}=    Get Text    css:[aria-label='Unit no/House no, Street']
	${postalcode}=    Get Text    css:.ui-autocomplete-input
	Run Keyword Unless    '${first_name}'    Input Text    css:[aria-label='First name']    first_name
	Run Keyword Unless    '${last_name}'    Input Text    css:[aria-label='Last name']    last_name
	Run Keyword Unless    '${unithousestreet}'    Input Text    css:[aria-label='Unit no/House no, Street']    unithousestreet
	Run Keyword Unless    '${postalcode}'    Input Text    css:.ui-autocomplete-input    1000
	# - Bruxelles / Brussel
	 Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:.ui-corner-all[tabindex='-1']
	Click Element    css:.ui-corner-all[tabindex='-1']
Select Country
    #Country css:.locationCountry
    Select From List By Value    css:.locationCountry    US
Select Photo
	#Photo
	${file_path}=    Set Variable    ${CURDIR}/app-form-photo.png
	Wait Until Page Contains Element   ${UploadFile}   60s
	#Select file
	Choose File    ${UploadFile}    ${file_path}
	Sleep    5s
Select Gender
	#Click Male Radio Button
	Click Element    css:[for='f3fa11a5-a516-5cec-9025-b940b1b113d0'] .custom-control-label
Select Role
	#Select Manual tester from Role dropdown
	Select From List by Value    css:#field_f801d7d8-0762-5407-95f9-b8c3a793157c    186e6ddf-1e72-552b-a25d-db41ae022f0b
Tick Checkbox
	#Tick Checkbox
	${is_checked}=    Run Keyword And Return Status    Get Element Attribute    css:[for='773e5289-f4b3-5d6d-ac81-5c99e2b39acd'] .custom-control-label    checked
    Run Keyword Unless    ${is_checked}    Click Element    css:[for='773e5289-f4b3-5d6d-ac81-5c99e2b39acd'] .custom-control-label
	#Click Element    css:[for='773e5289-f4b3-5d6d-ac81-5c99e2b39acd'] .custom-control-label
	Click Element    css:[for='3fe36edc-80b0-5574-b7ad-7cfe074acfc1'] .custom-control-label
	Click Element    css:[for='5ab6a927-7b72-5869-acc3-0db0858bc495'] .custom-control-label
	Click Element    css:[for='36c255b7-8d7c-50b9-8e75-b2ae9a57185b'] .custom-control-label
	Click Element    css:[for='9bbcf3da-3757-5bf3-92cf-ac4694653f45'] .custom-control-label
Fill out objectives
	Execute JavaScript    window.scrollBy(0,1000)
	Select Frame    css:[title='Editor, 91296806-02e6-5bb5-bac0-deb4cbf64a64::42b16795-740d-5d97-b972-a3643510eb01']
	Input Text    css:[role='textbox']    This is my objective
	Press Key    css:[role='textbox']   \\9
	Unselect Frame
Click Next
	#Click Next
	#Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:[id='navButtonNext']
	Click Element    css:[id='navButtonNext']
Validate and Send
	#Click Validate and Send
	Sleep    5s
	Execute JavaScript    window.scrollBy(0,1000)
	Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:[id='submitButton'][class='btn btn-primary ml-md-auto'][type='submit']
	Click Element    css:[id='submitButton'][class='btn btn-primary ml-md-auto'][type='submit']
Thank you page
	#Thank you page verification
	Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > div > div.mb-4.text-center.text-success
	Close Browser