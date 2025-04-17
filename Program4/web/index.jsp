<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <style>
        .form-container {
            animation: fadeIn 0.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .error-message {
            color: #dc2626;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">
    <div class="form-container bg-white p-8 rounded-lg shadow-lg max-w-md w-full">
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-center text-gray-800">Create Account</h2>
            <p class="text-center text-gray-600 mt-2">Please fill in your details to register</p>
        </div>
        
        <%if(request.getAttribute("error") != null){  %>
         <div id="successMessage" class=" mt-4 p-3 bg-red-100 border border-red-200 text-red-700 rounded-md text-center">
            Invalid Information
        </div>
        <% } %>
        <br />
        <form id="registrationForm" action="LoginModule" method="POST" class="space-y-6">
            <div>
                <label for="role" class="block text-sm font-medium text-gray-700 mb-1">Select Role <span class="text-red-500">*</span></label>
                <div class="relative">
                    <select id="role" name="role" class="block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 appearance-none bg-white text-gray-700" required>
                        <option value="" disabled selected>Choose your role</option>
                        <option value="admin">Admin</option>
                        <option value="user">User</option>
                      
                    </select>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                        </svg>
                    </div>
                </div>
                <p id="roleError" class="error-message">Please select a role</p>
            </div>
            
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address <span class="text-red-500">*</span></label>
                <input type="email" id="email" name="email" placeholder="your.email@example.com" class="block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" required>
                <p id="emailError" class="error-message">Please enter a valid email address</p>
            </div>
            
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password <span class="text-red-500">*</span></label>
                <input type="password" id="password" name="password" placeholder="Create a secure password" class="block w-full px-4 py-3 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" required>
                <p id="passwordError" class="error-message">Password is required</p>
            </div>
            
            <div>
                <button type="submit" class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors duration-200">
                    Register Account
                </button>
            </div>
        </form>
        
        <div id="successMessage" class="hidden mt-4 p-3 bg-green-100 border border-green-200 text-green-700 rounded-md text-center">
            Registration successful! All fields are valid.
        </div>
    </div>

    
</body>
</html>