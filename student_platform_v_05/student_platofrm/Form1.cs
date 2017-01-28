using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Cryptography;

namespace student_platofrm
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            AutoScaleMode = AutoScaleMode.Dpi;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Cursor = Cursors.WaitCursor;
            if (!verifyUser())
                MessageBox.Show("Unable to connect. Invalid username and/or password. \n Please try again! ", "Error!");
            else
            {
                DBConnect mydb = new DBConnect();
                string username = textBox1.Text;

                string role = mydb.checkRole(username);

                switch(role)
                {
                    case "student":
                        Form2 form2 = new Form2(this,username);
                       
                        form2.Show();
                        this.Hide();
                        break;
                    case "professor":
                        Form3 form3 = new Form3(username);
                        form3.Show();
                        this.Hide();
                        break;
                    case "admin":
                        admin admin = new admin(username);
                        admin.Show();
                        this.Hide();
                        break;
                }
            }


            this.Cursor = Cursors.Default;
         }


        private bool verifyUser()
        {
            DBConnect mydb = new DBConnect();
            string username = textBox1.Text;
            string password = textBox2.Text;



            using (MD5 md5Hash = MD5.Create())
            {
                string source = password;
                string hash = GetMd5Hash(md5Hash, source);

                if (mydb.checkUsername(username, hash))
                    return true;
                else
                    return false;
               // if (VerifyMd5Hash(md5Hash, source, hash))
              //  {
              //      return true;
             //   }
             //   else
             //   {
             //       Console.WriteLine("The hashes are not same.");
             //       return false;
             //   }
            }
        }








        static string GetMd5Hash(MD5 md5Hash, string input)
        {

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }
        static bool VerifyMd5Hash(MD5 md5Hash, string input, string hash)
        {
            // Hash the input.
            string hashOfInput = GetMd5Hash(md5Hash, input);

            // Create a StringComparer an compare the hashes.
            StringComparer comparer = StringComparer.OrdinalIgnoreCase;

            if (0 == comparer.Compare(hashOfInput, hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

   

        private void Form1_Load_1(object sender, EventArgs e)
        {
            AdobeChecker adobe = new AdobeChecker();
            adobe.checkExistence();
        }
    }
}
