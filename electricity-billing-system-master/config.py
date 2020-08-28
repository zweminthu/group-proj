import os

class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or "my-powerfull-secret-key"
    MYSQL_HOST = 'localhost'
    MYSQL_PORT = 3306
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = 'asd123!@#'
    MYSQL_DB = 'ebill_system'
    MAIL_SERVER = 'smtp.googlemail.com'
    MAIL_PORT = 587
    MAIL_USE_TLS = 'True'
    MAIL_USERNAME = 'yourniama@gmail.com'
    MAIL_PASSWORD = 'maungmaungoo2000'