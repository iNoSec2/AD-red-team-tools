/**
 * Validates user input in absentee app form and alerts user if there is something wrong with the form.
 * 
 * Author: Lyle Astillo
 */
  
 // Validates the form when user clicks the submit button.
 document.absentapp.addEventListener("submit", function(eventParam) {
    // Ensures that user selects a ballot type.
    let ballotValue = document.absentapp.ballot.value;
    if (ballotValue.length == 0) {
        alert("Please choose a ballot type.");
        eventParam.preventDefault();
        return;
    }
    // Ensures that user enters a valid SSN in the following format:
    // XXXXXXXX or XXX-XX-XXXX.
    let ssnValue = document.absentapp.ssn.value;
    let ssnRegex = /^\d{3}-?\d{2}-?\d{4}$/;
    if (ssnValue.length == 0 || !ssnRegex.test(ssnValue)) {
        alert("Invalid SSN: Please enter your social security number in the form 000-00-0000 or 000000000.");
        eventParam.preventDefault();
        return;
    }
    // Ensures that user selects a gender.
    let genderValue = document.absentapp.gender.value;
    if (genderValue.length == 0) {
        alert("Please choose a gender.");
        eventParam.preventDefault();
        return;
    }
    // Ensures that user enters a valid phone number the the following format:
    // XXX-XXXX.
    let phoneNumValue = document.absentapp.contactph.value;
    let phoneNumRegex = /^\d{3}-\d{4}$/;
    if (phoneNumValue.length == 0 || !phoneNumRegex.test(phoneNumValue)) {
        alert("Invalid phone number: Please enter a phone number in the form 000-0000.");
        eventParam.preventDefault();
        return;
    }
    // Ensures that user does not leave First and Last name, 
    // Address 1, City, Zipcode, Foward Name and Address fields empty.
    let lastNameValue = document.absentapp.lastname.value;
    if (lastNameValue.length == 0) {
        alert("Please enter your last name.");
        eventParam.preventDefault();
        return;
    }
    let firstNameValue = document.absentapp.firstname.value;
    if (firstNameValue.length == 0) {
        alert("Please enter your first name.");
        eventParam.preventDefault();
        return;
    }
    let address1Value = document.absentapp.address1.value;
    if (address1Value.length == 0) {
        alert("Address Line 1 field cannot be blank.");
        eventParam.preventDefault();
        return;
    }
    let cityValue = document.absentapp.city.value;
    if (cityValue.length == 0) {
        alert("Please enter your city.");
        eventParam.preventDefault();
        return;
    }
    // Ensures that user enters a valid Hawaii zipcode in the following format:
    // 967XX, 968XX, 967XX-XXXX, 968XX-XXXX
    let zipcodeValue = document.absentapp.zipcode.value;
    let zipcodeRegex = /^96[78]\d{2}(-\d{4})?$/;
    if (zipcodeValue.length == 0 || !zipcodeRegex.test(zipcodeValue)) {
        alert("Invalid ZIP code: Please enter a Hawaii ZIP code.");
        eventParam.preventDefault();
        return;
    }
    let forwardNameValue = document.absentapp.forwardName.value;
    if (forwardNameValue.length == 0) {
        alert("Name in forwarding address cannot be blank.");
        eventParam.preventDefault();
        return;
    }
    let forwardAddressValue = document.absentapp.forwardAddress.value;
    if (forwardAddressValue.length == 0) {
        alert("Forwarding address cannot be blank.");
        eventParam.preventDefault();
        return;
    }

    // Ensures Section IV checkbox is checked before submitting
    let affirmCheckboxElement = document.getElementById("affirm");
    if (affirmCheckboxElement.checked == false) {
        alert("Please check the affirmation in Section IV to submit your application.");
        eventParam.preventDefault();
        return;
    }
    // Informs user that form was properly filled out.
    alert("Thank You! Your application will be submitted.");
});

// Adding behavior to DOB select fields to do the following:
// If user is chooses January, March, May, July, August, October, December months, 
// day select field will have 31 days.
// If user is chooses April, June, September, November months, day select field will have 30 days.
// If user is chooses February, day select field will have 29 days.
// When choosing a month, its default selected date will be 1.
let monthElement = document.getElementById("month");
monthElement.addEventListener("change", function() {
    let newDayElement = document.getElementById("day");    
    if (monthElement.value == "2") {
        newDayElement.length = 0;
        for (let i = 1; i <= 29; i++) {
            let dayOption = document.createElement("OPTION");
            dayOption.value = i;
            dayOption.text = i;
            if (i == 1) {
                dayOption.selected = true;
            }
            newDayElement.add(dayOption);
          }  
    } else if (monthElement.value == "4" || monthElement.value == "6" || 
                monthElement.value == "9" || monthElement.value == "11") {
                    newDayElement.length = 0;
                    for (let i = 1; i <= 30; i++) {
                        let dayOption = document.createElement("OPTION");
                        dayOption.value = i;
                        dayOption.text = i;
                        if (i == 1) {
                            dayOption.selected = true;
                        }
                        newDayElement.add(dayOption);
                    }
                } else {
                    newDayElement.length = 0;
                    for (let i = 1; i <= 31; i++) {
                        let dayOption = document.createElement("OPTION");
                        dayOption.value = i;
                        dayOption.text = i;
                        if (i == 1) {
                            dayOption.selected = true;
                        }
                        newDayElement.add(dayOption);
                      }
                }
});

// Adding behavior to the checkbox in Section III of the form
// when checked will copy the information from the first and last name and address fields from Section II 
// into the respective fields in Section III.
let checkboxElement = document.getElementById("useResAddress");
checkboxElement.addEventListener("click", function() {
    let forwardNameElement = document.getElementById("forwardName");
    let forwardAddressElement = document.getElementById("forwardAddress");
    
    let lastnameVal = document.absentapp.lastname.value;
    let firstnameVal = document.absentapp.firstname.value;
    let address1Val = document.absentapp.address1.value;
    let address2Val = document.absentapp.address2.value;
    let cityVal = document.absentapp.city.value;
    let zipocdeVal = document.absentapp.zipcode.value;

    if (checkboxElement.checked == true) {
        forwardNameElement.value = firstnameVal + " " + lastnameVal;
        forwardAddressElement.value = address1Val + "\n" + cityVal + ", HI " + zipocdeVal;
    }
    if (checkboxElement.checked == true && address2Val.length > 0) {
        forwardNameElement.value = firstnameVal + " " + lastnameVal;
        forwardAddressElement.value = address1Val + "\n" + address2Val + "\n"
                                      + cityVal + ", HI " + zipocdeVal;
    }
});