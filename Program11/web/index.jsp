<%@ page language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.lang.NumberFormatException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calculator Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .form-container {
            background: white;
            padding: 1.5rem;
            border-radius: 6px;
            box-shadow: 0 2px 3px rgba(10, 10, 10, 0.1), 0 0 0 1px rgba(10, 10, 10, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .result {
            margin-top: 1rem;
            text-align: center;
        }
    </style>
    <script>
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
    </script>
</head>
<body>
    <div class="form-container">
        <form action="index.jsp" method="post" onsubmit="return validateForm()">
            <h2 class="title is-4 has-text-centered has-text-primary">Calculator</h2>
            <div class="field">
                <label class="label">Operand 1</label>
                <div class="control">
                    <input class="input" type="text" name="operand1" placeholder="Enter first number" value="<%= request.getParameter("operand1") != null ? request.getParameter("operand1") : "" %>">
                </div>
            </div>
            <div class="field">
                <label class="label">Operation</label>
                <div class="control">
                    <label class="radio">
                        <input type="radio" name="operation" value="add" <%= "add".equals(request.getParameter("operation")) ? "checked" : "" %>> Add
                    </label>
                    <label class="radio">
                        <input type="radio" name="operation" value="sub" <%= "sub".equals(request.getParameter("operation")) ? "checked" : "" %>> Sub
                    </label>
                    <label class="radio">
                        <input type="radio" name="operation" value="mul" <%= "mul".equals(request.getParameter("operation")) ? "checked" : "" %>> Mul
                    </label>
                    <label class="radio">
                        <input type="radio" name="operation" value="div" <%= "div".equals(request.getParameter("operation")) ? "checked" : "" %>> Div
                    </label>
                </div>
            </div>
            <div class="field">
                <label class="label">Operand 2</label>
                <div class="control">
                    <input class="input" type="text" name="operand2" placeholder="Enter second number" value="<%= request.getParameter("operand2") != null ? request.getParameter("operand2") : "" %>">
                </div>
            </div>
            <div class="field is-grouped">
                <div class="control">
                    <button class="button is-primary" type="submit">Calculate</button>
                </div>
                <div class="control">
                    <button class="button is-light" type="reset">Clear</button>
                </div>
            </div>
        </form>
        <%
            String operand1Str = request.getParameter("operand1");
            String operand2Str = request.getParameter("operand2");
            String operation = request.getParameter("operation");

            if (operand1Str != null && operand2Str != null && operation != null && !operand1Str.isEmpty() && !operand2Str.isEmpty()) {
                try {
                    double operand1 = Double.parseDouble(operand1Str);
                    double operand2 = Double.parseDouble(operand2Str);
        %>
        <jsp:useBean id="calculatorBean" class="com.ClaculatorBean" scope="page" />
        <jsp:setProperty name="calculatorBean" property="operand1" value="<%= operand1 %>" />
        <jsp:setProperty name="calculatorBean" property="operand2" value="<%= operand2 %>" />
        <jsp:setProperty name="calculatorBean" property="operation" value="<%= operation %>" />
        <%
                    calculatorBean.calculate();
                    double result = calculatorBean.getResult();
                    DecimalFormat df = new DecimalFormat("#.##########");
                    String formattedResult = df.format(result);
        %>
        <div class="result">
            <h3 class="title is-5 has-text-success">Result: <%= formattedResult %></h3>
        </div>
        <%
                } catch (NumberFormatException e) {
                    out.println("<div class='result'><h3 class='title is-5 has-text-danger'>Invalid input. Please enter valid numbers.</h3></div>");
                }
            }
        %>
    </div>
</body>
</html>