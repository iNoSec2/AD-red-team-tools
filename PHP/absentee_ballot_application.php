<!doctype html>
<html>
<head>
<title>Hawaii Absentee Application</title>
<!--   Modified version of HI Absentee Ballot Application   -->
<!--                 Modified by: Lyle Astillo              -->

<!--   For invalid user inputs   -->
<style>
  .error {
    color: #A00;
    font-weight: bold;
  }
</style>
</head>
<body>
<div id="container">
<header>
<h1>Hawaii Absentee Ballot Application</h1>
<h2>(Archived, not for official use)</h2>
</header>
<form name="absentapp" method="post">

<strong>Section I.</strong> I hereby request Absentee Ballots for the following Election(s):<br>
<input type="radio" name="ballot" value="PrimaryOnly"
<?php /* Make PrimaryOnly radio button sticky */ if (isset($_POST['submit']) && $_POST['ballot'] == "PrimaryOnly") echo "checked";?>> Primary Only
<input type="radio" name="ballot" value="GeneralOnly"
<?php /* Make GeneralOnly radio button sticky */ if (isset($_POST['submit']) && $_POST['ballot'] == "GeneralOnly") echo "checked";?>> General Only
<input type="radio" name="ballot" value="PandG"
<?php /* Make PandG radio button sticky */ if (isset($_POST['submit']) && $_POST['ballot'] == "PandG") echo "checked";?>> Primary &amp; General
<input type="radio" name="ballot" value="Special"
<?php /* Make Special radio button sticky */ if (isset($_POST['submit']) && $_POST['ballot'] == "Special") echo "checked";?>> Special Elections
<br>

<br>
<strong>Section II. </strong>Failure to complete certain items will prevent acceptance of this application.<br>
<label for="ssn" <?php // Highlights 1. Social Security Number*: red if the user entered invalid ssn format. 
if (isset($_POST['submit']) && !preg_match('/^\d{3}(-?)\d{2}\1\d{4}$/', $_POST['ssn'])) 
echo 'class="error"';?>>1. Social Security Number*:</label>
<input type="text" name="ssn" id="ssn" value="<?php /* Make ssn value sticky */ if (isset($_POST['submit'])) echo $_POST['ssn'];?>">
<?php // In-line error message if the user entered entered ssn format.
if (isset($_POST['submit']) && !preg_match('/^\d{3}(-?)\d{2}\1\d{4}$/', $_POST['ssn'])) 
echo '<span class="error">Format must be: 000-00-0000 or 000000000</span>';?><br>

2. Date of Birth:
<!-- Each month option is added via JavaScript below. -->
<select id="month" name="month"></select>
<script type="text/javascript">
  /*
   * Populates the month drop-down menu from January to December.
   * Each option in the drop-down menu has values from 1 to 12.
   */
  let months = ["January", "February", "March", "April", "May", "June", "July",
                "August", "September", "October", "November", "December"];
  let monthInitialElement = document.getElementById("month");

  // Create an OPTION for each month and add it to the month select field.
  // <option value="1">January</option>
  // <option value="2">February</option>
  // etc.
  for (let i = 0; i < months.length; i++) {
    let tempMonth = document.createElement("OPTION");
    tempMonth.value = i + 1;
    tempMonth.text = months[i];

    monthInitialElement.add(tempMonth);
  }
</script>
<!-- Each day option is added via JavaScript below. -->
<select id="day" name="day"></select>
<script type="text/javascript">
  /*
   * Populates the day select field from 1 to 31.
   * January is the first month to be loaded, therefore 31 days.
   */
  let dayInitialElement = document.getElementById("day");
  // Create 31 OPTION for each day of January and add it to the days select field.
  for (let i = 1; i <= 31; i++) {
    let tempDay = document.createElement("OPTION");
    tempDay.value = i;
    tempDay.text = i;

    dayInitialElement.add(tempDay);
  }
</script>
  <!-- Each year option is added via JavaScript below. -->
<select id="year" name="year"></select>
<script type="text/javascript">
  /*
   * Populates the year drop-down from the (current year - 17) down to (current year - 122).
   * Current year - 17: The earliest someone can vote
   * Current year - 122: The longest a person has lived was 122 years old.
   * The years are in descending order, newest year to oldest year.
   */
  let yearElement = document.getElementById("year");
  let currentYear = new Date().getFullYear();
  for (let i = (currentYear - 17); i >= (currentYear - 122); i--) {
    let tempYear = document.createElement("OPTION");
    tempYear.value = i;
    tempYear.text = i;

    yearElement.add(tempYear);
  }
</script><br>

3. Gender:
<input type="radio" id="genderMale" name="gender" value="male"
<?php /* Make male radio button sticky */ if (isset($_POST['submit']) && $_POST['gender'] == "male") echo "checked";?>> Male
<input type="radio" id="genderFemale" name="gender" value="female"
<?php /* Make female radio button sticky */ if (isset($_POST['submit']) && $_POST['gender'] == "female") echo "checked";?>> Female
<br>

<label for="contactph" <?php // Highlights 4 Contact Phone: red if the user entered invalid phone number format. 
if (isset($_POST['submit']) && !preg_match('/^\d{3}-\d{4}$/', $_POST['contactph'])) echo 'class="error"';?>>
4. Contact Phone:</label> <input type="text" id="contactph" name="contactph" value="
<?php /* Make contactph value sticky */ if (isset($_POST['submit'])) echo $_POST['contactph'];?>"> 
<?php // In-line error message if the user entered phone number in an incorrect format.
if (isset($_POST['submit']) && !preg_match('/^\d{3}-\d{4}$/', $_POST['contactph'])) 
echo '<span class="error">Format must be: 000-0000</span>';?><br>
<label for="name">5. Name: </label> 
<input type="text" name="name" id="name" value="
<?php /* Make name value sticky */ if (isset($_POST['submit'])) echo $_POST['name'];?>"> <br>

6. Residence Address In Hawaii Street: <br>
Address Line 1: <input type="text" id="address1" name="address1" value="
<?php /* Make address1 value sticky */ if (isset($_POST['submit'])) echo $_POST['address1'];?>"> <br>
Address Line 2: <input type="text" id="address2" name="address2" value="
<?php /* Make address2 value sticky */ if (isset($_POST['submit'])) echo $_POST['address2'];?>"> <br>
City: <input type="text" id="city" name="city" value="
<?php /* Make address1 city sticky */ if (isset($_POST['submit'])) echo $_POST['city'];?>"> <br>
ZIP Code: <input type="text" id="zipcode" name="zipcode" value="
<?php /* Make zipcode value sticky */ if (isset($_POST['submit'])) echo $_POST['zipcode'];?>"> <br>

<br>
<strong>Section III.</strong> Please mail my ballots to: <br>

Use same as Residence Address: <input type="checkbox" id="useResAddress" name="useResAddress"
<?php /* Make checkbox sticky */ if (isset($_POST['useResAddress'])) echo "checked"; ?>> <br>

7. Name: <input type="text" id="forwardName" name="forwardName" value="
<?php /* Make forwardName value sticky */ if (isset($_POST['submit'])) echo $_POST['forwardName'];?>"> <br>

8. Forwarding Address: <textarea rows="3" cols="30" id="forwardAddress" name="forwardAddress">
<?php /* Make forwardAddress value sticky */ if (isset($_POST['submit'])) echo $_POST['forwardAddress'];?></textarea>

<br>
<br>

<label for="affirm" 
<?php // Highlights affirm message red if checkbox is not checked before submitting 
if (isset($_POST['submit']) && !isset($_POST['affirm'])) echo 'class="error"'; ?>>
<strong>Section IV.</strong> I hereby affirm that: 1) I am the person named above; 2) I am requesting an absentee ballot for myself and no other; and 3) all information furnished on this application is true and correct.</label>
<input type="checkbox" id="affirm" name="affirm" value="affirmation"
<?php /* Make checkbox sticky */ if (isset($_POST['affirm'])) echo "checked"; ?>> <br>
<br>
<div class="center"><input type="submit" id="submit" name="submit" value="Submit"></div>
</form>
<br>
*Notice: A Social Security Number is required by HRS &sect;11-15 and HRS &sect;15-4. It is used to prevent fraudulent registration and voting. Failure to furnish this information will prevent acceptance of this application. Pursuant to HRS &sect;11-20, the City/County Clerks may use this application to transfer a voter to the proper precinct to correspond with the address given above, under item 6.
</div>
</body>
</html>