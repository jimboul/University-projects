using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.IO;


namespace student_platofrm
{
    public partial class Form2 : Form
    {
        string un;
        public string name;
        public string surname;
        public string student_id;
        public string email;
        public string team;
        private int p;//tab pages count

        DBConnect mydb = new DBConnect();

        public Form2(Form1 form,string username)
        {
            InitializeComponent();
            un = username;
            AutoScaleMode = AutoScaleMode.Dpi;
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            //Get user's info 
            mydb.idstudent(this, un);
            // MessageBox.Show(name+ " "+surname+" "+ student_id+" "+ email+" "+team);
            label1.Text = "Welcome, " + name +" "+ surname;

            //   axAcroPDF1.LoadFile(Application.StartupPath + "\\Project1.pdf");
            //     axAcroPDF1.setView("Fit");
            //   axAcroPDF1.setShowToolbar(true);

            mydb.getSelectedCourses(menuStrip2, student_id);
            List<string> courses_list = mydb.getAllCourses();
            for (int i = 0; i < courses_list.Count; i++)
            {
                string title = courses_list[i];

                ToolStripMenuItem item = new ToolStripMenuItem();
                item.Text = title;
                //item.MouseEnter += new EventHandler(item_MouseEnter);
                // item.MouseLeave += new EventHandler(item_MouseLeave);
                // item.Click += new EventHandler(item_Click);

                ToolStripMenuItem sub_item = new ToolStripMenuItem();
                sub_item.Text = "Add this course";
                //lambda expression
                sub_item.Click += (s, ex) => { mydb.AddCourse(item.Text, student_id); mydb.getSelectedCourses(menuStrip2, student_id); };
                item.DropDownItems.Add(sub_item);
                menuStrip1.Items.Add(item);
            }
            mydb.course_label = label2;
            mydb.listView1 = listView1;
            mydb.listView2 = listView2;
            mydb.grade_label = label6;
            mydb.tabctrl = tabControl1;
            tabControl1.Enabled = false;

            tabControl2.SelectedTab = tabControl2.TabPages[1];
        }

        private void Form2_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }

        private void Form2_FormClosing(object sender, FormClosingEventArgs e)
        {
            Application.Exit();
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {

            Application.Restart(); 
            
        }


        private void listView1_DoubleClick(object sender, EventArgs e)
        {
            TabPage tab = new TabPage();
            tab.Text = listView1.SelectedItems[0].Text;

            // Project title label
            Label lbl = new Label();
            lbl.Size = new Size(150,18);
            lbl.Location = new Point(333, 3);
            lbl.Text = listView1.SelectedItems[0].Text;
            lbl.Font = new Font("Arial", 10, FontStyle.Bold);

            Panel pnl = new Panel();
            pnl.Location = new Point(6,24);
            pnl.Size = new Size(375,306);
            pnl.BackColor = Color.White;

            //AxAcroPDFLib.AxAcroPDF pdf = new AxAcroPDFLib.AxAcroPDF();
            //((System.ComponentModel.ISupportInitialize)(pdf)).BeginInit();
            // pdf.Location = new Point(0,0);
            // pdf.Size = new Size(374, 305);
            WebBrowser webb = new WebBrowser();
            webb.Location = new Point(0, 0);
            webb.Size = new Size(374, 305);
           
            // pnl.Controls.Add(pdf);
            pnl.Controls.Add(webb);
            //((System.ComponentModel.ISupportInitialize)(pdf)).EndInit();
            using (WebClient client = new WebClient())
            {
                client.Credentials = new NetworkCredential("Project", "123456");
                client.DownloadFile(mydb.project_file(listView1.SelectedItems[0].Text, mydb.selected_course_student), Application.StartupPath + "\\"+ listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student+".pdf");
                webb.Navigate("file:///"+Application.StartupPath + "\\" + listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student + ".pdf");
            }
            // pdf.LoadFile(Application.StartupPath +"\\" + listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student + ".pdf");
           
            List<string> list1 = mydb.getProjectInfo(listView1.SelectedItems[0].Text, mydb.selected_course_student);

            Label scale_lbl = new Label();
            scale_lbl.Location = new Point(396,90);
            scale_lbl.Size = new Size(80,16);
            scale_lbl.Text = "Scale: " + list1[0];
            scale_lbl.Font = new Font("Arial", 10, FontStyle.Regular);

            Label deadline_lbl = new Label();
            deadline_lbl.Location = new Point(484, 90);
            deadline_lbl.Size = new Size(210, 16);
            deadline_lbl.Text = "Deadline: " + list1[3];
            deadline_lbl.Font = new Font("Arial", 10, FontStyle.Regular);

            Label Project_info_lbl = new Label();
            Project_info_lbl.Location = new Point(463,118);
            Project_info_lbl.AutoSize = false;
            Project_info_lbl.Size = new Size(250, 20);
            Project_info_lbl.Text = "Project " + "information";
          Project_info_lbl.Font = new Font("Arial", 10, FontStyle.Bold);

            Button submit_teams_btn = new Button();
            submit_teams_btn.Location = new Point(550,20);
            submit_teams_btn.Size = new Size(109,39);
            submit_teams_btn.Text = "Team and project manager";
            //lambda expression
            submit_teams_btn.Click += (s, ex) => { Teams_form teams_form = new Teams_form(mydb.selected_course_student, listView1.SelectedItems[0].Text,student_id); teams_form.Show(); teams_form.team = team; };


            Button download_btn = new Button();
            download_btn.Location = new Point(399, 20);
            download_btn.Size = new Size(109, 39);
            download_btn.Text = "Download project file";
            //lambda expression
            download_btn.Click += (s, ex) => { if (folderBrowserDialog1.ShowDialog() == DialogResult.OK)
                {
                    File.Copy(Application.StartupPath + "\\" + listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student + ".pdf", folderBrowserDialog1.SelectedPath + "\\" + listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student + ".pdf", true);
                    MessageBox.Show("The project file has been downloaded and has been saved to: " + folderBrowserDialog1.SelectedPath + "\\" + listView1.SelectedItems[0].Text + "_" + mydb.selected_course_student + ".pdf", "Message");
                }
                                            };

                RichTextBox rich = new RichTextBox();
            rich.Location = new Point(390,148);
            rich.Size = new Size(285,183);
            rich.Text = list1[4];
            rich.ReadOnly = true;

            Control[] con = {pnl,lbl,scale_lbl,deadline_lbl,Project_info_lbl, submit_teams_btn, download_btn,rich };
            tab.Controls.AddRange(con);
            tabControl1.TabPages.Add(tab);
            tabControl1.SelectedTab = tab;
        }

        private void tabControl1_MouseUp(object sender, MouseEventArgs e)
        {
            if (tabControl1.TabCount > 2)
            {
                // check if the right mouse button was pressed
                if (e.Button == MouseButtons.Right)
                {
                    // iterate through all the tab pages
                    for (p = 2; p < tabControl1.TabCount; p++)
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

        private void contextMenuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {
            tabControl1.TabPages.RemoveAt(p);
            tabControl1.SelectedTab = tabControl1.TabPages[p - 1];
        }

       
    }
}
