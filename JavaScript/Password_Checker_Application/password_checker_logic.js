/**
 * This file adds behavior to the password input box element
 * and checkbox element using the addEventListener method.
 * 
 * A regex is used to determine if the user's password contains 6 characters
 * with lower and uppercase letters, numbers, and special characters.
 * 
 * The keyup event triggers as the user is entering their password
 * so they know they are meeting the password criteria.
 * 
 * The checkbox uses the event click that if triggered will change
 * the type of the password element to text which unmasks what was entered
 * for readability.
 *
 * @author Lyle Astillo
 */

// Get the elements to add events to them.
let passwordElement = document.getElementById("password");
let checkboxElement = document.getElementById("checkbox");

// As the user is typing in their password, the value will be evaluated
// and feedback is displayed in feedback paragraph element.
passwordElement.addEventListener("keyup", function() {
    
    // User input is stored, getting feedback element
    // and initialzing a value to that element.
    let userInput = passwordElement.value;
    let feedbackElement = document.getElementById("feedback");
    let feedback = "";   
    
    // Regex patterns to identify if password contains 6 characters,
    // upper and lowercase letters, special characters, and numbers.
    let passRegex1 = /[a-z]+/;
    let passRegex2 = /[A-Z]+/;
    let passRegex3 = /[!@#\$%\^&\*]+/;
    let passRegex4 = /\d+/;

    // Tell user to add a lowercase letter to their password.
    if (!passRegex1.test(userInput)) {
        feedback += "Does not contain lower letter<br>";
    }
    // Tell user to add an uppercase letter to their password.
    if (!passRegex2.test(userInput)) {
        feedback += "Does not contain uppercase letter<br>";
    }
    // Tell user to add a special character to their password.  
    if (!passRegex3.test(userInput)) {
        feedback += "Does not contain a special character<br>";
    }
    // Tell user to add a number to their password.
    if (!passRegex4.test(userInput)) {
        feedback += "Does not contain a number<br>";
    }
    // Tell user to increase the length of their password.
    if (userInput.length <= 6) {
        feedback += "Password is too short<br>";
    }
    // Tell user their password is strong if they meet the criteria above.
    if (passRegex1.test(userInput) && passRegex2.test(userInput) 
        && passRegex3.test(userInput) && passRegex4.test(userInput) 
        && userInput.length > 6) {
        feedback = "That is considered a strong password"
    }
    // Assign feedback an empty string if user did not enter anything.
    if (userInput.length == 0) {
        feedback = "";
    }
    // Display feedback to webpage.
    feedbackElement.innerHTML = feedback;
});

// Unmasks the password entry if user checks the checkbox
// and mask it if checkbox is unchecked.
checkboxElement.addEventListener("click", function() {
    if (checkboxElement.checked == true) {
        passwordElement.type = "text";
    } else {
        passwordElement.type = "password";
    }
});