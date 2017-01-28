from flask import Flask,request,session,g,redirect,url_for, \
	abort, render_template,flash

#database connection
import os
import sqlite3
from passlib.hash import pbkdf2_sha256 #hash
path_db = os.getcwd() + '/db/flask_db.db'
DATABASE = path_db
SECRET_KEY = 'development key' #secure sessions of client-side

import Users
import Bill
class Client(Users.Users):
	afm =""
	'''
	def __init__(self, new_afm, *args, **kwargs):#override to init tou Users.py
		#eksasfalise oti einai swsto gt den allazei!
		self.afm = new_afm
		#Users.Users.usersCounter = Users.Users.usersCounter - 1 #den theloume na auskithi o counter xwris dimiourgia neou xristi :/
	'''
	def getAfm(self):
		return self.afm


	def show_bill(self):
		bill = Bill.Bill()
		return bill.dis_bill()
		
	def show_history(self):
		conn = sqlite3.connect(DATABASE)
		cli_id = session['id']
		cursor = conn.execute('select * from CALLS where ID_CLIENT=?',[cli_id])
		history = [dict(minute=row[1], sms=row[2], mb=row[3]) for row in cursor.fetchall()]
		conn.close()
		welc = session['username']
		return render_template('clientpl.html',history=history,welc=welc)
		
	def pay_bill(self):
		'''
		welcome_user = session['username']
		conn = sqlite3.connect(DATABASE)
		cli_id = session['id']
		cur = conn.execute('select CHARGE from BILLS where ID_CLIENT=?',[cli_id])
		for row in cur:
			charge = row[0]
			break
		ypoloipo = charge - money
		if ypoloipo < 0:
			ypoloipo = abs(ypoloipo)#ta resta tou
			resta = "Ta resta sou einai " + str(ypoloipo) + " euro."
			ypoloipo = 0 #gia tin db
		elif ypoloipo > 0:
			resta = "Ypoloipontai " + str(ypoloipo) + " euro."
		else:
			resta = ""
		conn.execute('update BILLS set CHARGE=? where ID_CLIENT=?',[ypoloipo,cli_id])
		conn.commit()
		conn.close()
		done = "I plirwmi egine me epitixia!" + resta
		return render_template('for_client.html',message=done,welc=welcome_user)
		'''
		welcome_user = session['username']
		conn = sqlite3.connect(DATABASE)
		cli_id = session['id']
		conn.execute('update BILLS set CHARGE=? where ID_CLIENT=?',[0,cli_id])
		conn.commit()
		conn.close()
		MSG = "Your bills succesfully payed!"
		return render_template('clientpl.html',MSG=MSG,welc=welcome_user)
		
		
