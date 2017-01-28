using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.IO;



namespace student_platofrm
{
    public partial class Form3 : Form
    {
        string un;//username
        public string name;
        public string surname;
        public string id;
        private int p;//tab pages count
        public string email;
        private string selected_course;
        string course;
        private string current_project;
        DBConnect mydb = new DBConnect();
        RichTextBox rich2 = new RichTextBox();

        public Form3(string username)
        {
            AutoScaleMode = AutoScaleMode.Dpi;
            InitializeComponent();
            un = username;
        }

        private void Form3_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        void item_MouseEnter(object sender, EventArgs e)
        {
            this.Cursor = Cursors.Hand;
        }

        void item_MouseLeave(object sender, EventArgs e)
        {
            this.Cursor = Cursors.Default;
        }

        void item_Click(object sender, EventArgs e)
        {
            tabControl1.Enabled = true;
             ToolStripMenuItem clickedMenuItem = sender as ToolStripMenuItem; 
            course = clickedMenuItem.Text;
            label2.Text = "Project manager for "+course;
            selected_course = course;
            listView1.Items.Clear();
            listView2.Items.Clear();
            mydb.getPendingProjects(selected_course, listView1);
            mydb.getExpiredProjects(selected_course, listView2);
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            openFileDialog1.InitialDirectory= Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            tabControl1.Enabled = false;
            //Get user's info 
            mydb.idprofessor(this, un);

            List<string> courses_list = mydb.profCourses(id);
            for (int i=0;i<courses_list.Count;i++)
            {
                string title=courses_list[i].Split(',')[0];
              
                ToolStripMenuItem item = new ToolStripMenuItem();
                item.Text = title;
                item.MouseEnter += new EventHandler(item_MouseEnter);
                item.MouseLeave += new EventHandler(item_MouseLeave);
                item.Click += new EventHandler(item_Click);
                menuStrip1.Items.Add(item);
            }


            
            // MessageBox.Show(name+ " "+surname+" "+ student_id+" "+ email+" "+team);
            label1.Text = "Welcome, " + name + " " + surname;
            
            rich2.Location = new Point(342, 63);
            rich2.Size = new Size(184, 194);
            rich2.Visible=false;
            tabPage1.Controls.Add(rich2);

            openFileDialog1.Filter = "PDF Files (*.pdf)|*.pdf";

            
                  
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Application.Restart();
        }

        

        private void button2_Click(object sender, EventArgs e)
        {
            if(openFileDialog1.ShowDialog()==DialogResult.OK)
            {
                textBox2.Text = openFileDialog1.FileName;
               
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            using (WebClient client = new WebClient())
                {
                    client.Credentials = new NetworkCredential("Project", "123456");
                  client.UploadFile("ftp://ortyki.dlinkddns.com/student_platform/"+textBox1.Text.Replace(' ','_')+".pdf", "STOR",textBox2.Text);
                  //  client.UploadFile("ftp://192.168.1.12/student_platform/" + textBox1.Text.Replace(' ', '_') + ".pdf", "STOR", textBox2.Text);
                }
            List<List<string>> list = mydb.getStudentNameAndMails(selected_course);
            List<string> mails = list[1];
            List<string> names = list[0];
             mydb.AddProject(selected_course, textBox1.Text, numericUpDown1.Value, "ftp://ortyki.dlinkddns.com/student_platform/" + textBox1.Text.Replace(' ', '_') + ".pdf", dateTimePicker1.Value, richTextBox1.Text,Decimal.ToInt32( numericUpDown2.Value), Decimal.ToInt32(numericUpDown3.Value));
            string subject = "New project was added";
            
            string body= "Hello, " + "name" + "\n \n A new project has been added to the student platform. \n \n Project title: " + textBox1.Text + "\n Deadline: " + dateTimePicker1.Value.ToString() + "\n \n Sincerely, \n" + name + " " + surname; 
           
                sendMailtoAll(mails, names,body,subject);
            MessageBox.Show(textBox1.Text+" was successfuly submitted! \n An email has been sent to all the subscribed students.");
            clearValues();
        }

        private void listView1_DoubleClick(object sender, EventArgs e)
        {
            TabPage tab = new TabPage();
            List<string> info_list= mydb.getProjectInfo(listView1.SelectedItems[0].Text, selected_course);
            string project_id = info_list[5].ToString();

            Label lbl = new Label();
            lbl.Location = label3.Location;
            lbl.Size = label3.Size;
            lbl.Text = label3.Text;

            Label lbl2 = new Label();
            lbl2.Location = label4.Location;
            lbl2.Size = label4.Size;
            lbl2.Text = label4.Text;

            Label lbl3 = new Label();
            lbl3.Location = label5.Location;
            lbl3.Size = label5.Size;
            lbl3.Text = label5.Text;

            Label lbl4 = new Label();
            lbl4.Location = label6.Location;
            lbl4.Size = label6.Size;
            lbl4.Text = label6.Text;

            Label lbl5 = new Label();
            lbl5.Location = label8.Location;
            lbl5.Size = label8.Size;
            lbl5.Text = label8.Text;

            TextBox txt = new TextBox();
            txt.Size = textBox1.Size;
            txt.Location = textBox1.Location;
            txt.Text = info_list[1].ToString();

            TextBox txt2 = new TextBox();
            txt2.Size = textBox2.Size;
            txt2.Location = textBox2.Location;
            txt2.BackColor = textBox2.BackColor;
            txt2.Text = info_list[2].ToString();

            DateTimePicker dtp = new DateTimePicker();
            dtp.Size = dateTimePicker1.Size;
            dtp.Location = dateTimePicker1.Location;
            dtp.Value = Convert.ToDateTime(info_list[3]);

            NumericUpDown num = new NumericUpDown();
            num.Size = numericUpDown1.Size;
            num.Location = numericUpDown1.Location;
            num.Minimum = numericUpDown1.Minimum;
            num.Maximum = numericUpDown1.Maximum;
            num.Increment = numericUpDown1.Increment;
            num.DecimalPlaces = numericUpDown1.DecimalPlaces;
            num.Value = decimal.Parse( info_list[0]);

            RichTextBox rt = new RichTextBox();
            rt.Size = richTextBox1.Size;
            rt.Location = richTextBox1.Location;
            rt.Text = info_list[4].ToString();

            Button btn = new Button();
            btn.Location = button1.Location;
            btn.Size = button1.Size;
            btn.Text = "Edit";
            //lambda expression
            btn.Click += (s, ex) => { mydb.editProject(project_id, txt.Text, txt2.Text, dtp.Value, rt.Text, num.Value);
            List<List<string>> list = mydb.getStudentNameAndMails(selected_course);
            List<string> mails = list[1];
            List<string> names = list[0];
            string subject = txt.Text+" was edited";

            string body = "Hello, " + "name" + "\n \nProject with title: "+txt.Text+" in "+selected_course+" was edited." + "\n \nSincerely, \n" + name + " " + surname;

            sendMailtoAll(mails, names, body, subject);
            MessageBox.Show(txt.Text + " was successfuly edited! \n An email has been sent to all the subscribed students.");
            };

            Button btn2 = new Button();
            btn2.Location = button2.Location;
            btn2.Size = button2.Size;
            btn2.Text = button2.Text;
            btn2.Click += new EventHandler(button2_Click);

            Control [] con={lbl,lbl2,lbl3,lbl4,lbl5,txt,txt2,num,dtp,rt,btn,btn2};
            tab.Controls.AddRange(con);
            tab.Text = listView1.SelectedItems[0].Text;
            tab.ContextMenuStrip = contextMenuStrip1;
            tabControl1.TabPages.Add(tab);
            tabControl1.SelectedTab = tab;
        }


        private void tabControl1_MouseUp(object sender, MouseEventArgs e)
        {
            if (tabControl1.TabCount > 3)
            {
                // check if the right mouse button was pressed
                if (e.Button == MouseButtons.Right)
                {
                    // iterate through all the tab pages
                    for (p = 3; p < tabControl1.TabCount; p++)
                    {
                        // get their rectangle area and check if it contains the mouse cursor
                        Rectangle r = tabControl1.GetTabRect(p);
                        if (r.Contains(e.Location))
                        {
                            // show the context menu here
                            System.Diagnostics.Debug.WriteLine("TabPressed: " + p);
                            contextMenuStrip1.Show(MousePosition.X, MousePosition.Y);
                            break;
                          
                        }
                    }
                }
            }
        }

        private void toolStripMenuItem1_Click(object sender, EventArgs e)
        {
            tabControl1.TabPages.RemoveAt(p);
            tabControl1.SelectedTab = tabControl1.TabPages[p - 1];              
        }

        private void sendMailtoAll(List<string> sendTo, List<string> names,string body,string subject)
        {
            
            SmtpClient client = new SmtpClient();
            client.Port =587;
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.Credentials = new System.Net.NetworkCredential("studentplatformproject@gmail.com", "studentplatform123456");
            client.Host = "smtp.gmail.com";

            for (int i = 0; i < sendTo.Count; i++)
            {
                MailMessage mail = new MailMessage("studentplatformproject@gmail.com", sendTo[i].ToString());
                mail.Subject = subject;
               string namex = names[i].ToString();
                body=body.Replace("name", namex);
                mail.Body = body;
                client.Send(mail);
            }
        }

        private void clearValues()
        {
            textBox1.Clear();
            textBox2.Text = "No file uploaded..";
            rich2.Clear();
            richTextBox1.Clear();
            numericUpDown1.Value = Convert.ToDecimal(0.05);
            dateTimePicker1.Value = DateTime.Now;
        }

        private void listView2_DoubleClick(object sender, EventArgs e)
        {
            TabPage submitted_projects_tab = new TabPage();
            ListView submitted_projects_listview = new ListView();
           
           Control[] con ={submitted_projects_listview};
            submitted_projects_tab.Controls.AddRange(con);

            submitted_projects_listview.View = View.Details;
            submitted_projects_listview.Dock= System.Windows.Forms.DockStyle.Fill;
            submitted_projects_listview.Columns.Add("Team");
            submitted_projects_listview.Columns.Add("Date submitted");
            submitted_projects_listview.Columns[0].Width = 140;
            submitted_projects_listview.Columns[1].Width = 395;
            
            submitted_projects_listview.DoubleClick += (s, ex) => { submitted_projects_listview_DoubleClick(submitted_projects_listview.SelectedItems[0].Text); };

            mydb.getSubmittedProjects(course, listView2.SelectedItems[0].Text, submitted_projects_listview);

            submitted_projects_tab.Text = listView2.SelectedItems[0].Text+" - Submitted projects";
            current_project = listView2.SelectedItems[0].Text;
            submitted_projects_tab.ContextMenuStrip = contextMenuStrip1;       
            tabControl1.SelectedTab = submitted_projects_tab;
            tabControl1.TabPages.Add(submitted_projects_tab);
        }

        private void submitted_projects_listview_DoubleClick(string team)
        {
            TabPage Score_tab = new TabPage();

          List<string> team_members = mydb.getTeamCount(current_project,team,selected_course);

            Label team_lbl = new Label();
            team_lbl.Text = "Team";
            team_lbl.Location = new Point(86, 17);
            team_lbl.Size = new Size(43, 13);

            Label grade_lbl = new Label();
            grade_lbl.Text = "Grade";
            grade_lbl.Location = new Point(247, 17);
            grade_lbl.Size = new Size(36, 13);

            Label notes = new Label();
            notes.Text = "Notes";
            notes.Location = new Point(408, 98);
            notes.Size = new Size(35, 13);

            Button submit_grades = new Button();
            submit_grades.Text = "Submit grades";
            submit_grades.Location = new Point(129, 225);
            submit_grades.Size = new Size(108, 23);
            //lambda expression
            submit_grades.Click += (s, ex) => { try { foreach (Control txt in Score_tab.Controls) { if (txt is TextBox && txt.Tag != null) mydb.set_grade(current_project, selected_course, team, txt.Tag.ToString().Split(' ')[2], Decimal.Parse(txt.Text)); } MessageBox.Show("Grades were successfuly submitted.", "Message"); } catch (Exception ex1) { MessageBox.Show(ex1.Message, "Error"); } };

            Button download_file = new Button();
            download_file.Text = "Download project file";
            download_file.Location = new Point(355, 43);
            download_file.Size = new Size(147, 23);
            download_file.Click += (s, ex) => {
                string path= mydb.download_file(current_project, selected_course, team);
                using (WebClient client = new WebClient())
                {
                    client.Credentials = new NetworkCredential("Project", "123456");
                    client.DownloadFile(path, Environment.GetFolderPath(Environment.SpecialFolder.Desktop) + "\\" + current_project + "_" + course + "_team_" + team + ".zip");
                   
                }

            };

            RichTextBox rich_notes = new RichTextBox();
            rich_notes.ReadOnly = true;
            rich_notes.Location = new Point(355, 124);
            rich_notes.Size = new Size(147, 124);


            Control[] con = { team_lbl, grade_lbl, submit_grades , download_file, notes , rich_notes };
            for (int i=0;i<team_members.Count;i++)
            {
                TextBox txt = new TextBox();
                txt.Location = new Point(19, 46+(i*26));
                txt.Size = new Size(198,20);
                txt.ReadOnly = true;
                txt.Text = team_members[i];

                TextBox grades = new TextBox();
                grades.Location = new Point(250, 46 + (i * 26));
                grades.Size = new Size(30, 20);
                grades.Tag = txt.Text;
                Score_tab.Controls.Add(txt);
                Score_tab.Controls.Add(grades);
                if (mydb.check_s_grade(selected_course, current_project, team_members[i].Split(' ')[2]) != "")
                    grades.Text = mydb.check_s_grade(selected_course, current_project, team_members[i].Split(' ')[2]);


            }
           
            Score_tab.Controls.AddRange(con);
            Score_tab.Text = "Team "+team;
            Score_tab.ContextMenuStrip = contextMenuStrip1;
            tabControl1.TabPages.Add(Score_tab);
            tabControl1.SelectedTab = Score_tab;
        }
      
    }
}
