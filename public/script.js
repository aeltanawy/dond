function validateForm() {
  var x = document.forms["myForm"]["chosenbox"].value;
  if (x == null || x == "") {
    alert("Box number must be filled out!");
    return false;
} else if (x >= 1 && x <= 22) {
    alert("You have chosen box: " + x + "!\n\nGame has started...");
    return true;
} else {
    alert("You must choose a number between 1 and 22!");
    return false;
}
}
