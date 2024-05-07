# installs and configs nginx server

class nginx {
  package { 'nginx':
    ensure => installed,
  }

  file { '/var/www/html/index.html':
    content => 'Hello World!',
  }

  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => '
      server {
        listen 80;
        server_name _;

        location / {
          return 301 http://$host/redirect_me;
        }

        location /redirect_me {
          return 301 http://$host/;
        }

        location / {
          root /var/www/html;
          index index.html;
        }
      }
    ',
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'link',
    target  => '/etc/nginx/sites-available/default',
    require => File['/etc/nginx/sites-available/default'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    hasrestart => true,
  }
}

include nginx
