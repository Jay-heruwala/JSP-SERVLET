<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f6fa 0%, #e9ecef 100%);
            min-height: 100vh;
            padding: 40px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-container {
            max-width: 900px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .form-header {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 10px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #2ecc71;
            box-shadow: 0 0 5px rgba(46,204,113,0.3);
        }
        .form-label {
            color: #34495e;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .btn-submit {
            background: linear-gradient(45deg, #2ecc71, #27ae60);
            border: none;
            padding: 12px;
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(46,204,113,0.3);
        }
        .btn-back {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            border: none;
            padding: 12px;
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(149,165,166,0.3);
        }
        .error-message {
            color: #e74c3c;
            font-size: 0.85em;
            margin-top: 4px;
            font-style: italic;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
            background-color: #fceae9;
            border: none;
            color: #e74c3c;
        }
        .input-group-text {
            background-color: #f8f9fa;
            border-radius: 8px 0 0 8px;
            border: 1px solid #ddd;
        }
        .form-section {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2 class="form-header"><i class="fas fa-book me-2"></i>Add New Book</h2>
        
        <% 
            String error = (String) request.getAttribute("error");
            if(error != null) {
        %>
            <div class="alert"><%= error %></div>
        <% } %>

        <form action="addBook" method="post" onsubmit="return validateForm()">
            <div class="form-section">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label">Title</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-book-open"></i></span>
                            <input type="text" class="form-control" name="title" id="title" required>
                        </div>
                        <div id="titleError" class="error-message"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Author</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" name="author" id="author" required>
                        </div>
                        <div id="authorError" class="error-message"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Price ($)</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                            <input type="number" step="0.01" class="form-control" name="price" id="price" required>
                        </div>
                        <div id="priceError" class="error-message"></div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label">Quantity</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-boxes"></i></span>
                            <input type="number" class="form-control" name="quantity" id="quantity" required>
                        </div>
                        <div id="quantityError" class="error-message"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">ISBN</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-barcode"></i></span>
                            <input type="text" class="form-control" name="isbn" id="isbn" required>
                        </div>
                        <div id="isbnError" class="error-message"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Publisher</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-building"></i></span>
                            <input type="text" class="form-control" name="publisher" id="publisher" required>
                        </div>
                        <div id="publisherError" class="error-message"></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Edition Year</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <input type="number" class="form-control" name="editionYear" id="editionYear" required>
                        </div>
                        <div id="editionYearError" class="error-message"></div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="row g-4">
                    <div class="col-12">
                        <label class="form-label">Catalogue ID</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-folder"></i></span>
                            <input type="text" class="form-control" name="catalogueId" id="catalogueId" required>
                        </div>
                        <div id="catalogueIdError" class="error-message"></div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-6">
                    <button type="submit" class="btn btn-submit text-white w-100">
                        <i class="fas fa-save me-2"></i>Save Book
                    </button>
                </div>
                <div class="col-md-6">
                    <a href="index.html" class="btn btn-back text-white w-100">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>
        </form>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
            document.querySelectorAll('.error-message').forEach(el => el.innerHTML = '');

            const title = document.getElementById('title').value;
            if(!title) {
                document.getElementById('titleError').innerHTML = 'Title is required';
                isValid = false;
            }

            const author = document.getElementById('author').value;
            if(!author) {
                document.getElementById('authorError').innerHTML = 'Author is required';
                isValid = false;
            }

            const price = document.getElementById('price').value;
            if(!price || price <= 0) {
                document.getElementById('priceError').innerHTML = 'Price must be greater than 0';
                isValid = false;
            }

            const quantity = document.getElementById('quantity').value;
            if(!quantity || quantity < 0) {
                document.getElementById('quantityError').innerHTML = 'Quantity cannot be negative';
                isValid = false;
            }

            const isbn = document.getElementById('isbn').value;
            if(!isbn || isbn.length < 10) {
                document.getElementById('isbnError').innerHTML = 'Valid ISBN is required';
                isValid = false;
            }

            const publisher = document.getElementById('publisher').value;
            if(!publisher) {
                document.getElementById('publisherError').innerHTML = 'Publisher is required';
                isValid = false;
            }

            const editionYear = document.getElementById('editionYear').value;
            if(!editionYear || editionYear < 1900 || editionYear > new Date().getFullYear()) {
                document.getElementById('editionYearError').innerHTML = 'Enter a valid year';
                isValid = false;
            }

            const catalogueId = document.getElementById('catalogueId').value;
            if(!catalogueId) {
                document.getElementById('catalogueIdError').innerHTML = 'Catalogue ID is required';
                isValid = false;
            }

            return isValid;
        }
    </script>
</body>
</html>