function switchForm(formId) {
    document.querySelectorAll('.form-container').forEach(form => {
        form.classList.remove('active');
    });
    document.getElementById(formId).classList.add('active');
}

function validateRegistration() {

    const firstname = document.forms['registration']['firstname'].value;
    const lastname = document.forms["registration"]["lastname"].value;
    const email = document.forms["registration"]["email"].value;
    const mobileno = document.forms["registration"]["mobileno"].value;
    const role = document.forms["registration"]["role"].value;
    const address = document.forms["registration"]["address"].value;

    const password = document.forms["registration"]["password"].value;
    const confirmPassword = document.forms["registration"]["confirmpassword"].value;
    const regex = /^[a-zA-Z]+$/;
    const mobileNoregex = /^[0-9]{10}$/;
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    let isValid = true;


    if (!regex.test(firstname)) {
        document.getElementById("firstnameError").innerText = "Special characters / Digits are not allowed";
        isValid = false;
    } else if (firstname.length < 6) {
        document.getElementById("firstnameError").innerText = "First name must be 6 characters or more";
        isValid = false;
    } else {
        document.getElementById("firstnameError").innerText = "";
    }

    if (!regex.test(lastname)) {
        document.getElementById("lastnameError").innerText = "Special characters / Digits are not allowed";
        isValid = false;
    } else if (lastname.length < 6) {
        document.getElementById("lastnameError").innerText = "Last name must be 6 characters or more";
        isValid = false;
    } else {
        document.getElementById("lastnameError").innerText = "";
    }

    if (!emailRegex.test(email)) {
        document.getElementById("emailError").innerText = "Enter Valid email ";
        isValid = false;
    } else {
        document.getElementById("emailError").innerText = " ";
    }

    if (!mobileNoregex.test(mobileno)) {
        document.getElementById("mobilenoError").innerText = "Mobile no contains only digits";
        isValid = false;
    } else {
        document.getElementById("mobilenoError").innerText = "";
    }



    if (address.trim() === "") {
        document.getElementById("addressError").innerText = "Address cannot be empty";
        isValid = false;
    } else {
        document.getElementById("addressError").innerText = "";
    }

    if (password.length < 6) {
        document.getElementById("passwordError").innerText = "Password Must be Greater then 6 Character";
        isValid = false;
    } else {
        document.getElementById("passwordError").innerText = "";
    }


    if (password !== confirmPassword) {
        document.getElementById("confirmpasswordError").innerText = "Password and Confirm Password Must be Same";
        isValid = false;
    } else {
        document.getElementById("confirmpasswordError").innerText = "";
    }

    return isValid;
}


function LoginValidation() {
    const email = document.forms["LoginForm"]["login-email"].value;
    const password = document.forms["LoginForm"]["login-password"].value;

    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    let isValidForm = true;



    if (!emailRegex.test(email)) {
        document.getElementById("login-emilError").innerText = "Enter Valid email ";
        isValidForm = false;
    } else {
        document.getElementById("login-emilError").innerText = " ";
    }


    if (password.length < 6) {
        document.getElementById("login-passwordError").innerText = "Password Must be Greater then 5 Character";
        isValidForm = false;
    } else {
        document.getElementById("login-passwordError").innerText = "";
    }


    return isValidForm;
}