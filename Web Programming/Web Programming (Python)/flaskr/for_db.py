import sqlite3
from passlib.hash import pbkdf2_sha256

#kwdikoi gia users
code1 = pbkdf2_sha256.encrypt("pass",rounds=20000,salt_size=16)
code2 = pbkdf2_sha256.encrypt("12345",rounds=20000,salt_size=16)
code3 = pbkdf2_sha256.encrypt("dim",rounds=20000,salt_size=16)
code4 = pbkdf2_sha256.encrypt("dwr",rounds=20000,salt_size=16)

path = '/root/sxoli/java2/PythonBasics/final/flaskr/db/flask_db.db'


conn = sqlite3.connect(path)
#dimiourgia users
conn.execute('insert into ADMINS(ID,USERNAME,PASSWORD,LAST_NAME,FIRST_NAME) VALUES(?,?,?,?,?)',[1,'fikos',code1,'kazepis','orfeas'])
conn.execute('insert into SELLERS(ID,USERNAME,PASSWORD,LAST_NAME,FIRST_NAME) VALUES(?,?,?,?,?)',[1,'antwnis',code2,'pavlidis','antwnis'])
conn.execute('insert into CLIENTS(ID,USERNAME,PASSWORD,LAST_NAME,FIRST_NAME,EMAIL,ADDRESS,CITY,POSTCODE,AFM) VALUES(?,?,?,?,?,?,?,?,?,?)',[1,'dimitris',code3,'dimitris','mpouloutas','mpoulou@gmail.com','area 51','Nea Smirni',12345,123456789])
conn.execute('insert into CLIENTS(ID,USERNAME,PASSWORD,LAST_NAME,FIRST_NAME,EMAIL,ADDRESS,CITY,POSTCODE,AFM) VALUES(?,?,?,?,?,?,?,?,?,?)',[2,'dwra',code4,'theodwra','peppa','pep@hotmail.com','eksetastiki 16','Petroupoli',98765,987654321])

#3 programs
conn.execute('insert into PROGRAMS(PROG_NAME,MINUTES,SMS,MB,EURO) VALUES(?,?,?,?,?)',["ALL_600",600,600,600,8])
conn.execute('insert into PROGRAMS(PROG_NAME,MINUTES,SMS,MB,EURO) VALUES(?,?,?,?,?)',["ALL_200",200,200,200,3])
conn.execute('insert into PROGRAMS(PROG_NAME,MINUTES,SMS,MB,EURO) VALUES(?,?,?,?,?)',["1000MIN+200SMS",1000,200,0,4])

#gia ton client
conn.execute('insert into NUMBERS(ID_CLIENT,NUMBER) VALUES(?,?)',[1,6999999999])
conn.execute('insert into NUMBERS(ID_CLIENT,NUMBER) VALUES(?,?)',[2,6900000000])
conn.execute('insert into CALLS(ID_CLIENT,MIN,SMS,MB) values(?,?,?,?)',[1,403,54,2004])
conn.execute('insert into CALLS(ID_CLIENT,MIN,SMS,MB) values(?,?,?,?)',[2,40,5,200])
conn.execute('insert into IDP(ID_CLIENT,PROG_NAME) values(?,?)',[1,"ALL_600"])
conn.execute('insert into IDP(ID_CLIENT,PROG_NAME) values(?,?)',[2,"1000MIN+200SMS"])
conn.execute('insert into BILLS(ID_CLIENT,CHARGE) values(?,?)',[1,14])
conn.execute('insert into BILLS(ID_CLIENT,CHARGE) values(?,?)',[2,6])
conn.commit()
conn.close()
