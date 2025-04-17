
function validateForm() {
    var operand1 = document.forms[0]["operand1"].value;
    var operand2 = document.forms[0]["operand2"].value;
    var operation = document.querySelector('input[name="operation"]:checked');
    if (operand1 == "" || isNaN(operand1)) {
        alert("Please enter a valid number for Operand 1");
        return false;
    }
    if (operand2 == "" || isNaN(operand2)) {
        alert("Please enter a valid number for Operand 2");
        return false;
    }
    if (!operation) {
        alert("Please select an operation");
        return false;
    }
    return true;
}
