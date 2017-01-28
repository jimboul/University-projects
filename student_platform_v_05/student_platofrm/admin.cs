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
    public partial class admin : Form
    {
        DBConnect mydb = new DBConnect();
        private string un;
        public admin(string username)
        {
            un = username;
            InitializeComponent();
            AutoScaleMode = AutoScaleMode.Dpi;

        }

        private void admin_Load(object sender, EventArgs e)
        {
            label15.Text = "Welocme, "+un;
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Application.Restart();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (MD5 md5Hash = MD5.Create())
            {
                string source = textBox6.Text;
                string hash = GetMd5Hash(md5Hash, source);
        
            

            if(radioButton1.Checked)
                mydb.addUser(textBox1.Text, textBox2.Text, textBox5.Text, hash, textBox3.Text, textBox4.Text, "1");
            else
                mydb.addUser(textBox1.Text, textBox2.Text, textBox5.Text, hash, textBox3.Text, textBox4.Text, "3");
            }

            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (radioButton4.Checked)
                mydb.deleteUser("1", textBox7.Text);
            else
                mydb.deleteUser("3", textBox7.Text);

            textBox7.Clear();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (textBox13.Text != null && textBox14.Text != null)
                mydb.addCourseProf(textBox14.Text, textBox13.Text);
            else
                MessageBox.Show("Please fill the Course name and Professor ID fields.");

            textBox13.Clear();
            textBox14.Clear();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (textBox8.Text != null && (textBox9.Text == null && textBox10.Text == null))
                mydb.deleteCourseByID(textBox8.Text);

            else if (textBox8.Text == null && (textBox9.Text != null && textBox10.Text != null))
                mydb.deleteCourseByNameAndID(textBox9.Text, textBox10.Text);
            else
                MessageBox.Show("If you wish to delete a course please fill the id of this course or both the title of this course and the professor id.");

            textBox8.Clear();
            textBox9.Clear();
            textBox10.Clear();

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
    }


}


