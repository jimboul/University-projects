using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Compression;
using System.IO;
using System.Net;

namespace student_platofrm
{
    public partial class Teams_form : Form
    {
        string un;
        public string name;
        public string surname;
        public string student_id;
        public string email;
        public string team;
        public string project;
        public string course;
        private int min = -1;
        private int max = -1;

        DBConnect mydb = new DBConnect();

        public Teams_form(string _course, string _project,string s_id)
        {
            course = _course;
            project = _project;
            student_id = s_id;
            InitializeComponent();
            AutoScaleMode = AutoScaleMode.Dpi;
        }


        private void myTeamToolStripMenuItem_Click(object sender, EventArgs e)
        {
            label3.Visible = false;
            label4.Visible = false;
            button1.Visible = false;
            button2.Visible = false;
            button3.Visible = false;
            textBox1.Visible = false;
            listView1.Visible = true;
            textBox2.Visible = false;
            label5.Visible = false;
            button4.Visible = false;
            button5.Visible = false;
            button6.Visible = false;
            textBox3.Visible = false;
            label6.Visible = false;

            listView1.Items.Clear();
            team = mydb.getTeam(project, course, student_id);
            List<string> list1= mydb.getTeamCount(project, team, course);  
            for(int i=0;i<list1.Count;i++)
            {
                ListViewItem item = new ListViewItem();
                item.Text = list1[i].ToString();
                listView1.Items.Add(item);        
            }
        }

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void Teams_form_Load(object sender, EventArgs e)
        {
            team = mydb.getTeam(project, course, student_id);
            listView1.Items.Clear();
            List<string> list1 = mydb.getTeamCount(project, team, course);
            for (int i = 0; i < list1.Count; i++)
            {
                ListViewItem item = new ListViewItem();
                item.Text = list1[i].ToString();
                listView1.Items.Add(item);
            }
            button1.Visible = false;

            if (listView1.Items.Count > 0)
            {
                createNewTeamToolStripMenuItem.Enabled = false;
                closeToolStripMenuItem.Enabled = true;
            }
        }

        private void createNewTeamToolStripMenuItem_Click(object sender, EventArgs e)
        {
            min = Int32.Parse(mydb.getMinMax(project, course).Split(' ')[0]);
            max = Int32.Parse(mydb.getMinMax(project, course).Split(' ')[1]);
            label4.Text = "(min: "+min+" max: "+max+" persons)";
            label3.Visible = true;
            label4.Visible = true;
            button1.Visible = true;
            button2.Visible = true;
            button3.Visible = true;
            textBox1.Visible = true;
            listView1.Visible = true;
            textBox2.Visible = false;
            label5.Visible = false;
            button4.Visible = false;
            button5.Visible = false;
            button6.Visible = false;
            textBox3.Visible = false;
            label6.Visible = false;
        }

        private void closeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ListViewItem item = new ListViewItem();
            item.Text = mydb.getUserById(textBox1.Text);
            if (item.Text == "")
                MessageBox.Show("Please insert a valid student id. (format: p11111)", "Error");
            else if (listView1.Items.Count == max)
                MessageBox.Show("The maximum allowed people in a team for this project are " + max + ". You can not exceed this number.", "Error");
            else {
                listView1.Items.Add(item);
                textBox1.Text = "";
                 }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (listView1.SelectedItems.Count > 0)
                listView1.Items.Remove(listView1.SelectedItems[0]);
            else
                MessageBox.Show("Please choose a member from the list to remove.", "Error");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            bool condition = true;
            if (listView1.Items.Count >=min)
            {

                for (int i = 0; i < listView1.Items.Count; i++)
                {
                    if (!mydb.check_member(project, course, listView1.Items[i].Text.Split(' ')[2]))
                    {
                        MessageBox.Show(listView1.Items[i].Text.Split(' ')[0] + " " + listView1.Items[i].Text.Split(' ')[1] + " with student id: " + listView1.Items[i].Text.Split(' ')[2] + " has already been registered in a team. Team creation aborted and the student has been removed from the list.");
                        condition = false;
                        listView1.Items.RemoveAt(i);
                        textBox1.Text = "";
                        break;
                    }
                }

                if (condition)
                {
                    int max = Int32.Parse(mydb.maxTeam(course, project));
                    //MessageBox.Show(max.ToString());
                    int tnumber = max + 1;
                    //MessageBox.Show(tnumber.ToString());
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        mydb.add_member(project, course, listView1.Items[i].Text.Split(' ')[2], tnumber);
                    }
                    myTeamToolStripMenuItem.PerformClick();
                    closeToolStripMenuItem.Enabled = true;
                    createNewTeamToolStripMenuItem.Enabled = false;
                    MessageBox.Show("Your team was successfully created! For any changes please contact the professor.", "Message");
                }
            }
            else
            MessageBox.Show("The minimum allowed people in a team for this project are " + min + ".", "Error");
        }

        private void projectToolStripMenuItem_Click(object sender, EventArgs e)
        {
            label3.Visible = false;
            label4.Visible = false;
            button1.Visible = false;
            button2.Visible = false;
            button3.Visible = false;
            textBox1.Visible = false;
            listView1.Visible = false;
            textBox2.Visible = true;
            label5.Visible = true;
            button4.Visible = true;
            button5.Visible = true;
            button6.Visible = true;
            textBox3.Visible = true;
            label6.Visible = true;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            openFileDialog1.Filter= "Zip Files|*.zip";
            if (openFileDialog1.ShowDialog()==DialogResult.OK)
            {
                textBox2.Text = openFileDialog1.FileName;
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if(folderBrowserDialog1.ShowDialog()==DialogResult.OK)
            {
                string startPath = folderBrowserDialog1.SelectedPath;
                string zipPath = Application.StartupPath+ "\\result.zip";
                textBox2.Text = zipPath;
                if (File.Exists(Application.StartupPath + "\\result.zip"))
                    File.Delete(Application.StartupPath + "\\result.zip");
                ZipFile.CreateFromDirectory(startPath, zipPath);

                
               
               
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            using (WebClient client = new WebClient())
            {
               client.Credentials = new NetworkCredential("Project", "123456");
                 client.UploadFile("ftp://ortyki.dlinkddns.com/student_platform/" + project+"_"+course+"_team_"+team + ".zip", "STOR",textBox2.Text);
               // client.UploadFile("ftp://192.168.1.12/student_platform/" + project+"_"+course+"_team_"+team + ".zip", "STOR", textBox2.Text);
                
                mydb.submitProject(course, project, team, "ftp://ortyki.dlinkddns.com/student_platform/" + project + "_" + course + "_team_" + team + ".zip", textBox3.Text);
            }
        }
    }
}
