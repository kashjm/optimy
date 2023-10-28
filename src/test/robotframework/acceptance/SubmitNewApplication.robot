*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BROWSER}    Chrome
${URL}  https://automationinterface1.front.staging.optimy.net/en/
${UploadFile}           css:[type='file']
*** Test Cases ***
Given I open the browser and navigate to the Optimy website
    [Documentation]    Given I opened the optimy website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

And I wait for and accept all cookies
    [Documentation]    Wait and click Accept Cookies
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#cookie-allow-all-button
    Click Element    css:#cookie-allow-all-button
When I click the "Login" button to go to the login page
    [Documentation]    Click Login button
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:body > div.page-wrapper.min-vh-100.d-flex.flex-column > header > div > div > a
    Click Element    css:body > div.page-wrapper.min-vh-100.d-flex.flex-column > header > div > div > a
And I enter my email address
    [Documentation]    Input e-mail address
    Sleep    2s
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#login-email
    Input Text    css:#login-email    optimyautomationtester@gmail.com
And I enter my password
    [Documentation]    Input password
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#login-password
    Input Password    css:#login-password    yRMhojb7
And I click the "Login" button
    Click Element    css:#login-form > div.position-relative > button
And I click the "Submit a new application" button
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > a
    Click Element    css:#content > div > div > div > div > a
Then if "Continue with the submission of the application" is present
    # Check if the first selector is visible, click it if true, else click the second selector
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > section > div > a
    Wait Until Page Contains Element    css:#content > div > div > div > div > section > div > a    timeout=30s
    ${first_selector}=    Set Variable    css:#content > div > div > div > div > section > ul > li:nth-child(1) > a
	${second_selector}=    Set Variable    css:#content > div > div > div > div > section > div > a
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${first_selector}
    Run Keyword If    ${element_present}    Click Element    ${first_selector}
    Run Keyword Unless    ${element_present}    Click Element    ${second_selector}
And I fill out the forms
    Sleep    2s
    [Documentation]Type First Name, Last Name, Address
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
    [Documentation]Select Country
    Select From List By Value    css:.locationCountry    US
	[Documentation]Select Photo
	${file_path}=    Set Variable    ${CURDIR}/app-form-photo.png
	Wait Until Page Contains Element   ${UploadFile}   60s
	[Documentation]Select file
	Choose File    ${UploadFile}    ${file_path}
	Sleep    5s
    [Documentation]Select Gender
	#Click Male Radio Button
	Click Element    css:[for='f3fa11a5-a516-5cec-9025-b940b1b113d0'] .custom-control-label
    [Documentation]Select Role
	Select From List by Value    css:#field_f801d7d8-0762-5407-95f9-b8c3a793157c    186e6ddf-1e72-552b-a25d-db41ae022f0b
    [Documentation]Tick Checkboxes
	${is_checked}=    Run Keyword And Return Status    Get Element Attribute    css:[for='773e5289-f4b3-5d6d-ac81-5c99e2b39acd'] .custom-control-label    checked
    Run Keyword Unless    ${is_checked}    Click Element    css:[for='773e5289-f4b3-5d6d-ac81-5c99e2b39acd'] .custom-control-label
	Click Element    css:[for='3fe36edc-80b0-5574-b7ad-7cfe074acfc1'] .custom-control-label
	Click Element    css:[for='5ab6a927-7b72-5869-acc3-0db0858bc495'] .custom-control-label
	Click Element    css:[for='36c255b7-8d7c-50b9-8e75-b2ae9a57185b'] .custom-control-label
	Click Element    css:[for='9bbcf3da-3757-5bf3-92cf-ac4694653f45'] .custom-control-label
    [Documentation]Fill out objectives
	Execute JavaScript    window.scrollBy(0,1000)
	Select Frame    css:[title='Editor, 91296806-02e6-5bb5-bac0-deb4cbf64a64::42b16795-740d-5d97-b972-a3643510eb01']
	Input Text    css:[role='textbox']    This is my objective
	Press Key    css:[role='textbox']   \\9
	Unselect Frame
And I click the "Next screen" button
	#Click Next
	#Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:[id='navButtonNext']
	Click Element    css:[id='navButtonNext']
Then I verify all the inputted values are displayed in the Summary screen
And I click the "Validate and send" button
	#Click Validate and Send
	Sleep    5s
	Execute JavaScript    window.scrollBy(0,1000)
	Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:[id='submitButton'][class='btn btn-primary ml-md-auto'][type='submit']
	Click Element    css:[id='submitButton'][class='btn btn-primary ml-md-auto'][type='submit']
Then I verify I am redirected to the "Thank you for submitting your project" page
	#Thank you page verification
	Wait Until Keyword Succeeds    10s    1s    Element Should Be Visible    css:#content > div > div > div > div > div > div.mb-4.text-center.text-success
	Close Browser