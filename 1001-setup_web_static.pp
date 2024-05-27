# Puppet for setup

$nginx_conf = "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By ${hostname};
    root   /var/www/html;
    index  index.html index.htm;
    location /etpl_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }
    location /redirect_me {
        return 301 https://github.com/BekaHabesha/Ethio_Properties;
    }
    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}"

package { 'nginx':
  ensure   => 'present',
  provider => 'apt'
}

-> file { '/data':
  ensure  => 'directory'
}

-> file { '/data/web_static':
  ensure => 'directory'
}

-> file { '/data/web_static/releases':
  ensure => 'directory'
}

-> file { '/data/web_static/releases/test':
  ensure => 'directory'
}

-> file { '/data/web_static/shared':
  ensure => 'directory'
}

-> file { '/data/web_static/releases/test/index.html':
  ensure  => 'present',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <b><u>Ethiopian Properties List Web Site</b></u>
           <p>
             This Web Site developed to solve<br>
             The shortage of updated and detailed<br>
             information and precise data about<br>
             Ethiopian Real Estate Properties List<br>
             <br>
             and Also, This Web Site provides a precise<br>
             and reliable data , Updated , accurate and<br>
             detailed Information about the real estates<br>
             companies and specified their properties types<br>
             project stage, available loccation.
           </p>
  </body>
</html>"
}

-> file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test'
}

-> exec { 'chown -R ubuntu:ubuntu /data/':
  path => '/usr/bin/:/usr/local/bin/:/bin/'
}

file { '/var/www':
  ensure => 'directory'
}

-> file { '/var/www/html':
  ensure => 'directory'
}

-> file { '/var/www/html/index.html':
  ensure  => 'present',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <b><u>Ethiopian Properties List Web Site</b></u>
           <p>
             This Web Site developed to solve<br>
             The shortage of updated and detailed<br>
             information and precise data about<br>
             Ethiopian Real Estate Properties List<br>
             <br>
             and Also, This Web Site provides a precise<br>
             and reliable data , Updated , accurate and<br>
             detailed Information about the real estates<br>
             companies and specified their properties types<br>
             project stage, available loccation.
           </p>
  </body>
</html>"
}

-> file { '/var/www/html/404.html':
  ensure  => 'present',
  content => "Ceci n'est pas une page - Error page\n"
}

-> file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => $nginx_conf
}

-> exec { 'nginx restart':
  path => '/etc/init.d/'
}
