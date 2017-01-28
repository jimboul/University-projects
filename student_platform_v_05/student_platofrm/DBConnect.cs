using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Windows.Forms;

namespace student_platofrm
{
    class DBConnect
    {
        private MySqlConnection connection;
        private string server;
        private string database;
        private string uid;
        private string password;
        public Label course_label;
        public ListView listView1;
        public ListView listView2;
        public Label grade_label;
        public TabControl tabctrl;
        public string selected_course_student;
        //Constructor
        public DBConnect()
        {
            Initialize();
        }

        //Initialize values
        private void Initialize()
        {
          server = "ortyki.dlinkddns.com";
       //  server = "192.168.1.12";
            database = "student_platform";
            uid = "root";
            password = "1234";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "DATABASE=" +
            database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            connection = new MySqlConnection(connectionString);
        }

        //open connection to database
        private bool OpenConnection()
        {
            try
            {
                connection.Open();
                return true;
            }
            catch (MySqlException ex)
            {
                //When handling errors, you can your application's response based 
                //on the error number.
                //The two most common error numbers when connecting are as follows:
                //0: Cannot connect to server.
                //1045: Invalid user name and/or password.
                switch (ex.Number)
                {
                    case 0:
                        MessageBox.Show("Cannot connect to server.  Contact administrator");
                        break;

                    case 1045:
                        MessageBox.Show("Invalid username/password, please try again");
                        break;
                }
                return false;
            }
        }

        //Close connection
        private bool CloseConnection()
        {
            try
            {
                connection.Close();
                return true;
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.Message);
                return false;
            }
        }

        //Insert statement
        public void Insert()
        {
            string query = "INSERT INTO tableinfo (name, age) VALUES('John Smith', '33')";

            //open connection
            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
            }
        }
        public void addUser(string name,string surname, string username,string password,string id, string email,string role)
        {
            string query_student = "INSERT INTO users (first_name,surname,student_id,email,username,password,role_id) VALUES('" + name + "','" + surname + "','" + id + "','" + email + "','" + username + "','" + password + "','" + role + "')";
            string query_prof = "INSERT INTO users (first_name,surname,prof_id,email,username,password,role_id) VALUES('" + name + "','" + surname + "','" + id + "','" + email + "','" + username + "','" + password + "','" + role + "')";
            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query_student, connection);

                if(role=="1")
                    cmd = new MySqlCommand(query_student, connection);
                else if (role == "3")
                    cmd = new MySqlCommand(query_prof, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
                MessageBox.Show("User was added!");
            }
        }

        public void addCourseProf(string course_name, string prof_id)
        {
            string query = "INSERT INTO courses (prof_id,title) VALUES('" + prof_id + "','" + course_name + "')";
           
            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                 

              MySqlCommand  cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
                MessageBox.Show("Course was added!");

            }
        }

        public void submitProject(string course,string project,string team,string path,string notes)
        {
            string query = "INSERT INTO submitted_projects (course,project_title,team,path,notes,date) VALUES('" + course + "','" + project + "','" + team + "','" + path + "','" + notes + "','" + DateTime.Now.ToString("yyyy-MM-dd H:mm:ss")  + "')";

            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
                MessageBox.Show("Your project was submitted! Good luck!");
            }
        }

        public void AddProject(string course,string title,decimal scale,string path,DateTime deadline,string info,int min, int max)
        {
            string query = "INSERT INTO projects (course,scale,title,file_path,deadline,info,team_members_min,team_members_max) VALUES('" + course + "','" + scale + "','" + title + "','" + path + "','" + deadline.ToString("yyyy-MM-dd H:mm:ss") + "','" + info +"','"+min+"','"+max+"')";

            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
            }
        }

        public void AddCourse(string course, string s_id)
        {
            string query = "INSERT INTO selected_courses (course, student_id) "+
            "SELECT * FROM (SELECT '"+course+"', '"+s_id+"') AS tmp "+
            "WHERE NOT EXISTS ( SELECT * FROM selected_courses WHERE course = '" + course + "' and student_id='" + s_id + "') " +
            "  LIMIT 1; ";

            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
            }
        }
        public string maxTeam(string course,string project)
        {
            string query = "SELECT MAX(team) AS maxt FROM student_platform.teams WHERE course='"+course+"' and project='"+project+"'";
            string max = "1";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();
                if (dataReader.HasRows)
                {
                    while (dataReader.Read())
                    {
                        max = dataReader["maxt"].ToString();
                    }
                    //close Data Reader
                    dataReader.Close();

                    //close Connection
                    this.CloseConnection();
                }

              
            }
            return max;
        }

        public bool check_member(string project, string course, string s_id)
        {
            bool condition = true;
            string query = "SELECT * FROM student_platform.teams WHERE student_id='" + s_id + "' and course='" + course + "' and project='" + project + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    condition = false;
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return condition;
        }

        public void add_member(string project, string course, string s_id,int tnumber)
        {
            
            string query = "INSERT INTO teams (student_id,course,project,team) VALUES('" + s_id + "','" + course + "','" + project + "','" + tnumber.ToString()  + "')";

            if (this.OpenConnection() == true)
            {
                //create command and assign the query and connection from the constructor
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //Execute command
                cmd.ExecuteNonQuery();

                //close connection
                this.CloseConnection();
            }


        }

        public string getUserById(string s_id)
        {
            string info="";
            string query = "SELECT first_name,surname,student_id FROM users WHERE student_id = '" + s_id + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    info = dataReader["first_name"].ToString() + " " + dataReader["surname"].ToString() + " " + dataReader["student_id"].ToString();
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return info;
        }

        public string getMinMax(string project,string course)
        {
            string min_max = "";
            string query = "SELECT team_members_min,team_members_max FROM projects WHERE title = '" + project + "' and course = '" + course + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    min_max = dataReader["team_members_min"].ToString() + " " + dataReader["team_members_max"].ToString();
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return min_max;
        }

        public void deleteCourseByNameAndID(string prof_id, string title)
        {
            string query = "DELETE FROM courses WHERE prof_id='" + prof_id +"' and title='"+title+ "'";

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
        }


        public void deleteCourseByID(string id)
        {
            string query = "DELETE FROM courses WHERE courses_id='" + id + "'";

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
        }

        public void deleteCourse(string course,string s_id)
        {
            string query = "DELETE FROM selected_courses WHERE course='"+course+"' and student_id='"+s_id+"'";

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
        }

        public void deleteUser(string role,string id)
        {
            string query_student = "DELETE FROM users WHERE student_id='" + id + "'";
            string query_prof = "DELETE FROM users WHERE prof_id='" + id + "'";

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query_student, connection);

                if(role=="1")
                cmd = new MySqlCommand(query_student, connection);
                else if (role == "3")
                cmd = new MySqlCommand(query_prof, connection);

                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
        }

        public void getSelectedCourses(MenuStrip ms,string s_id)
        {
            string query = "SELECT course FROM student_platform.selected_courses WHERE student_id='" + s_id + "'";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();
                ms.Items.Clear();
                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    ToolStripMenuItem item = new ToolStripMenuItem();
                    item.Text = dataReader["course"].ToString();
                    ToolStripMenuItem sub_item = new ToolStripMenuItem();
                    sub_item.Text = "Remove course";
                    //lambda expression
                    sub_item.Click += (s, ex) => { deleteCourse(item.Text, s_id); ms.Items.Remove(item);  };
                    

                    ToolStripMenuItem sub_item2 = new ToolStripMenuItem();
                    sub_item2.Text = "View projects";
                    //lambda expression
                    sub_item2.Click += (s, ex) => {
                        tabctrl.Enabled = true;
                        listView1.Items.Clear();
                        listView2.Items.Clear();
                        course_label.Text = "Project manager for " + item.Text;
                        selected_course_student = item.Text;
                        getPendingProjects(item.Text, listView1);
                      getExpiredProjectsStudents(item.Text, listView2);
                        decimal[] grade = new decimal[listView2.Items.Count];
                        for (int i = 0; i < listView2.Items.Count; i++)
                        {
                            check_submitted(item.Text, listView2.Items[i].Text, s_id);
                            check_grade(item.Text, listView2.Items[i].Text, s_id);
                            if(listView2.Items[i].SubItems[4].Text!="-")
                            grade[i] = Decimal.Parse(listView2.Items[i].SubItems[2].Text) * Decimal.Parse(listView2.Items[i].SubItems[4].Text);
                        }
                        decimal sum = 0;
                        for (int i = 0; i < grade.Length; i++)
                            sum = sum + grade[i];



                        if (sum != 0)
                        {
                            sum = sum / grade.Length;
                            grade_label.Text = "Total scaled grade: " + sum.ToString("0.0");
                        }
                        else
                            grade_label.Text = "Total scaled grade: -";


                    };

                    item.DropDownItems.Add(sub_item2);                 
                    item.DropDownItems.Add(sub_item);
                    ms.Items.Add(item);
                    
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
        }

        
        //Delete statement
        public void Delete()
        {
            string query = "DELETE FROM tableinfo WHERE name='John Smith'";

            if (this.OpenConnection() == true)
            {
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                this.CloseConnection();
            }
        }

        public bool checkUsername(string username,string password)
        {
            bool answer = false;
            string query = "SELECT * FROM student_platform.users WHERE username='"+username+"'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();
                if(dataReader.HasRows)
                {
                    while (dataReader.Read())
                    {
                        if (dataReader["password"].ToString() == password)                       
                            answer= true;                       
                        else
                            answer= false;
                    }

                }
                else              
                    answer= false;

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return answer;
        }

        public string project_file(string project,string course)
        {
            string path="";
            string query = "SELECT file_path FROM projects WHERE course ='" + course + "' and title = '" + project + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    path = dataReader["file_path"].ToString();
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }


            return path;
        }

        public string checkRole(string username)
        {
            string answer = "";
            string query = "SELECT * FROM student_platform.users WHERE username='" + username + "'";
            if (this.OpenConnection() == true)
            {
                
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();
                           
                    while (dataReader.Read())
                {
                    string role = dataReader["role_id"].ToString();
                    switch (role)
                    {
                        case "1":
                            answer= "student";
                            break;
                        case "2":
                            answer = "admin";
                            break;
                        case "3":
                            answer = "professor";
                            break;
                    }
                   
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return answer;
        }

        public void getPendingProjects(string course,ListView listview1)
        {
            string now = DateTime.Now.ToString("yyyy-MM-dd  HH:mm:ss");
            string query = "SELECT * FROM projects WHERE deadline>'" + now + "' and course = '" + course + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    var item = new ListViewItem(new[] {

                dataReader.GetValue(3).ToString(), // Title
                dataReader.GetValue(5).ToString(), // deadline
                 dataReader.GetValue(2).ToString(), // scale
                  
                   

            });
                    listview1.ShowItemToolTips = true;
                    item.ToolTipText = "Double click to edit project";
                    listview1.Items.Add(item);

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
        }


        public void getExpiredProjects(string course,ListView listview2)
        {

            string now = DateTime.Now.ToString("yyyy-MM-dd  HH:mm:ss");
            string query = "SELECT * FROM projects WHERE deadline<'" + now + "' and course = '"+course+"'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    var item = new ListViewItem(new[] {

                dataReader.GetValue(3).ToString(), // Title
                dataReader.GetValue(5).ToString(), // deadline
                 dataReader.GetValue(2).ToString(), // scale
                  
                   

            });
                    listview2.ShowItemToolTips = true;
                    item.ToolTipText = "Double click to see submitted projects";
                    listview2.Items.Add(item);

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
        }

        public void getExpiredProjectsStudents(string course, ListView listview2)
        {
            string now = DateTime.Now.ToString("yyyy-MM-dd  HH:mm:ss");
            string query = "SELECT * FROM projects WHERE deadline<'" + now + "' and course = '" + course + "'";
            //string query2 = "SELECT * FROM submitted_projects,teams WHERE teams.student_id='" + s_id + "' and course = '" + course + "'";
            string query3 = "SELECT * FROM projects WHERE deadline<'" + now + "' and course = '" + course + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    var item = new ListViewItem(new[] {

                dataReader.GetValue(3).ToString(), // Title
                dataReader.GetValue(5).ToString(), // deadline
                 dataReader.GetValue(2).ToString(), // scale
                 "NO",
                 "-", 
                   

            });
                    listview2.Items.Add(item);

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
        }

        private void check_submitted(string course,string project,string s_id)
        {
            string team = getTeam(project, course, s_id);
            string query = "SELECT * FROM submitted_projects WHERE course='" + course + "' and project_title = '" + project + "' and team = '" + team + "' ";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    for (int i = 0; i < listView2.Items.Count; i++)
                        if (listView2.Items[i].Text == project)
                            listView2.Items[i].SubItems[3].Text = "YES";
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }

        }

        private void check_grade(string course, string project, string s_id)
        {
           
            string query = "SELECT grade FROM teams WHERE course='" + course + "' and project = '" + project + "' and student_id = '" + s_id + "' ";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    if(dataReader["grade"].ToString()!="")
                        for (int i = 0; i < listView2.Items.Count; i++)
                            if (listView2.Items[i].Text == project)
                                listView2.Items[i].SubItems[4].Text = dataReader["grade"].ToString();

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
        }

        public string check_s_grade(string course, string project, string s_id)
        {

            string query = "SELECT grade FROM teams WHERE course='" + course + "' and project = '" + project + "' and student_id = '" + s_id + "' ";
            string grade = "";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    grade = dataReader["grade"].ToString();
                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return grade;
        }



        public void getSubmittedProjects(string course,string project, ListView listview)
        {
           
            string query = "SELECT * FROM submitted_projects WHERE project_title='" + project + "' and course = '" + course + "'";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    var item = new ListViewItem(new[] {

                dataReader.GetValue(3).ToString(), // team
                dataReader.GetValue(6).ToString(), // date
               
            });
                    listview.ShowItemToolTips = true;
                    item.ToolTipText = "Double click to check and score the project";
                    listview.Items.Add(item);

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
        }

        public List<List<string>> getStudentNameAndMails(string course)
        {
            List<List<string>> list1 = new List<List<string>>();
            List<string> fullname = new List<string>();
            List<string> mails =new List<string>();

            string query = "SELECT users.first_name,users.surname,users.email FROM users,selected_courses WHERE users.student_id=selected_courses.student_id AND selected_courses.course='" + course + "'";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();


                while (dataReader.Read())
                {
                    fullname.Add(dataReader.GetValue(0).ToString() + " " + dataReader.GetValue(1).ToString());
                    mails.Add(dataReader.GetValue(2).ToString());

                }
                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            list1.Add(fullname);
            list1.Add(mails);
            return list1;
        }

        //Select statement
        public List<string>[] Select()
        {
            string query = "SELECT * FROM tableinfo";

            //Create a list to store the result
            List<string>[] list = new List<string>[3];
            list[0] = new List<string>();
            list[1] = new List<string>();
            list[2] = new List<string>();

            //Open connection
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list[0].Add(dataReader["id"] + "");
                    list[1].Add(dataReader["name"] + "");
                    list[2].Add(dataReader["age"] + "");
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

                //return list to be displayed
                return list;
            }
            else
            {
                return list;
            }
        }

        public void idstudent(Form2 form2, string un)
        {
            string query = "SELECT * FROM student_platform.users WHERE username='" + un + "'";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    form2.name = dataReader["first_name"].ToString();
                    form2.surname= dataReader["surname"].ToString();
                    form2.student_id= dataReader["student_id"].ToString();
                    form2.email= dataReader["email"].ToString();
                   
                   
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
        }
        public string getTeam(string project,string course,string s_id)
        {
            string query = "SELECT team FROM student_platform.teams WHERE student_id='" + s_id + "' and course='" + course + "' and project='" + project + "'";
            string team = "";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    team = dataReader["team"].ToString();
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
            return team;
        }

        public void idprofessor(Form3 form3, string un)
        {
            string query = "SELECT * FROM student_platform.users WHERE username='" + un + "'";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    form3.name = dataReader["first_name"].ToString();
                    form3.surname = dataReader["surname"].ToString();
                    form3.email = dataReader["email"].ToString();
                    form3.id = dataReader["prof_id"].ToString();  
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
        }

        public List<string> profCourses(string id)
        {
            string query = "SELECT * FROM student_platform.courses WHERE prof_id='" + id + "'";
            List<string> list1 = new List<string>();
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list1.Add(dataReader["title"].ToString()+","+ dataReader["number_of_projects"].ToString());
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
            return list1;
        }

        public List<string> getProjectInfo(string project,string selected_course)
        {
            List<string> list1 = new List<string>();
            string query = "SELECT * FROM student_platform.projects WHERE course='" + selected_course + "' and title='"+project+"'";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list1.Add(dataReader["scale"].ToString());
                    list1.Add(dataReader["title"].ToString());
                    list1.Add(dataReader["file_path"].ToString());
                    list1.Add(dataReader["deadline"].ToString());
                    list1.Add(dataReader["info"].ToString());
                    list1.Add(dataReader["project_id"].ToString());
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

            }
            return list1;
        }

       public List<string> getTeamCount(string project,string team,string course)
        {
            List<string> list1 = new List<string>();
            string query = "SELECT users.first_name,users.surname,teams.student_id"+
           " FROM student_platform.users,student_platform.teams"+
           " WHERE  teams.student_id = users.student_id and teams.team = '"+team+"' and project = '"+project+"' and course = '"+course+"'; ";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list1.Add(dataReader["first_name"].ToString()+" " +dataReader["surname"].ToString()+" "+ dataReader["student_id"].ToString());               
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();

               

            }
            return list1;
        }

        public List<string> getAllStudentsWithoutTeam(string project,  string course)
        {
            List<string> list1 = new List<string>();
            string query = "SELECT users.first_name,users.surname,users.student_id" +
           " FROM student_platform.users" +
           " WHERE  teams.student_id = users.student_id and teams.team = '" + null + "' and project = '" + project + "' and course = '" + course + "'; ";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list1.Add(dataReader["first_name"].ToString() + " " + dataReader["surname"].ToString() + " " + dataReader["student_id"].ToString());
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();



            }
            return list1;
        }


        public List<string> getAllCourses()
        {
            List<string> list1 = new List<string>();
            string query = "SELECT distinct title FROM student_platform.courses";

            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                    list1.Add(dataReader["title"].ToString());
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();



            }
            return list1;
        }

        public string download_file(string project, string course, string team)
        {
            string query = "SELECT submitted_projects.path FROM student_platform.submitted_projects WHERE course='" + course + "' and project_title='" + project + "' and team='"+team+"'";
            string path = "";
            if (this.OpenConnection() == true)
            {
                //Create Command
                MySqlCommand cmd = new MySqlCommand(query, connection);
                //Create a data reader and Execute the command
                MySqlDataReader dataReader = cmd.ExecuteReader();

                //Read the data and store them in the list
                while (dataReader.Read())
                {
                   path= dataReader["path"].ToString();
                }

                //close Data Reader
                dataReader.Close();

                //close Connection
                this.CloseConnection();
            }
            return path;
        }

        public void set_grade(string project, string course, string team, string student_id,decimal grade)
        {
            string query = "UPDATE teams SET grade='"+grade+ "' WHERE teams.project='" + project+ "' and teams.course='" + course+ "' and teams.team='" + team+ "' and teams.student_id='" + student_id+"'";
            if (this.OpenConnection() == true)
            {
                //create mysql command
                MySqlCommand cmd = new MySqlCommand();
                //Assign the query using CommandText
                cmd.CommandText = query;
                //Assign the connection using Connection
                cmd.Connection = connection;

                //Execute query
                cmd.ExecuteNonQuery();
                //close Connection
                this.CloseConnection();
            }
        }

        public void editProject(string p_id,string title,string path,DateTime deadline,string info,decimal scale)
        {
            string query = "UPDATE projects SET scale='" + scale + "', title='"+title+ "', file_path='" + path + "', deadline='" + deadline + "', info='" + info + "' WHERE projects.project_id='" + p_id+"'";
            if (this.OpenConnection() == true)
            {
                //create mysql command
                MySqlCommand cmd = new MySqlCommand();
                //Assign the query using CommandText
                cmd.CommandText = query;
                //Assign the connection using Connection
                cmd.Connection = connection;

                //Execute query
                cmd.ExecuteNonQuery();
                //close Connection
                this.CloseConnection();
            }
        }

        //Count statement
        public int Count()
        {
            string query = "SELECT Count(*) FROM tableinfo";
            int Count = -1;

            //Open Connection
            if (this.OpenConnection() == true)
            {
                //Create Mysql Command
                MySqlCommand cmd = new MySqlCommand(query, connection);

                //ExecuteScalar will return one value
                Count = int.Parse(cmd.ExecuteScalar() + "");

                //close Connection
                this.CloseConnection();

                return Count;
            }
            else
            {
                return Count;
            }
        }

    
    }
}
