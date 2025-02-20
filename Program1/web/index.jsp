<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compound Interest Calculator</title>
       
        
        <script src="script.js"></script>
    </head>
     <link rel="stylesheet" href="style.css"/> 
    <body>
        <div class="container">
            <h1>Compound Interest Calculator</h1>
            <form name="compoundForm" action="Calculate" method="POST" onsubmit="return validateForm()" > 
                
                <div>
                    <label>Principal Amount :</label>
                    <input type="text" name="principalInvestment" value="" />
                </div>

                <div>
                    <label>Interest Rate :</label>
                    <input type="text" name="rate" value="" />
                </div>

                <div class="row">
                    <div class="column">
                        <label>Years :</label>
                        <input type="text" name="year" value="" />
                    </div>
                    <div class="column">
                        <label>Months :</label>
                        <input type="text" name="month" value="" />
                    </div>
                </div>

                <div>
                    <label>Compounded Interest :</label>
                    <select name="noOfTimesCompounded">
                        <option value="365">Daily (365/yr)</option>
                        <option value="360">Daily (360/yr)</option>
                        <option value="52">Weekly (52/yr)</option>
                        <option value="26">Bi-Week (26/yr)</option>
                        <option value="24">Half-Month (24/yr)</option>
                        <option value="12">Monthly (12/yr)</option>
                        <option value="6">Bi-Month (6/yr)</option>
                        <option value="4">Quarterly (4/yr)</option>
                        <option value="2">Half-Year (2/yr)</option>
                        <option value="1" >Yearly (1/yr)</option>
                    </select>
                </div>

                <div class="errormsg" id="errormsg"></div>




                <div class="errormsg" id="serverErrormsg">
                    <%= (request.getAttribute("valueError") != null) ? request.getAttribute("valueError") : ""%>
                </div>                

                <button type="submit">Calculate</button>
            </form>
            <% if (request.getAttribute("principal") != null) {%>
            <div id="result" class="result-container">
                <h5>Compound Interest Result:</h5>
                <p>Principal: <%= request.getAttribute("principal")%></p>
                <p>Rate of Interest : <%= request.getAttribute("rate")%>%</p>
                <p>Time Period :<%= request.getAttribute("year")%> Year <%= request.getAttribute("month")%> Month </p>
                <p>Interest: <%= request.getAttribute("interest")%></p>
                <p>Total Amount: <%= request.getAttribute("amount")%></p>
            </div>
            <% }%>
        </div>
    </body>


<!--    <script>
        // Disable Right Click
        document.addEventListener("contextmenu", function (event) {
            event.preventDefault();
        });

        // Disable F12, Ctrl+Shift+I, Ctrl+U
        document.addEventListener("keydown", function (event) {
            if (event.key === "F12" ||
                    (event.ctrlKey && event.shiftKey && event.key === "I") ||
                    (event.ctrlKey && event.key === "u")) {
                event.preventDefault();
            }
        });

    </script>-->


</html>
