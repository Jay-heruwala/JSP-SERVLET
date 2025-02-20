
function validateForm() {
    // Get form elements
    const principal = document.forms["compoundForm"]["principalInvestment"].value;
    const rate = document.forms["compoundForm"]["rate"].value;
    const year = document.forms["compoundForm"]["year"].value;
    const month = document.forms["compoundForm"]["month"].value;
    let numberCheckReg = /^[0-9]+$/;

    function isStrictInteger(value) {
        return /^[0-9]+$/.test(value);
    }

    // Validate Principal Amount
    if (principal === "" || isNaN(principal) || principal <= 0) {
        document.getElementById("errormsg").innerHTML = "Please enter a valid Principal Amount";
        return false;
    }

    if (Number(principal) > 2000000000) {
        document.getElementById("errormsg").innerHTML = "Value is not greater than 2000000000 ";
        return false;
    }



    // Validate Interest Rate
    if (rate === "" || isNaN(rate) || rate <= 0) {
        document.getElementById("errormsg").innerHTML = "Please enter a valid Interest Rate";

        return false;
    }

    if (Number(rate) > 100 || Number(rate) < 0) {
        document.getElementById("errormsg").innerHTML = "Rate must be between 0.1-100";
        return false;
    }

    // Validate Years
    if (year === "" || isNaN(year) || year < 0) {
        document.getElementById("errormsg").innerHTML = "Please enter a valid number of Years (0 or more)";
        return false;
    }


    if (!isStrictInteger(year)) {
        document.getElementById("errormsg").innerHTML = "Please enter valid Year ";
        return false;
    }

    // Validate Months
    if (month === "" || isNaN(month) || month < 0 || month >= 12) {
        document.getElementById("errormsg").innerHTML = "Please enter a valid number of Months (0-12).";
        return false;
    }

    if (!isStrictInteger(month)) {
        document.getElementById("errormsg").innerHTML = "Please enter valid Month";
        return false;
    }

    if (Number(year) == 0 && Number(month) == 0) {
        document.getElementById("errormsg").innerHTML = "Enter valid time period";
        return false;
    }

    return true; // Allow the form to submit if all validations pass
}
     