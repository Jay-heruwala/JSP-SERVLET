<%-- 
    Document   : Home
    Created on : 12 Mar 2025, 11:37:18 am
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
    
    .file-upload-area.active {
      border-color: #667eea;
      background-color: rgba(102, 126, 234, 0.05);
    }
    
    .file-upload-area i {
      font-size: 50px;
      color: #764ba2;
      margin-bottom: 15px;
      display: block;
    }
    
    .file-upload-area p {
      color: #666;
      margin-bottom: 10px;
    }
    
    .file-upload-area .browse-btn {
      color: #764ba2;
      font-weight: 600;
      text-decoration: underline;
      cursor: pointer;
    }
    
    #file-input {
      position: absolute;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      opacity: 0;
      cursor: pointer;
    }
    
    .file-info {
      display: none;
      width: 100%;
      margin-top: 15px;
      padding: 15px;
      background-color: #f8f9fa;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }
    
    .file-info p {
      margin: 5px 0;
      color: #555;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    
    .file-info p span:first-child {
      font-weight: 600;
    }
    
    .progress-container {
      width: 100%;
      height: 8px;
      background-color: #e9ecef;
      border-radius: 4px;
      margin: 15px 0;
      overflow: hidden;
    }
    
    .progress-bar {
      height: 100%;
      width: 0;
      background: linear-gradient(90deg, #667eea, #764ba2);
      border-radius: 4px;
      transition: width 0.3s ease;
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
      margin-top: 25px;
      transition: all 0.3s;
      opacity: 0.8;
    }
    
    .submit-btn:hover {
      opacity: 1;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
    }
    
    .submit-btn:disabled {
      opacity: 0.5;
      cursor: not-allowed;
      transform: none;
      box-shadow: none;
    }
    
    .success-message {
      display: none;
      text-align: center;
      color: #28a745;
      margin-top: 20px;
      font-weight: 600;
    }
    
    .error-message {
      display: none;
      text-align: center;
      color: #dc3545;
      margin-top: 20px;
      font-weight: 600;
    }
    
/*    @keyframes pulse {
      0% {
        box-shadow: 0 0 0 0 rgba(118, 75, 162, 0.4);
      }
      70% {
        box-shadow: 0 0 0 10px rgba(118, 75, 162, 0);
      }
      100% {
        box-shadow: 0 0 0 0 rgba(118, 75, 162, 0);
      }
    }*/
    
    .pulse {
      animation: pulse 1.5s infinite;
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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
  <div class="upload-container">
    <h1>Upload Your File</h1>
    
    <form id="upload-form">
      <div class="file-upload">
        <div class="file-upload-area" id="drop-area">
          <i class="fas fa-cloud-upload-alt"></i>
          <p>Drag & Drop files here</p>
          <p>or <span class="browse-btn">browse files</span></p>
          <input type="file" id="file-input" accept="*/*">
        </div>
        
        <div class="file-info" id="file-info">
          <p><span>Name:</span> <span id="file-name">-</span></p>
          <p><span>Size:</span> <span id="file-size">-</span></p>
          <p><span>Type:</span> <span id="file-type">-</span></p>
          
          <div class="progress-container">
            <div class="progress-bar" id="progress-bar"></div>
          </div>
        </div>
      </div>
      
      <button type="submit" class="submit-btn" id="submit-btn" disabled>Upload File</button>
      
      <p class="success-message" id="success-message">
        <i class="fas fa-check-circle"></i> File uploaded successfully!
      </p>
      
      <p class="error-message" id="error-message">
        <i class="fas fa-exclamation-circle"></i> <span id="error-text">Error uploading file.</span>
      </p>
    </form>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', () => {
      const dropArea = document.getElementById('drop-area');
      const fileInput = document.getElementById('file-input');
      const fileInfo = document.getElementById('file-info');
      const fileName = document.getElementById('file-name');
      const fileSize = document.getElementById('file-size');
      const fileType = document.getElementById('file-type');
      const progressBar = document.getElementById('progress-bar');
      const submitBtn = document.getElementById('submit-btn');
      const successMessage = document.getElementById('success-message');
      const errorMessage = document.getElementById('error-message');
      const errorText = document.getElementById('error-text');
      const uploadForm = document.getElementById('upload-form');
      
      let selectedFile = null;
      
      // Prevent default drag behaviors
      ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, preventDefaults, false);
        document.body.addEventListener(eventName, preventDefaults, false);
      });
      
      // Highlight drop area when item is dragged over it
      ['dragenter', 'dragover'].forEach(eventName => {
        dropArea.addEventListener(eventName, highlight, false);
      });
      
      ['dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, unhighlight, false);
      });
      
      // Handle dropped files
      dropArea.addEventListener('drop', handleDrop, false);
      
      // Handle selected files
      fileInput.addEventListener('change', handleFiles);
      
      uploadForm.addEventListener('submit', handleUpload);
      
      function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
      }
      
      function highlight() {
        dropArea.classList.add('active');
      }
      
      function unhighlight() {
        dropArea.classList.remove('active');
      }
      
      function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        
        handleFiles({ target: { files } });
      }
      
      function handleFiles(e) {
        const files = e.target.files;
        
        if (files.length) {
          selectedFile = files[0];
          updateFileInfo(selectedFile);
          fileInfo.style.display = 'block';
          submitBtn.disabled = false;
          submitBtn.classList.add('pulse');
          
          // Reset messages
          successMessage.style.display = 'none';
          errorMessage.style.display = 'none';
        }
      }
      
      function formatBytes(bytes, decimals = 2) {
        if (bytes === 0) return '0 Bytes';
        
        const k = 1024;
        const dm = decimals < 0 ? 0 : decimals;
        const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
        
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        
        return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
      }
      
      function updateFileInfo(file) {
        fileName.textContent = file.name;
        fileSize.textContent = formatBytes(file.size);
        fileType.textContent = file.type || 'Unknown';
      }
      
      function simulateUpload() {
        let progress = 0;
        progressBar.style.width = '0%';
        
        const interval = setInterval(() => {
          progress += Math.random() * 10;
          
          if (progress >= 100) {
            progress = 100;
            clearInterval(interval);
            
            // Simulate server processing delay
            setTimeout(() => {
              // Simulate successful upload (90% chance)
              if (Math.random() < 0.9) {
                showSuccess();
              } else {
                showError('Server error occurred. Please try again.');
              }
            }, 500);
          }
          
          progressBar.style.width = `${progress}%`;
        }, 200);
      }
      
      function handleUpload(e) {
        e.preventDefault();
        
        if (!selectedFile) {
          showError('Please select a file first.');
          return;
        }
        
        // Disable form elements during upload
        submitBtn.disabled = true;
        submitBtn.classList.remove('pulse');
        submitBtn.textContent = 'Uploading...';
        fileInput.disabled = true;
        
        // Reset messages
        successMessage.style.display = 'none';
        errorMessage.style.display = 'none';
        
        // Simulate file upload process
        simulateUpload();
      }
      
      function showSuccess() {
        successMessage.style.display = 'block';
        submitBtn.textContent = 'Upload Complete';
        
        // Reset form after 3 seconds
        setTimeout(() => {
          resetForm();
        }, 3000);
      }
      
      function showError(message) {
        errorText.textContent = message;
        errorMessage.style.display = 'block';
        submitBtn.textContent = 'Upload File';
        submitBtn.disabled = false;
        fileInput.disabled = false;
      }
      
      function resetForm() {
        uploadForm.reset();
        fileInfo.style.display = 'none';
        progressBar.style.width = '0%';
        submitBtn.textContent = 'Upload File';
        submitBtn.disabled = true;
        fileInput.disabled = false;
        selectedFile = null;
        successMessage.style.display = 'none';
        errorMessage.style.display = 'none';
      }
    });
  </script>
</body>
</html>
