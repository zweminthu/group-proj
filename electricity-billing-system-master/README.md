# Electricity Billing System

The proposed “Electricity Billing System” is an application to automate the process of ordering and calculating the electricity bill with all the charges and penalties for a consumer who has been given an electricity connection.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them.

* Python 3
* MySQL

### Installing

A step by step series of examples that tell you how to get a development env running

Clone the repo

```
git clone https://gitgud.napier.ac.uk/40437404/electricity-billing-system.git
```

Setup Database

Import data from `mysql_data`

Install Python Requirements

```
pip install -r requirements.txt
```

Edit `config.py`

```
SECRET_KEY = your_secret_key
MYSQL_HOST = 'localhost'
MYSQL_PORT = 3306
MYSQL_USER = 'root'
MYSQL_PASSWORD = 'your_password'
MYSQL_DB = 'ebill_system'
```

### Running Electricity Billing System

Open Terminal or CMD and type

```
cd electricity-billing-system
python server.py
```

## Authors

* **Zwe Min Thu** - *Project Manager* - [40437535](https://gitgud.napier.ac.uk/40437535)
* **Khant Sithu Aung** - *Project Manager Support* - [40437529](https://gitgud.napier.ac.uk/40437529)
* **Maung Maung Oo** - *Team Leader* - [40437404](https://gitgud.napier.ac.uk/40437404)
* **Aung Htet Myat Kyaw** - *Developer* - [40437509](https://gitgud.napier.ac.uk/40437509)
* **Swan Fevian Kyaw** - *Developer* - [40437543](https://gitgud.napier.ac.uk/40437543)

## Acknowledgments

* https://tempusdominus.github.io/bootstrap-4/
* https://codeshack.io/login-system-python-flask-mysql/
* https://blog.ruanbekker.com/blog/2017/12/14/graphing-pretty-charts-with-python-flask-and-chartjs/
* The Flask Mega-Tutorial