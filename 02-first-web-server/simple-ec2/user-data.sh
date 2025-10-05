#!/bin/bash
# Simple web server setup script
yum update -y
yum install -y httpd

# Start Apache
systemctl start httpd
systemctl enable httpd

# Create a simple web page
cat > /var/www/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>${server_name}</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 40px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 90vh;
        }
        .container { 
            max-width: 800px; 
            margin: 0 auto; 
            text-align: center;
            background: rgba(255,255,255,0.1);
            padding: 40px;
            border-radius: 15px;
        }
        h1 { color: #fff; margin-bottom: 20px; }
        .info { 
            background: rgba(255,255,255,0.1); 
            padding: 15px; 
            margin: 15px 0; 
            border-radius: 8px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 ${server_name}</h1>
        <div class="info">
            <h3>SUCCESS! Your web server is running!</h3>
            <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
            <p><strong>Public IP:</strong> <span id="public-ip">Loading...</span></p>
            <p><strong>Availability Zone:</strong> <span id="availability-zone">Loading...</span></p>
        </div>
        <div class="info">
            <p>🚀 Deployed with Terraform</p>
            <p>☁️ Running on AWS</p>
            <p>⚡ Powered by Amazon Linux 2</p>
        </div>
    </div>

    <script>
        // Fetch instance metadata
        fetch('http://169.254.169.254/latest/meta-data/instance-id')
            .then(response => response.text())
            .then(data => document.getElementById('instance-id').textContent = data);

        fetch('http://169.254.169.254/latest/meta-data/public-ipv4')
            .then(response => response.text())
            .then(data => document.getElementById('public-ip').textContent = data);

        fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone')
            .then(response => response.text())
            .then(data => document.getElementById('availability-zone').textContent = data);
    </script>
</body>
</html>
EOF

# Set permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Restart Apache
systemctl restart httpd
