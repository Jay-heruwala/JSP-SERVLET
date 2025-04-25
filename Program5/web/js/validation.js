// user-management/src/main/webapp/js/validation.js
function validateForm() {
    let isValid = true;
    const name = document.getElementById('name');
    const email = document.getElementById('emailId');
    const mobile = document.getElementById('mobileNo');
    const role = document.getElementById('roleId');
    const password = document.getElementById('password');

    // Clear previous invalid states
    document.querySelectorAll('.form-control').forEach(input => {
        input.classList.remove('is-invalid');
    });

    if (!name.value || name.value.trim() === '') {
        name.classList.add('is-invalid');
        isValid = false;
    }
    if (!email.value || !/^[A-Za-z0-9+_.-]+@(.+)$/.test(email.value)) {
        email.classList.add('is-invalid');
        isValid = false;
    }
    if (!mobile.value || !/^\d{10,15}$/.test(mobile.value)) {
        mobile.classList.add('is-invalid');
        isValid = false;
    }
    if (!role.value) {
        role.classList.add('is-invalid');
        isValid = false;
    }
    if (!password.value || password.value.length < 6 || password.value.length > 50) {
        password.classList.add('is-invalid');
        isValid = false;
    }

    return isValid;
}