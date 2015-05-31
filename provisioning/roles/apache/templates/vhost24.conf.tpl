# Default Apache virtualhost template

<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    UseCanonicalName Off
    VirtualDocumentRoot {{ doc_root }}
{% set servernames = servername.split() %}
{% for servername in servernames %}
{% if loop.first %}
    ServerName {{ servername }}
{% else %}
    ServerAlias {{ servername }}
{% endif %}
{% endfor %}

  <Directory {{dir_root}}>
    Options FollowSymLinks
    AllowOverride None
    RewriteEngine On
    RewriteBase /
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule /var/www/sites/.*/www/(.*)$ index.php/?q=$1 [L,QSA]
    Order allow,deny
    Allow from all
  </Directory>

  <Directory />
    Options FollowSymLinks
    AllowOverride None
  </Directory>
</VirtualHost>
