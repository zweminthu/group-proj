from flask import Flask, render_template, request, session, url_for, redirect, flash
from flask_babel import Babel
from flask_babel import _
from flask_mysqldb import MySQL
from flask_mail import Message, Mail
from datetime import datetime, date
import flask_excel as excel
from pyexcel_xlsx import get_data
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from werkzeug.security import generate_password_hash, check_password_hash
from apscheduler.schedulers.background import BackgroundScheduler

import json, random, atexit

from config import Config
from forms import LoginForm, RegistrationForm, ResetPasswordReq, ResetPassword

app=Flask(__name__)
app.config.from_object(Config)
babel = Babel(app)
db = MySQL(app)
mail = Mail(app)
excel.init_excel(app)

LAN = ['en', 'my']
money = ['1000','5000','10000','50000','100000','500000','1000000']
head = ["Total Bill","Meter Unit","Month","Year","Meter ID","Customer ID","User ID","User Name"]
receipt_head = ["Receipt Number","Name","Customer ID","Meter ID","Address","Month","Year","Date","Current Reading",\
    "Previous Reading","Used Unit","Total Meter Bill","Maintenance Cost","Overdue","Total Cost"]

@app.route('/')
@app.route('/index')
def index():
    if 'loggedin' and 'admin_id' in session:
        now = datetime.now()
        last_month = now.month-1 if now.month > 1 else 12
        l = "JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC".split()[last_month-1]

        cur = db.connection.cursor()
        cur.execute("SELECT `user_name`,`total_bill`,`meter_id` FROM `invoice` WHERE `month`='{}'".format(l))
        payment_status = cur.fetchall()
        if not payment_status:
            payment_status = []
        
        cur.execute("SELECT `overdue`,`meter_id` FROM `overdues`")
        overdues = cur.fetchall()
        if not overdues:
            overdues = []

        cur.execute("SELECT `log`,`date`,`time` FROM `log` WHERE `user_id`='{}' AND \
            `table_name`='{}'".format(session['admin_id'],session['role']))
        logs = cur.fetchall()
        if not logs:
            logs = []

        adminhome = {"username":session['user_name'],"email":session['email'],"address":session['address'],\
            "phone_no":session['phone_no'],"payment_status":payment_status,"overdues":overdues,"logs":logs}
        return render_template("adminhome.html",adminhome=adminhome)

    elif 'loggedin' and 'customer_id' in session:
        bar_month=[]
        bar_unit=[]

        cur = db.connection.cursor()
        cur.execute("SELECT `month`,`meter_unit` FROM `current_year_payment` WHERE `user_id`={}".format(session['user_id']))
        graph = cur.fetchall()
        bar_month.extend([item[0] for item in graph])
        bar_unit.extend([item[1] for item in graph])

        cur.execute("SELECT `wallet_amount` FROM `wallet` WHERE `customer_id`={}".format(session['customer_id']))
        wallet = cur.fetchone()
        if wallet:
            t_balance = wallet[0]
        else:
            t_balance = 0

        current_month = datetime.now().strftime("%b")
        cur.execute("SELECT `total_bill`,`meter_unit` FROM `current_month_payment` WHERE `month`='{}' AND \
            `user_id`='{}'".format(current_month.upper(),session['user_id']))
        bill = cur.fetchone()
        if bill:
            c_m_t_b = bill[0]
            c_m_m_u = bill[1]
        else:
            c_m_t_b = c_m_m_u = 0

        cur.execute("SELECT `meter_id` FROM `meter` WHERE `customer_id`='{}'".format(session['customer_id']))
        rv = cur.fetchall()
        if rv:
            for v in rv:
                cur.execute("SELECT `month`,`year`,`total_bill`,`due_date`,`status` FROM `bill` \
                    WHERE `meter_id`='{}' AND `status`='Paid'".format(v[0]))
                summary = cur.fetchall()
            rv = rv[0][0]
        else:
            rv = ''
            summary = []

        cur.execute("SELECT `overdue`,`fine` FROM `overdues` INNER JOIN `bill` ON `overdues`.`meter_id`=`bill`.`meter_id` \
            WHERE `bill`.`month`='{}' AND `bill`.`status`='Overdue' AND `bill`.`meter_id`='{}'".format(current_month.upper(),rv))
        overdues = cur.fetchone()
        if overdues:
            overdue = overdues[0]
            fine = overdues[1]
        else:
            overdue = fine = 0

        cur.execute("SELECT `status` FROM `bill` WHERE `month`='{}' AND `meter_id`='{}'".format(current_month.upper(),rv))
        status = cur.fetchone()
        if status:
            if status[0] == "Paid":
                status = "paid"
            elif status[0] == "Queue" or "Overdue":
                status = "queue"
        else:
            status = ""
        
        userhome = {"labels":bar_month,"values":bar_unit,"t_balance":t_balance,"c_m_t_b":c_m_t_b,"c_m_m_u":c_m_m_u,\
            "overdue":overdue,"fine":fine,"summary":summary,"max":400,"meterid":rv,"username":session['user_name'],\
            "email":session['email'],"address":session['address'],"phone_no":session['phone_no'],"status":status}
        return render_template("userhome.html",userhome=userhome)

    flash(_("Please Login!"))
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `user` WHERE `email`='{}'".format(email))
        account = cur.fetchone()

        if not account:
            flash(_("Wrong Email Address or Password."))
            return redirect(url_for("login"))
        elif account[4] == "Flase":
            flash(_("Please confirm your email address first"))
            return redirect(url_for("login"))
        elif account and check_password_hash(account[2],password):
            session['loggedin'] = True
            session['user_id'] = account[0]
            session['user_name'] = account[1]
            session['email'] = account[3]
            session['phone_no'] = account[5]
            session['address'] = account[6]
            session['dob'] = account[7]
            session['role'] = account[8]
            if(session['role'] == 'customer'):
                cur.execute("SELECT `customer_id`,`shop` FROM `customer` WHERE `user_id`={}".format(session['user_id']))
                customer_id = cur.fetchone()
                session['customer_id'] = customer_id[0]
                cur.execute("INSERT INTO `online_status`(`customer_id`) VALUES('{}')".format(session['customer_id']))
                db.connection.commit()
                session['shop'] = customer_id[1]
            elif(session['role'] == 'admin'):
                cur.execute("SELECT `admin_id` FROM `admin` WHERE `user_id`={}".format(session['user_id']))
                admin_id = cur.fetchone()
                session['admin_id'] = admin_id[0]
            return redirect(url_for('index'))
        else:
            flash(_("Wrong Email Address or Password."))
            return redirect(url_for('login'))
    return render_template('login.html', form=form)

@app.route('/logout')
def logout():
    lan = ''
    if 'language' in session:
        lan = session['language']
    if 'customer_id' in session:
        cur = db.connection.cursor()
        cur.execute("DELETE FROM `online_status` WHERE `customer_id`='{}'".format(session['customer_id']))
        db.connection.commit()
    session.clear()
    if lan:
        session['language'] = lan
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        username = form.username.data
        password = generate_password_hash('{}'.format(form.password.data))
        email = form.email.data
        dob = form.dob.data
        phone_no = form.phone_no.data
        meter_id = form.meter_id.data
        address = form.address.data

        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `user` WHERE `email`='{}'".format(email))
        account = cur.fetchone()
        if account:
            flash(_("Account already exists."))
            return redirect(url_for('register'))
        else:
            cur.execute("INSERT INTO `user`(`user_name`, `password`, `email`, `phone_no`, `address`, `dob`) \
                VALUES('{}','{}','{}','{}','{}','{}')".format(username,password,email,phone_no,address,dob))
            db.connection.commit()
            cur.execute("SELECT `user_id` FROM `user` WHERE `email` = '{}'".format(email))
            rv = cur.fetchone()
            user_id = str(rv[0])
            session['user_id'] = user_id
            cur.execute("INSERT INTO `customer`(`user_id`) VALUES('{}')".format(user_id))
            db.connection.commit()
            cur.execute("SELECT `customer_id` FROM `customer` WHERE `user_id`='{}'".format(user_id))
            rv = cur.fetchone()
            customer_id = str(rv[0])
            cur.execute("INSERT INTO `wallet`(`wallet_amount`,`customer_id`) VALUES(0,{})".format(customer_id))
            db.connection.commit()
            cur.execute("INSERT INTO `meter`(`meter_id`,`meter_total_unit`,`meter_total_unit_cur_month`,`customer_id`) \
                VALUES('{}','{}','{}','{}')".format(meter_id,0,0,customer_id))
            db.connection.commit()
            confirm_email(email)
        flash(_("Please confirm your email address."))
        return redirect(url_for('login'))
    return render_template('register.html', form=form)

@app.route('/confirm/<token>')
def confirm(token):
    if 'loggedin' in session:
        return redirect(url_for('index'))
    email = verify_token(token)
    if email is None:
        flash(_("Token expired!"))
        return redirect(url_for('login'))
    else:
        cur = db.connection.cursor()
        cur.execute("UPDATE `user` SET `email_confirmed`='True' WHERE email='{}'".format(email))
        db.connection.commit()
        flash(_("Email confirmed"))
        return redirect(url_for('login'))
    return redirect(url_for('login'))

@app.route('/reset_password_req', methods=['GET', 'POST'])
def reset_password_req():
    if 'loggedin' in session:
        return redirect(url_for('index'))
    form = ResetPasswordReq()
    if form.validate_on_submit():
        email = form.email.data

        cur = db.connection.cursor()
        cur.execute("SELECT `user_id`,`email` FROM `user` WHERE `email`='{}'".format(email))
        check_user = cur.fetchone()
        
        if check_user is None:
            flash(_("Account does not exists"))
            return redirect(url_for('reset_password_req'))
        else:
            session['user_id'] = check_user[0]
            send_reset_email(email)
            flash(_("Please confirm email address to login!"))
            return redirect(url_for('login'))
    return render_template('reset_password_req.html', form=form)

@app.route('/reset_password/<token>', methods=['GET', 'POST'])
def reset_password(token):
    if 'loggedin' in session:
        return redirect(url_for('index'))
    email = verify_token(token)
    if email is None:
        flash(_("Token expired!"))
        return redirect(url_for('login'))
    form = ResetPassword()
    if form.validate_on_submit():
        password = generate_password_hash('{}'.format(form.password.data))

        cur = db.connection.cursor()
        cur.execute("UPDATE `user` SET `password`='{}' WHERE `email`='{}'".format(password,email))
        db.connection.commit()
        flash(_("Your account is now active! Try Login!"))
        return redirect(url_for('login'))
    return render_template('reset_password.html', form=form)

def get_receipt():
    current_month = datetime.now().strftime("%b")
    year = datetime.now().year
    cur = db.connection.cursor()
    cur.execute("SELECT * FROM `receipt` WHERE `customer_id`='{}' AND `month`='{}' AND `year`='{}'\
        ".format(session['customer_id'],current_month,year))
    receipt = cur.fetchall()
    return receipt

@app.route("/getreceipt")
def getreceipt():
    if 'loggedin' and 'customer_id' in session:
        receipt = get_receipt()
        receipt = receipt[0]
        return render_template("receipt.html",receipt=receipt)
    return redirect(url_for('index'))

@app.route("/receipt_download", methods=['GET'])
def receipt_download():
    if 'loggedin' and 'customer_id' in session:
        today = date.today()
        d = today.strftime("%d-%m-%Y")
        receipt = get_receipt()
        receipt = [list(x) for x in receipt]
        receipt.insert(0,receipt_head)
        return excel.make_response_from_array(receipt, "csv",
                                          file_name="{}-receipt".format(d))
    return redirect(url_for('index'))

@app.route("/user")
def user():
    if 'loggedin' and 'admin_id' in session:
        return render_template('user.html')
    return redirect(url_for('index'))

@app.route('/detail/<customer_id>')
def detail(customer_id):
    if 'loggedin' and 'admin_id' in session:
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `user_detail` WHERE `customer_id`='{}'".format(customer_id))
        user = cur.fetchone()
        cur.execute("SELECT `log`,`date`,`time` FROM `log` WHERE `user_id`='{}' AND `table_name`='customer'".format(customer_id))
        logs = cur.fetchall()
        return render_template('detail.html',user=user,logs=logs)
    return redirect(url_for('index'))

@app.route("/aboutus")
def aboutus():
    if 'loggedin' and 'customer_id' in session:
        return render_template("aboutus.html")
    return redirect(url_for('index'))

@app.route("/faq")
def faq():
    if 'loggedin' and 'customer_id' in session:
        return render_template("faq.html")
    return redirect(url_for('index'))

@app.route("/service")
def service():
    if 'loggedin' and 'customer_id' in session:
        return render_template("service.html")
    return redirect(url_for('index'))

@app.route("/noticeboard")
def noticeboard():
    if 'loggedin' in session:
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `noticeboard`")
        ntb = cur.fetchall()
        return render_template("noticeboard.html",ntb=ntb)
    return redirect(url_for('index'))

@app.route("/noticedit",methods=['GET','POST'])
def noticedit():
    if 'loggedin' in session:
        id = request.form['id']
        topic = request.form['topic']
        info = request.form['info']
        contents = request.form['contents']
        date = datetime.now().strftime("%d/%m/%Y")
        cur = db.connection.cursor()
        cur.execute("UPDATE `noticeboard` SET `topic`='{}',`info`='{}',contents='{}',`date`='{}' \
            WHERE `notic_id`='{}'".format(topic,info,contents,date,id))
        db.connection.commit()
        flash(_('Successfully Edited'))
        return json.dumps({'success':_('Successfully Edited')})
    return redirect(url_for('index'))

@app.route("/noticeboardedit",methods=['GET','POST'])
def noticeboardedit():
    if 'loggedin' and 'admin_id' in session:
        if request.args:
            id = request.args['id']
            cur = db.connection.cursor()
            cur.execute("SELECT * FROM `noticeboard` WHERE `notic_id`='{}'".format(id))
            noti = cur.fetchone()
            return render_template("noticeboardedit.html",noti=noti)
        return render_template("noticeboardedit.html")
    return redirect(url_for('index'))

@app.route('/noticupload',methods=['POST'])
def noticupload():
    if 'loggedin' and 'admin_id' in session:
        topic = request.form['topic']
        info = request.form['info']
        contents = request.form['contents']
        date = datetime.now().strftime("%d/%m/%Y")
        cur = db.connection.cursor()
        cur.execute('INSERT INTO `noticeboard`(`topic`,`info`,`contents`,`date`) \
            VALUES("{}","{}","{}","{}")'.format(topic,info,contents,date))
        db.connection.commit()
        return json.dumps({"success":_("Success")})
    return redirect(url_for('index'))

@app.route('/delnoti',methods=['POST'])
def delnoti():
    if 'loggedin' and 'admin_id' in session:
        id = request.form['id']
        cur = db.connection.cursor()
        cur.execute("DELETE FROM `noticeboard` WHERE `notic_id`='{}'".format(id))
        db.connection.commit()
        flash(_("Successfully Deleted"))
        return json.dumps({'success':'deleted'})
    return redirect(url_for('index'))

@app.route('/delete',methods=['POST'])
def delete():
    if 'loggedin' and 'admin_id' in session:
        customer_id = request.form['customer_id']
        cur = db.connection.cursor()
        cur.execute("SELECT `user_id` FROM `customer` WHERE `customer_id`='{}'".format(customer_id))
        u_id = cur.fetchone()
        # cur.execute("DELETE FROM `meter` WHERE `customer_id`='{}'".format(customer_id))
        cur.execute("DELETE FROM `customer` WHERE `customer_id`='{}'".format(customer_id))
        cur.execute("DELETE FROM `user` WHERE `user_id`='{}'".format(u_id[0]))
        db.connection.commit()
        flash(_("Successfully Deleted"))
        return json.dumps({'success':'deleted'})
    return redirect(url_for('index'))

@app.route('/make_shop',methods=['POST'])
def make_shop():
    if 'loggedin' and 'admin_id' in session:
        customer_id = request.form['customer_id']
        email = request.form['email']
        cur = db.connection.cursor()
        cur.execute("UPDATE `customer` SET `shop`='YES' WHERE `customer_id`={}".format(customer_id))
        db.connection.commit()
        send_shop_notice(email)
        return json.dumps({"success":_("User is now registered as shop")})
    return redirect(url_for('index'))

@app.route('/shop')
def shop():
    if 'loggedin' and 'customer_id' in session and session['shop'] == "YES":
        return render_template('shop.html',money=money)
    return redirect(url_for('index'))

@app.route('/ruleregu')
def ruleregu():
    if 'loggedin' and 'customer_id' in session:
        return render_template("ruleregu.html")
    return redirect(url_for('index'))

@app.route('/send_feedback',methods=['POST'])
def send_feedback():
    if 'loggedin' and 'customer_id' in session:
        friendliness = request.form['friendliness']
        accuracy = request.form['accuracy']
        usefulness = request.form['usefulness']
        use_in_future = request.form['use_in_future']
        sug_subject = request.form['sug_subject']
        suggestions = request.form['suggestions']

        cur = db.connection.cursor()
        cur.execute("INSERT INTO `suggestion`(`friendliness`,`accuracy`,`usefulness`,`use_in_future`,`suggest_subject`,\
            `suggestions`,`customer_name`,`customer_id`) VALUES('{}','{}','{}','{}','{}','{}','{}','{}')\
            ".format(friendliness,accuracy,usefulness,use_in_future,sug_subject,suggestions,session['user_name'],\
            session['customer_id']))
        db.connection.commit()
        return json.dumps({"success":_("Success")})
    return redirect(url_for('index'))

@app.route('/feedback')
def feedback():
    if 'loggedin' and 'admin_id' in session:
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `suggestion`")
        suggs = cur.fetchall()
        return render_template('feedback.html',suggs=suggs)
    return redirect(url_for('index'))

@app.route('/change_password', methods=['GET','POST'])
def change_password():
    if 'loggedin' in session:
        current_password = request.form['current_password']
        new_password = request.form['new_password']
        confirm_password = request.form['confirm_password']

        cur = db.connection.cursor()
        cur.execute("SELECT `password` FROM `user` WHERE `user_id`='{}'".format(session['user_id']))
        account = cur.fetchone()

        if (new_password != confirm_password):
            return json.dumps({"result":"wrong_password"})
        elif check_password_hash(account[0],current_password):
            password = generate_password_hash('{}'.format(new_password))

            cur = db.connection.cursor()
            cur.execute("UPDATE `user` SET `password`='{}' WHERE `user_id`='{}'".format(password,session['user_id']))
            db.connection.commit()

            add_activity("Updated Password")

            return json.dumps({"result":"updated"})
        else:
            return json.dumps({"result":"invalid_credential"})
    return redirect(url_for('index'))

@app.route('/edit', methods=['GET','POST'])
def edit():
    if 'loggedin' in session:
        username = request.form['username']
        phone_no = request.form['phone_no']
        address = request.form['address']
        email = request.form['email']
        cur = db.connection.cursor()
        cur.execute("UPDATE `user` SET `user_name`='{}', `phone_no`='{}', `address`='{}' WHERE \
            `email`='{}'".format(username,phone_no,address,email))
        db.connection.commit()
        add_activity("Information Updated")
        user = [username,phone_no,address]
        session['user_name'] = username
        session['phone_no'] = phone_no
        session['address'] = address
        # flash("Edited successfully")
        return json.dumps({"user_data":user})
    return redirect(url_for('index'))

@app.route('/search', methods=['GET','POST'])
def search():
    if request.form:
        text = request.form['searchUSER']
    else:
        text=""
    cur = db.connection.cursor()
    cur.execute("SELECT * FROM `user_detail`")
    user_detail = cur.fetchall()
    user_detail = [list(elem) for elem in user_detail]
    t_user = len(user_detail)
    users = []
    if text:
        for user in user_detail:
            if user[1].lower().startswith(str(text).lower()):
                users.append(user)
    else:
        users = user_detail
    cur.execute("SELECT * FROM `online_status`")
    o_status = cur.fetchall()
    o_s = []
    for o in o_status:
        o_s.extend(o)
    for i in range(len(users)):
        users[i].append('Offline')
        check = any(item in users[i] for item in o_s)
        if check:
            users[i][6] = ('Online')
    return json.dumps({"users":users,"t_user":t_user})

@app.route("/updatedb", methods=['GET', 'POST'])
def updatedb():
    if request.method == 'POST':
        bill = request.get_array(field_name='file')
        cur = db.connection.cursor()
        for b in bill:
            total_bill = cal_bill(int(b[3]))
            date = str(b[2]).split(" ")
            cur.execute("INSERT INTO `bill`(`meter_id`,`total_bill`,`maintenance_cost`,`due_date`,`meter_unit`,`month`,`year`,`status`) \
            VALUES('{}','{}','{}','{}','{}','{}','{}','{}')".format(b[0],total_bill,b[1],date[0],b[3],b[4],b[5],b[6]))
        db.connection.commit()
        cur.execute("SELECT * FROM `meter`")
        meter = cur.fetchall()
        for m in meter:
            meter_id = m[0]
            meter_total_unit = int(m[1])
            meter_total_unit_cur_month = int(m[2])
            current_month = datetime.now().strftime("%b")
            cur.execute("SELECT `meter_unit` FROM `bill` WHERE `meter_id`='{}' AND `month`='{}'".format(meter_id,current_month.upper()))
            m_unit = cur.fetchone()
            print(m_unit)
            meter_total_unit = meter_total_unit_cur_month
            print(meter_total_unit)
            
            meter_total_unit_cur_month += m_unit[0]
            cur.execute("UPDATE `meter` SET `meter_total_unit`='{}',`meter_total_unit_cur_month`='{}' WHERE `meter_id`='{}'".format(meter_total_unit,meter_total_unit_cur_month,meter_id))
            db.connection.commit()
        return '''
        <!doctype html>
        <h1>Success</h1>
        '''
    return render_template("updatedb.html")

@app.route("/month_download", methods=['GET','POST'])
def month_download():
    if 'loggedin' and 'admin_id' in session:
        mon = request.form.get('month')
        today = date.today()
        d = today.strftime("%d-%m-%Y")
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `current_month_payment` WHERE `month`='{}'".format(mon))
        cmpay = cur.fetchall()
        if cmpay:
            cmpay = [list(x) for x in cmpay]
        else:
            cmpay = []
        cmpay.insert(0,head)
        return excel.make_response_from_array(cmpay, "csv",
                                          file_name="{}-monthly".format(d))
    return redirect(url_for('index'))

@app.route("/year_download", methods=['GET','POST'])
def year_download():
    if 'loggedin' and 'admin_id' in session:
        yer = request.form.get('year')
        today = date.today()
        d = today.strftime("%d-%m-%Y")
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `current_year_payment` WHERE `year`='{}'".format(yer))
        cmpay = cur.fetchall()
        if cmpay:
            cmpay = [list(x) for x in cmpay]
        else:
            cmpay = []
        cmpay.insert(0,head)
        return excel.make_response_from_array(cmpay, "csv",
                                          file_name="{}-yearly".format(d))
    return redirect(url_for('index'))

##################################################################
# function to generate topup card numbers
# @app.route('/gen_topup_num')
# def gen_topup_num():
#     if 'loggedin' and 'admin_id' in session:
#         cur = db.connection.cursor()
#         for i in range(92837456523400,92837456523500):
#             cur.execute("INSERT INTO `topup`(`topup_code`,`money`) VALUES('{}','{}')".format(i,0))
#         db.connection.commit()
#         return '''
#         <!doctype html>
#         <h1>Success</h1>
#         '''
#     return redirect(url_for("index"))
##################################################################

@app.route('/generate')
def generate():
    if 'loggedin' and 'admin_id' in session:
        cur = db.connection.cursor()
        cur.execute("SELECT `topup_code` FROM `topup` WHERE `money`=0 AND `buy`='YES'")
        get = cur.fetchall()
        for g in get:
            cur.execute("UPDATE `topup` SET `money`='{}', `buy`='NO' WHERE `topup_code`='{}'".format(random.choice(money),g[0]))
        db.connection.commit()
        return json.dumps({'success':_('Success')})
    return redirect(url_for('index'))

@app.route('/view_topup')
def view_topup():
    if 'loggedin' in session:
        return render_template("view_topup.html",money=money)
    return redirect(url_for('index'))

@app.route('/shop_topup')
def shop_topup():
    if 'loggedin' in session:
        money = request.args['money']
        cur = db.connection.cursor()
        if money:
            cur.execute("SELECT * FROM `topup` WHERE `money`='{}' AND `buy`='NO'".format(money))
        else:
            cur.execute("SELECT * FROM `topup` WHERE `buy`='NO'")
        get_topup = cur.fetchall()
        return json.dumps({'get_topup':get_topup})
    return redirect(url_for('index'))

@app.route('/get_topup')
def get_topup():
    if 'loggedin' in session:
        money = request.args['money']
        cur = db.connection.cursor()
        if money:
            cur.execute("SELECT * FROM `topup` WHERE `money`='{}'".format(money))
        else:
            cur.execute("SELECT * FROM `topup`")
        get_topup = cur.fetchall()
        return json.dumps({'get_topup':get_topup})
    return redirect(url_for('index'))

@app.route('/buy_topup')
def buy_topup():
    if 'loggedin' in session:
        topup_id = request.args['topup_id']
        cur = db.connection.cursor()
        cur.execute("UPDATE `topup` SET `buy`='YES' WHERE `topup_code`='{}'".format(topup_id))
        db.connection.commit()
        return json.dumps({'success':_('Bought')})
    return redirect(url_for('index'))

@app.route('/topup', methods=['GET', 'POST'])
def topup():
    if 'loggedin' and 'customer_id' in session:
        topup_id = request.form['topupcode']
        re = request.form['re']
        re = re[1:]
        re = re.split('/')
        cur = db.connection.cursor()
        cur.execute("SELECT * FROM `topup` WHERE `topup_code`='{}'".format(topup_id))
        topup_info = cur.fetchone()
        if topup_info[1] != 0 and topup_info[2] == 'YES':
            cur.execute("SELECT `wallet_amount` FROM `wallet` WHERE `customer_id`='{}'".format(session['customer_id']))
            wallet_amount = cur.fetchone()
            total = wallet_amount[0]+topup_info[1]
            cur.execute("UPDATE `wallet` SET `wallet_amount`='{}' WHERE `customer_id`='{}'".format(total,session['customer_id']))
            cur.execute("UPDATE `topup` SET `money`=0 WHERE `topup_code`='{}'".format(topup_id))
            db.connection.commit()
            # flash("Success")
            return json.dumps({'money':total})
        else:
            flash(_("Error"))
            return redirect(url_for(re[0], customer_id=re[1]))
    return redirect(url_for('index'))

@app.route('/pay', methods=['POST'])
def pay():
    if 'loggedin' and 'customer_id' in session:
        c_m_t_b = request.form['c_m_t_b']
        cur = db.connection.cursor()
        cur.execute("SELECT `wallet_amount` FROM `wallet` WHERE `customer_id`='{}'".format(session['customer_id']))
        wm = cur.fetchone()
        if int(c_m_t_b) > int(wm[0]):
            return json.dumps({'msg':'You don\'t have enough balance'})
        else:
            pay_bill = int(wm[0])-int(c_m_t_b)
            cur.execute("UPDATE `wallet` SET `wallet_amount`='{}' WHERE `customer_id`='{}'".format(pay_bill,session['customer_id']))
            cur.execute("UPDATE `bill` INNER JOIN `meter` ON `bill`.`meter_id`=`meter`.`meter_id` SET `bill`.`status`='Paid' WHERE `meter`.`customer_id`='{}'".format(session['customer_id']))
            db.connection.commit()
            add_activity("Paid")
            generate_receipt()
            return json.dumps({'msg':_('Successfully Paid')})
    return redirect(url_for('index'))

@app.route('/cal',methods=['POST'])
def cal():
    if 'loggedin' and 'customer_id' in session:
        meterunit = request.form['meterunit']
        meterunit = int(meterunit)
        bill = cal_bill(meterunit)
        return json.dumps({'bill':bill})
    return redirect(url_for('index'))

@app.route('/lan')
def lan():
    language = request.args["lan"]
    re = request.args["re"]
    re = re[1:]
    re = re.split('/')
    session['language'] = language
    if len(re) == 1:
        return redirect(url_for(re[0]))
    else:
        return redirect(url_for(re[0], customer_id=re[1]))

@app.context_processor
def get_notice():
    cur = db.connection.cursor()
    cur.execute("SELECT * FROM `noticeboard`")
    ntb = cur.fetchall()
    return dict(notice=ntb)

@babel.localeselector
def get_locale():
    try:
        language = session['language']
    except KeyError:
        language = None
    if language is not None:
        return language
    return request.accept_languages.best_match(LAN)

@app.context_processor
def inject_conf_var():
    return dict(
        AVAILABLE_LANGUAGES=LAN,
        CURRENT_LANGUAGE=session.get('language',request.accept_languages.best_match(LAN)))

def confirm_email(email):
    token = get_token()
    msg = Message('Confirm Email Address',
                    sender='noreply@demo.com',
                    recipients=[email])
    msg.body = '''To confirm your email address, visit the following link:
    {}
    This link will expire in 30 minutes.
    '''.format(url_for('confirm',token=token,_external=True))
    mail.send(msg)

def get_token():
    expires_sec = 1800
    s = Serializer(app.config['SECRET_KEY'], expires_sec)
    return s.dumps({'user_id':session['user_id']}).decode('utf-8')

def verify_token(token):
    s = Serializer(app.config['SECRET_KEY'])
    try:
        user_id = s.loads(token)['user_id']
        cur = db.connection.cursor()
        cur.execute("SELECT `email` FROM `user` WHERE `user_id`='{}'".format(user_id))
        email = cur.fetchone()
    except:
        return None
    return email[0]

def send_reset_email(email):
    token = get_token()
    msg = Message('Password Reset Request',
                    sender='noreply@demo.com',
                    recipients=[email])
    msg.body = '''To reset your password, visit the following link:
    {}
    If you did not make this request then simply ignore thsi email and no changes will be made.
    '''.format(url_for('reset_password',token=token,_external=True))
    mail.send(msg)

def send_shop_notice(email):
    msg = Message('You Can Now Sell Topup Cards',
                    sender='noreply@demo.com',
                    recipients=[email])
    msg.body = '''You are now recongnized as one of our topup cards sellers.'''
    mail.send(msg)

def add_activity(act):
    date = datetime.now().strftime("%d/%m/%Y")
    time = datetime.now().strftime("%H:%M")

    if 'customer_id' in session:
        user_id = session['customer_id']
    elif 'admin_id' in session:
        user_id = session['admin_id']

    cur = db.connection.cursor()
    cur.execute("INSERT INTO `log`(`log`,`date`,`time`,`user_id`,`table_name`) \
        VALUES('{}','{}','{}','{}','{}')".format(act,date,time,user_id,session['role']))
    db.connection.commit()
    return None

def generate_receipt():
    name = session['user_name']
    customer_id = session['customer_id']
    address = session['address']
    date = datetime.now().strftime("%d/%m/%Y")
    current_month = datetime.now().strftime("%b")
    cur = db.connection.cursor()
    cur.execute("SELECT `meter_id` FROM `meter` WHERE `customer_id`='{}'".format(customer_id))
    meter_id = cur.fetchone()
    meter_id = meter_id[0]
    cur.execute("SELECT `year`,`total_bill`,`maintenance_cost` FROM `bill` WHERE `meter_id`='{}' \
        AND `month`='{}'".format(meter_id,current_month.upper()))
    bill_item = cur.fetchone()
    year = bill_item[0]
    total_bill = bill_item[1]
    maintenance_cost = bill_item[2]
    cur.execute("SELECT `meter_total_unit`,`meter_total_unit_cur_month` FROM `meter` WHERE `meter_id`='{}'".format(meter_id))
    meter_item = cur.fetchone()
    previous_reading = meter_item[0]
    current_reading = meter_item[1]
    used_unit = int(current_reading) - int(previous_reading)
    cur.execute("SELECT `overdue`,`fine` FROM `overdues` WHERE `customer_id`='{}'".format(customer_id))
    overdue_item = cur.fetchone()
    if overdue_item:
        overdue = int(overdue_item[0]) + int(overdue_item[1])
    else:
        overdue = 0
    total = total_bill + maintenance_cost + overdue
    cur.execute("INSERT INTO `receipt`(`name`,`customer_id`,`meter_id`,`address`,`month`,`year`,`date`,\
        `current_reading`,`previous_reading`,`used_unit`,`total_bill`,`maintenance_cost`,\
        `overdue`,`total`) VALUES('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')\
        ".format(name,customer_id,meter_id,address,current_month,year,date,current_reading,previous_reading,used_unit,total_bill,maintenance_cost,overdue,total))
    db.connection.commit()
    return True

def check(m_id):
    cur = db.connection.cursor()
    current_month = datetime.now().strftime("%b")
    current_year = datetime.now().strftime("%Y")
    cur.execute("SELECT * FROM `overdues` WHERE `meter_id`='{}' AND `month`='{}' AND `year`='{}'".format(m_id,current_month,current_year))
    available = cur.fetchone()
    if available:
        return True
    else:
        return False

def make_overdue():
    cur = db.connection.cursor()
    current_month = datetime.now().strftime("%b")
    current_year = datetime.now().strftime("%Y")
    today = date.today()
    cur.execute("SELECT * FROM `bill` WHERE `month`='{}' AND `year`='{}'".format(current_month,current_year))
    bills = cur.fetchall()
    for bill in bills:
        if today == bill[4]:
            if not check(bill[1]):
                cur.execute("INSERT INTO `overdues`(`meter_id`,`month`,`year`,`overdue`,`fine`,`paid`) \
                    VALUES('{}','{}','{}',2000,0,'NO')".format(bill[1],current_month,current_year))
        if today > bill[4]:
            if check(bill[1]):
                cur.execute("SELECT * FROM `overdues` WHERE `month`='{}' AND `year`='{}' AND \
                    `meter_id`='{}'".format(current_month,current_year,bill[1]))
                get = cur.fetchone()
                day = today - bill[4]
                cur.execute("UPDATE `overdues` SET `fine`='{}' WHERE `meter_id`='{}'".format(2000 * day,get[0]))
                db.connection.commit()
    return True

def cal_bill(units):
    if(units<=30):
        payAmount=units*35
    elif(units<=50):
        payAmount=(30*35)+(units-30)*50
    elif(units<=75):
        payAmount=(30*35)+ (50-30)*50 +(units-50)*70
    elif(units<=100):
        payAmount=(30*35)+ (50-30)*50 + (76-51)*70 + (units-75)*90
    elif(units<=150):
        payAmount=(30*35)+ (50-30)*50 + (76-51)*70 + (101-76)*90 + (units -100)*110
    elif(units<=200):
        payAmount=(30*35)+ (50-30)*50 + (76-51)*70 + (101-76)*90 + (151 -101)*110 + (units -150)*120
    elif(units>=201):
        payAmount=(30*35)+ (50-30)*50 + (76-51)*70 + (101-76)*90 + (151 -101)*110 + (201 -151)*120 + (units -200)*125
    else:
        payAmount=0
    return payAmount

scheduler = BackgroundScheduler()
scheduler.add_job(func=make_overdue, trigger="interval", hours=24)
scheduler.start()

atexit.register(lambda: scheduler.shutdown())

if __name__=="__main__":
	app.run(host="0.0.0.0",debug=True)
