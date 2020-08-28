from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, TextAreaField
from wtforms.validators import ValidationError, DataRequired, Email, EqualTo, Length
from flask_babel import lazy_gettext as _l

password_length = Length(min=8, max=128, message=_l('Invalid password length'))

class LoginForm(FlaskForm):
    email = StringField(_l('Email'), validators=[DataRequired(), Email()], render_kw={"type":"text","id":"inp","placeholder":""})
    password = PasswordField(_l('Password'), validators=[DataRequired()], render_kw={"type":"password","id":"inp","placeholder":""})
    submit = SubmitField(_l('Login'),render_kw={"class":"btn btn-outline-dark btnwidth","value":_l("Login")})

class RegistrationForm(FlaskForm):
    username = StringField(_l('User Name'), validators=[DataRequired()], render_kw={"type":"text","id":"inp","placeholder":""})
    password = PasswordField(_l('Password'), validators=[DataRequired(), password_length], render_kw={"type":"password","id":"inp","placeholder":""})
    re_password = PasswordField(_l('Confirm Password'), validators=[DataRequired(), EqualTo('password',message=_l("Password doesn't match."))], render_kw={"type":"password","id":"inp","placeholder":""})
    email = StringField(_l('Email'), validators=[DataRequired(), Email()], render_kw={"type":"email","id":"inp","placeholder":""})
    dob = StringField(_l('Date of Birth'), validators=[DataRequired()], render_kw={"type":"text","class":"textbox-n","id":"inp date","placeholder":"","onfocusout":"(this.type='text')","onfocus":"(this.type='date')"})
    phone_no = StringField(_l('Phone Number'), validators=[DataRequired()], render_kw={"type":"number","id":"inp","placeholder":""})
    meter_id = StringField(_l('Meter ID'), validators=[DataRequired()], render_kw={"type":"text","id":"inp","placeholder":""})
    address = StringField(_l('Address'), validators=[DataRequired()], render_kw={"type":"text","id":"inp","placeholder":""})
    submit = SubmitField(_l('Register'),render_kw={"class":"btn btn-outline-dark btnwidth","value":_l("Register")})

class ResetPasswordReq(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()], render_kw={"type":"text","id":"inp","placeholder":""})
    submit = SubmitField('Request Reset Link',render_kw={"class":"btn btn-outline-dark","value":_l("Request Reset Link")})

class ResetPassword(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired(), password_length], render_kw={"type":"password","id":"inp","placeholder":""})
    re_password = PasswordField('Confirm Password', validators=[DataRequired(), EqualTo('password',message=_l("Password doesn't match."))], render_kw={"type":"password","id":"inp","placeholder":""})
    submit = SubmitField('Change Password',render_kw={"class":"btn btn-outline-dark btnwidth","value":_l("Change Password")})