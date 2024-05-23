# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx server
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
    server {
      listen 80;
      root /var/www/html;
      index index.html;

      location / {
        return 200 'Hello World!';
      }

      location /redirect_me {
        return 301 https://www.google.com/;
      }

      error_page 404 /404.html;
      location = /404.html {
        return 200 'Ceci n\'est pas une page';
      }
    }
  ",
}

# Enable Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
