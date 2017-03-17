using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.IO;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for SmartPlan.xaml
    /// </summary>
    public partial class SmartPlan : Window
    {
        public SmartPlan()
        {
            InitializeComponent();
        }

        string current_path = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);

        string Task1 = null;
        string Task2 = null;
        string Task3 = null;
        string Task5 = null;
        string Task6 = null;
        string Task7 = null;
        string Task8 = null;

        List<string> daily_tasks = new List<string>();

        // File.WriteAllText(current_path + @"\Visual Studio 2015\Projects\SmartCity\SmartCity\data.txt", checkBox.Content.ToString() + " " + textBox.Text);

        private void textBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox.Text != " ")
            {
                Task1 = checkBox.Content.ToString() + " " + textBox.Text;
            }
            if (Task1 != null) daily_tasks.Add(Task1);
        }

        private void checkBox_Checked(object sender, RoutedEventArgs e)
        {
            textBox.IsEnabled = true;
            radioButton1.IsEnabled = true;
            radioButton2.IsEnabled = true;
            radioButton3.IsEnabled = true;
        }

        private void checkBox1_Checked(object sender, RoutedEventArgs e)
        {
            textBox1.IsEnabled = true;
            radioButton1_Copy1.IsEnabled = true;
            radioButton2_Copy1.IsEnabled = true;
            radioButton3_Copy1.IsEnabled = true;
        }

        private void checkBox2_Checked(object sender, RoutedEventArgs e)
        {
            textBox2.IsEnabled = true;
            radioButton1_Copy2.IsEnabled = true;
            radioButton2_Copy2.IsEnabled = true;
            radioButton3_Copy2.IsEnabled = true;
        }

        private void checkBox4_Checked(object sender, RoutedEventArgs e)
        {
            textBox4.IsEnabled = true;
            radioButton1_Copy3.IsEnabled = true;
            radioButton2_Copy3.IsEnabled = true;
            radioButton3_Copy3.IsEnabled = true;
        }

        private void checkBox5_Checked(object sender, RoutedEventArgs e)
        {
            textBox5.IsEnabled = true;
            radioButton1_Copy4.IsEnabled = true;
            radioButton2_Copy4.IsEnabled = true;
            radioButton3_Copy4.IsEnabled = true;
        }

        private void checkBox6_Checked(object sender, RoutedEventArgs e)
        {
            textBox6.IsEnabled = true;
            radioButton1_Copy5.IsEnabled = true;
            radioButton2_Copy5.IsEnabled = true;
            radioButton3_Copy5.IsEnabled = true;
        }

        private void checkBox7_Checked(object sender, RoutedEventArgs e)
        {
            textBox7.IsEnabled = true;
            radioButton1_Copy6.IsEnabled = true;
            radioButton2_Copy6.IsEnabled = true;
            radioButton3_Copy6.IsEnabled = true;
        }

        private void textBox8_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox8.Text != null)
            {
                checkBox5.IsEnabled = true;
                checkBox5.Content = textBox8.Text;
            }
        }

        private void textBox9_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox9.Text != null)
            {
                checkBox6.IsEnabled = true;
                checkBox6.Content = textBox9.Text;
            }
        }

        private void textBox10_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox10.Text != null)
            {
                checkBox7.IsEnabled = true;
                checkBox7.Content = textBox10.Text;
            }
        }

        private void textBox1_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox1.Text != null)
            {
                Task2 = checkBox1.Content.ToString() + " " + textBox1.Text;
            }
            if (Task2 != null) daily_tasks.Add(Task2);
        }

        private void textBox2_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox2.Text != null)
            {
                Task3 = checkBox2.Content.ToString() + " " + textBox2.Text;
            }
            if (Task3 != null) daily_tasks.Add(Task3);
        }

        private void textBox4_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox4.Text != null)
            {
                Task5 = checkBox4.Content.ToString() + " " + textBox4.Text;
            }
            if (Task5 != null) daily_tasks.Add(Task5);
        }

        private void textBox5_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox5.Text != null)
            {
                Task6 = checkBox5.Content.ToString() + " " + textBox5.Text;
            }
            if (Task6 != null) daily_tasks.Add(Task6);
        }

        private void textBox6_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox6.Text != null)
            {
                Task7 = checkBox6.Content.ToString() + " " + textBox6.Text;
            }
            if (Task7 != null) daily_tasks.Add(Task7);
        }

        private void textBox7_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBox7.Text != null)
            {
                Task8 = checkBox7.Content.ToString() + " " + textBox7.Text;
            }
            if (Task8 != null) daily_tasks.Add(Task8);
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            button1.IsEnabled = true;
            button.IsEnabled = false;
            try
            {
                foreach (string str in daily_tasks)
                    File.WriteAllText(current_path + @"\Visual Studio 2015\Projects\SmartCity\SmartCity\data.txt", str + Environment.NewLine);
            }
            catch (NullReferenceException ex)
            {
                Console.WriteLine("{0} Exception caught.", ex);
            }
            
        }

        private void radioButton1_Checked(object sender, RoutedEventArgs e)
        {

        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            Navigation navigation = new Navigation();
            navigation.Show();
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            Citizen citizen = new Citizen();
            citizen.Show();
            this.Hide();
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button2.ToolTip.ToString());
        }
    }
}
