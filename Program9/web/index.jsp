<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.MedicineDAO, Entity.Medicine, java.util.List, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Medicine List</title>
        <style>
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
            }
            .search-box {
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            input[type="text"] {
                padding: 8px;
                width: 200px;
            }
            button {
                padding: 8px 15px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Medicine Inventory</h2>

            <!-- Search Box -->
            <div class="search-box">
                <form action="SearchMedicine" method="POST">
                    <input type="text" name="searchMedicine" id="searchInput" placeholder="Search by medicine name...">
                    <button onclick="searchMedicine()">Search</button>
                </form>
            </div>

            <!-- Medicine Table -->
            <table id="medicineTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Medicine Name</th>
                        <th>Detail</th>
                        <th>Manufacturer</th>
                        <th>Batch No</th>
                        <th>Mfg Date</th>
                        <th>Exp Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Medicine> medicines;
                        SimpleDateFormat sdf = new SimpleDateFormat("MM-yyyy");
                        if(session.getAttribute("searchedMedicines") != null){
                            medicines = (List<Medicine>)session.getAttribute("searchedMedicines");
                        }else{
                            MedicineDAO medicineDAO = new MedicineDAO();
                            medicines = medicineDAO.getAllMedicines();
                        
                        }
                        
                        
                      
                        if (medicines.size() > 0) {

                            for (Medicine med : medicines) {
                    %>
                    <tr>
                        <td><%= med.getId()%></td>
                        <td><%= med.getMedicineName()%></td>
                        <td><%= med.getMedicineDetail()%></td>
                        <td><%= med.getManufacturerName()%></td>
                        <td><%= med.getBatchNo()%></td>
                        <td><%= sdf.format(med.getManufacturingMonthYear())%></td>
                        <td><%= sdf.format(med.getExpiryMonthYear())%></td>
                    </tr>
                    <% }
                    } else {
                    %>
                    No found
                    <%
    }%>
                </tbody>
            </table>
        </div>
                
                <%
                    if(session != null){
                    session.invalidate();
                    }
                %>

        <script>
            function searchMedicine() {
                let input = document.getElementById("searchInput").value.toLowerCase();
                let table = document.getElementById("medicineTable");
                let tr = table.getElementsByTagName("tr");

                for (let i = 1; i < tr.length; i++) {
                    let td = tr[i].getElementsByTagName("td")[1]; // Medicine Name column
                    if (td) {
                        let txtValue = td.textContent || td.innerText;
                        if (txtValue.toLowerCase().indexOf(input) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            document.getElementById("searchInput").addEventListener("keypress", function (event) {
                if (event.key === "Enter") {
                    searchMedicine();
                }
            });
        </script>
    </body>
</html>