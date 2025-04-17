<%-- 
    Document   : Index
    Created on : 12 Mar 2025, 11:31:34 am
    Author     : jayhe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Fancy File Upload</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
    }
    
    .upload-container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      padding: 40px;
      width: 100%;
      max-width: 500px;
      transition: all 0.3s ease;
    }
    
    .upload-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
    }
    
    h1 {
      text-align: center;
      margin-bottom: 30px;
      color: #4a4a4a;
      font-weight: 600;
    }
    
    .file-upload {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    
    .file-upload-area {
      border: 2px dashed #764ba2;
      border-radius: 12px;
      padding: 40px 20px;
      width: 100%;
      text-align: center;
      transition: all 0.3s;
      margin-bottom: 20px;
      position: relative;
      cursor: pointer;
    }
    
    .file-upload-area:hover {
      border-color: #667eea;
      background-color: rgba(102, 126, 234, 0.05);
    }
    
    .file-upload-icon {
      font-size: 50px;
      color: #764ba2;
      margin-bottom: 15px;
      display: block;
    }
    
    .file-upload-text {
      color: #666;
      margin-bottom: 10px;
    }
    
    .browse-btn {
      color: #764ba2;
      font-weight: 600;
      text-decoration: underline;
      cursor: pointer;
    }
    
    .file-input {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      opacity: 0;
      cursor: pointer;
    }
    
    .additional-fields {
      width: 100%;
      margin-bottom: 20px;
    }
    
    .form-group {
      margin-bottom: 15px;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: 500;
      color: #4a4a4a;
    }
    
    .form-control {
      width: 100%;
      padding: 10px 15px;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 14px;
      transition: all 0.3s;
    }
    
    .form-control:focus {
      outline: none;
      border-color: #764ba2;
      box-shadow: 0 0 0 2px rgba(118, 75, 162, 0.2);
    }
    
    .submit-btn {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border: none;
      padding: 12px 25px;
      border-radius: 50px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      display: block;
      width: 100%;
      transition: all 0.3s;
      opacity: 0.9;
    }
    
    .submit-btn:hover {
      opacity: 1;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      .upload-container {
        padding: 25px;
      }
      
      .file-upload-area {
        padding: 30px 15px;
      }
    }
  </style>
</head>
<body>
  <div class="upload-container">
    <h1>Upload Your File</h1>
    
    <form action="FileUploaderServlet" method="post" enctype="multipart/form-data">
      <div class="file-upload">
        <div class="file-upload-area">
          <span class="file-upload-icon">📁</span>
          <p class="file-upload-text">Drag & Drop files here</p>
          <p class="file-upload-text">or <span class="browse-btn">browse files</span></p>
          <input type="file" class="file-input" name="profileimage" required>
        </div>
      </div>
      
      <button type="submit" class="submit-btn">Upload File</button>
    </form>
  </div>
</body>
</html>