<%@ page  import="java.sql.*" %>
<%@ page  import="Util.DatabaseUtil,Entity.Book" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f6fa 0%, #e9ecef 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        .container {
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .card {
            border: none;
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            border-radius: 15px;
            overflow: hidden;
            background: white;
        }
        .table-container {
            padding: 20px;
        }
        .table {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }
        thead {
            background: linear-gradient(45deg, #2c3e50, #34495e);
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }
        th {
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid rgba(255,255,255,0.1);
        }
        td {
            padding: 12px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tbody tr {
            transition: all 0.3s ease;
        }
        tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .btn-add {
            background-color: #2ecc71;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        .btn-add:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
        }
        .btn-edit, .btn-delete {
            padding: 6px 12px;
            border-radius: 50%;
            margin: 0 5px;
            transition: all 0.3s ease;
        }
        .btn-edit {
            background-color: #3498db;
            border: none;
        }
        .btn-edit:hover {
            background-color: #2980b9;
            transform: scale(1.1);
        }
        .btn-delete {
            background-color: #e74c3c;
            border: none;
        }
        .btn-delete:hover {
            background-color: #c0392b;
            transform: scale(1.1);
        }
        .card-header {
            background: white;
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        .status-badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.85em;
        }
        .status-instock {
            background-color: #dff0d8;
            color: #2ecc71;
        }
        .status-low {
            background-color: #fcf8e3;
            color: #f1c40f;
        }
        .table-responsive {
            max-height: 600px;
            overflow-y: auto;
        }
        a{
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header bg-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="mb-0" style="color: #2c3e50;">Book Management</h3>
                    <a href="addBook.jsp" class="btn btn-add text-white">
                        <i class="fas fa-plus me-2"></i>Add New Book
                    </a>
                </div>
            </div>
            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Book ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>ISBN</th>
                                <th>Publisher</th>
                                <th>Edition</th>
                                <th>Catalogue</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        
                        <% 
                            Connection connection = DatabaseUtil.getConnection();
                            PreparedStatement preparedStatement = connection.prepareStatement("select * from book");
                            ResultSet rs = preparedStatement.executeQuery();
                        %>
                        <tbody>
                            <%
                                while(rs.next()){
                                %>
                                
                            <tr>
                                <tr>
                        <td><%= rs.getInt(1)%></td>
                        <td><%= rs.getString(2)%></td>
                        <td><%= rs.getString(3)%></td>
                        <td><%= rs.getDouble(4)%></td>
                        <td><%= rs.getInt(5)%></td>
                        <td><%= rs.getString(6)%></td>
                        <td><%= rs.getString(7)%></td>
                        <td><%= rs.getString(8)%></td>
                        <td><%= rs.getString(9)%></td>
                                <td>
                                    <button class="btn btn-edit btn-sm text-white" title="Edit">
                                        <a href="FetchBook?bookId=<%= rs.getInt(1) %>">
                                        <i class="fas fa-edit"></i></a>
                                    </button>
                                    <button class="btn btn-delete btn-sm text-white" title="Delete">
                                        <a href="DeleteBook?bookId=<%= rs.getInt(1) %>"
                                        <i class="fas fa-trash"></i> </a>
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>